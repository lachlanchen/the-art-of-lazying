#Requires -Version 5.1
[CmdletBinding()]
param(
    [switch]$EnableRecovery,

    [string]$SqlitePath,

    [ValidateRange(1, 20)]
    [int]$ProbeCount = 5,

    [ValidateRange(250, 10000)]
    [int]$ProbeTimeoutMilliseconds = 2000,

    [ValidateRange(1, 120)]
    [int]$ProbeIntervalSeconds = 10,

    [ValidateRange(30, 600)]
    [int]$StartupGraceSeconds = 120,

    [ValidateRange(5, 120)]
    [int]$TransferRecheckSeconds = 15
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$mode = if ($EnableRecovery) { 'RecoveryEnabled' } else { 'ObserveOnly' }
$expectedRoot = [IO.Path]::GetFullPath(
    (Join-Path $env:APPDATA 'baidu\BaiduNetdisk')
).TrimEnd('\')
$expectedRootPrefix = $expectedRoot + '\'
$expectedBrowser = Join-Path $expectedRoot 'module\BrowserEngine\BaiduNetdiskUnite.exe'
$baiduProcessNames = @(
    'BaiduNetdisk',
    'BaiduNetdiskUnite',
    'baidunetdiskhost',
    'YunDetectService'
)
$launcherPath = Join-Path $PSScriptRoot 'Launch-BaiduNetdiskFixed.ps1'
$dataRoot = Join-Path $env:LOCALAPPDATA 'BaiduNetdiskWatchdog'
$statePath = Join-Path $dataRoot 'state.json'
$logPath = Join-Path $dataRoot 'events.jsonl'
$snapshotPath = Join-Path $dataRoot 'last-snapshot.json'
$runLockPath = Join-Path $dataRoot 'run.lock'
$logLimitBytes = 262144
$logRetainedLines = 500
$script:CurrentUiPid = $null

function Write-AtomicUtf8Text {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Text
    )

    $directory = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    $temporaryPath = Join-Path $directory ('.tmp-' + [Guid]::NewGuid().ToString('N'))
    $backupPath = Join-Path $directory ('.bak-' + [Guid]::NewGuid().ToString('N'))
    $encoding = New-Object System.Text.UTF8Encoding($false)
    try {
        [IO.File]::WriteAllText($temporaryPath, $Text, $encoding)
        if (Test-Path -LiteralPath $Path) {
            # Windows PowerShell 5.1/.NET Framework rejects a null backup path
            # with "The path is not of a legal form." A same-directory backup
            # keeps replacement atomic and is removed immediately afterward.
            [IO.File]::Replace($temporaryPath, $Path, $backupPath)
        } else {
            [IO.File]::Move($temporaryPath, $Path)
        }
    } finally {
        if (Test-Path -LiteralPath $temporaryPath) {
            Remove-Item -LiteralPath $temporaryPath -Force -ErrorAction SilentlyContinue
        }
        if (Test-Path -LiteralPath $backupPath) {
            Remove-Item -LiteralPath $backupPath -Force -ErrorAction SilentlyContinue
        }
    }
}

function Limit-EventLog {
    if (-not (Test-Path -LiteralPath $logPath)) {
        return
    }

    $item = Get-Item -LiteralPath $logPath
    if ($item.Length -le $logLimitBytes) {
        return
    }

    $lines = @([IO.File]::ReadAllLines($logPath))
    if ($lines.Count -gt $logRetainedLines) {
        $lines = @($lines | Select-Object -Last $logRetainedLines)
    }

    $encoding = New-Object System.Text.UTF8Encoding($false)
    while ($lines.Count -gt 1) {
        $candidate = ($lines -join [Environment]::NewLine) + [Environment]::NewLine
        if ($encoding.GetByteCount($candidate) -le $logLimitBytes) {
            break
        }
        $lines = @($lines | Select-Object -Skip 1)
    }

    Write-AtomicUtf8Text -Path $logPath -Text (
        ($lines -join [Environment]::NewLine) + [Environment]::NewLine
    )
}

function Write-WatchdogEvent {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Event,

        [Parameter(Mandatory = $true)]
        [string]$Reason
    )

    try {
        if (-not (Test-Path -LiteralPath $dataRoot)) {
            New-Item -ItemType Directory -Path $dataRoot -Force | Out-Null
        }
        $record = [ordered]@{
            Version = 1
            Utc = [DateTimeOffset]::UtcNow.ToString('o')
            Mode = $mode
            Event = $Event
            Reason = $Reason
            WatchdogPid = $PID
            UiPid = $script:CurrentUiPid
        }
        $line = $record | ConvertTo-Json -Compress
        $encoding = New-Object System.Text.UTF8Encoding($false)
        [IO.File]::AppendAllText(
            $logPath,
            $line + [Environment]::NewLine,
            $encoding
        )
        Limit-EventLog
    } catch {
        # Logging must never turn an observation into a recovery.
    }
}

function Write-RunResult {
    param(
        [string]$Status,
        [string]$Reason
    )

    [pscustomobject]@{
        Mode = $mode
        Status = $Status
        Reason = $Reason
        UiPid = $script:CurrentUiPid
    }
}

if (-not ('BaiduWatchdogNativeMethods' -as [type])) {
    Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

public static class BaiduWatchdogNativeMethods
{
    public delegate bool EnumWindowsProc(IntPtr window, IntPtr state);

    [StructLayout(LayoutKind.Sequential)]
    public struct Rect
    {
        public int Left;
        public int Top;
        public int Right;
        public int Bottom;
    }

    [DllImport("user32.dll")]
    public static extern bool EnumWindows(EnumWindowsProc callback, IntPtr state);

    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr window, out uint processId);

    [DllImport("user32.dll")]
    public static extern bool IsWindowVisible(IntPtr window);

    [DllImport("user32.dll")]
    public static extern bool GetWindowRect(IntPtr window, out Rect rect);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr SendMessageTimeout(
        IntPtr window,
        uint message,
        UIntPtr wParam,
        IntPtr lParam,
        uint flags,
        uint timeoutMilliseconds,
        out UIntPtr result
    );
}
'@
}

function Get-BaiduUiState {
    param([switch]$SkipStartupGrace)

    $allProcesses = @(Get-Process -Name 'BaiduNetdiskUnite' -ErrorAction SilentlyContinue | Where-Object {
        try { -not $_.HasExited } catch { $false }
    })
    if ($allProcesses.Count -eq 0) {
        return [pscustomobject]@{ Status = 'Absent' }
    }

    $trustedProcesses = New-Object 'System.Collections.Generic.List[object]'
    foreach ($process in $allProcesses) {
        try {
            $processPath = [IO.Path]::GetFullPath($process.Path)
            if ($processPath.Equals($expectedBrowser, [StringComparison]::OrdinalIgnoreCase)) {
                $trustedProcesses.Add($process)
            } else {
                return [pscustomobject]@{ Status = 'Ambiguous' }
            }
        } catch {
            return [pscustomobject]@{ Status = 'Ambiguous' }
        }
    }

    $processById = @{}
    foreach ($process in $trustedProcesses) {
        $processById[[int]$process.Id] = $process
    }

    $windows = New-Object 'System.Collections.Generic.List[object]'
    [BaiduWatchdogNativeMethods]::EnumWindows({
        param($window, $state)

        [uint32]$ownerProcessId = 0
        [BaiduWatchdogNativeMethods]::GetWindowThreadProcessId(
            $window,
            [ref]$ownerProcessId
        ) | Out-Null
        if ($processById.ContainsKey([int]$ownerProcessId) -and
            [BaiduWatchdogNativeMethods]::IsWindowVisible($window)) {
            $rect = New-Object 'BaiduWatchdogNativeMethods+Rect'
            [BaiduWatchdogNativeMethods]::GetWindowRect($window, [ref]$rect) | Out-Null
            $windows.Add([pscustomobject]@{
                Handle = $window
                ProcessId = [int]$ownerProcessId
                Width = [Math]::Max(0, $rect.Right - $rect.Left)
                Height = [Math]::Max(0, $rect.Bottom - $rect.Top)
            })
        }
        return $true
    }, [IntPtr]::Zero) | Out-Null

    if ($windows.Count -eq 0) {
        return [pscustomobject]@{ Status = 'Hidden' }
    }

    $ownerIds = @($windows | Select-Object -ExpandProperty ProcessId -Unique)
    if ($ownerIds.Count -ne 1) {
        return [pscustomobject]@{ Status = 'Ambiguous' }
    }

    $owner = $processById[[int]$ownerIds[0]]
    try {
        $startUtc = $owner.StartTime.ToUniversalTime()
        $ageSeconds = [Math]::Max(0, ([DateTime]::UtcNow - $startUtc).TotalSeconds)
        $privateMemoryMb = [Math]::Round($owner.PrivateMemorySize64 / 1MB, 1)
        $workingSetMb = [Math]::Round($owner.WorkingSet64 / 1MB, 1)
    } catch {
        return [pscustomobject]@{ Status = 'Changed' }
    }

    if (-not $SkipStartupGrace -and $ageSeconds -lt $StartupGraceSeconds) {
        return [pscustomobject]@{
            Status = 'Starting'
            ProcessId = [int]$owner.Id
            AgeSeconds = [Math]::Floor($ageSeconds)
        }
    }

    $primaryWindow = $windows | Sort-Object -Property @{
        Expression = { [int64]$_.Width * [int64]$_.Height }
        Descending = $true
    } | Select-Object -First 1

    [pscustomobject]@{
        Status = 'Ready'
        ProcessId = [int]$owner.Id
        ProcessStartUtc = $startUtc
        AgeSeconds = [Math]::Floor($ageSeconds)
        WindowCount = $windows.Count
        Handle = [IntPtr]$primaryWindow.Handle
        PrivateMemoryMb = $privateMemoryMb
        WorkingSetMb = $workingSetMb
    }
}

function Test-BaiduProcessScope {
    param([int]$ExpectedUiProcessId)

    try {
        $processes = @(Get-Process -ErrorAction Stop | Where-Object {
            $_.ProcessName -in $baiduProcessNames
        })
        if ($processes.Count -eq 0 -or
            @($processes | Where-Object { $_.Id -eq $ExpectedUiProcessId }).Count -ne 1) {
            return [pscustomobject]@{ Safe = $false; Reason = 'ProcessScopeChanged' }
        }

        foreach ($process in $processes) {
            if ($process.HasExited -or [string]::IsNullOrWhiteSpace($process.Path)) {
                return [pscustomobject]@{ Safe = $false; Reason = 'ProcessPathInaccessible' }
            }
            $processPath = [IO.Path]::GetFullPath($process.Path)
            if (-not $processPath.StartsWith(
                $expectedRootPrefix,
                [StringComparison]::OrdinalIgnoreCase
            )) {
                return [pscustomobject]@{ Safe = $false; Reason = 'ProcessOutsideCheckedRoot' }
            }
        }
    } catch {
        return [pscustomobject]@{ Safe = $false; Reason = 'ProcessPathInaccessible' }
    }

    [pscustomobject]@{ Safe = $true; Reason = 'CheckedProcessScope' }
}

function Test-WindowMessage {
    param([IntPtr]$Window)

    [UIntPtr]$result = [UIntPtr]::Zero
    $returnValue = [BaiduWatchdogNativeMethods]::SendMessageTimeout(
        $Window,
        0,
        [UIntPtr]::Zero,
        [IntPtr]::Zero,
        3,
        [uint32]$ProbeTimeoutMilliseconds,
        [ref]$result
    )
    $returnValue -ne [IntPtr]::Zero
}

function Test-AllInitialProbesFailed {
    param([IntPtr]$Window)

    $stopwatch = [Diagnostics.Stopwatch]::StartNew()
    $spacingMilliseconds = $ProbeIntervalSeconds * 1000.0
    for ($probe = 0; $probe -lt $ProbeCount; $probe++) {
        $targetMilliseconds = [int][Math]::Floor($probe * $spacingMilliseconds)
        $delayMilliseconds = $targetMilliseconds - [int]$stopwatch.ElapsedMilliseconds
        if ($delayMilliseconds -gt 0) {
            Start-Sleep -Milliseconds $delayMilliseconds
        }
        if (Test-WindowMessage -Window $Window) {
            return $false
        }
    }
    return $true
}

function Write-NonPrivateSnapshot {
    param([object]$UiState)

    $snapshot = [ordered]@{
        Version = 1
        CapturedUtc = [DateTimeOffset]::UtcNow.ToString('o')
        Mode = $mode
        Finding = 'AllUiProbesTimedOut'
        UiPid = $UiState.ProcessId
        UiAgeSeconds = $UiState.AgeSeconds
        VisibleWindowCount = $UiState.WindowCount
        ProbeCount = $ProbeCount
        ProbeTimeoutMilliseconds = $ProbeTimeoutMilliseconds
        ProbeIntervalSeconds = $ProbeIntervalSeconds
        PrivateMemoryMb = $UiState.PrivateMemoryMb
        WorkingSetMb = $UiState.WorkingSetMb
    }
    Write-AtomicUtf8Text -Path $snapshotPath -Text (
        ($snapshot | ConvertTo-Json -Depth 3) + [Environment]::NewLine
    )
}

function New-WatchdogState {
    [pscustomobject]@{
        Version = 1
        RecoveryUtc = @()
        SuppressedUntilUtc = $null
        LastAttemptUtc = $null
        LastAttemptResult = $null
    }
}

function Read-WatchdogState {
    if (-not (Test-Path -LiteralPath $statePath)) {
        return [pscustomobject]@{
            Valid = $true
            State = New-WatchdogState
            Reason = 'NewState'
        }
    }

    try {
        $raw = [IO.File]::ReadAllText($statePath)
        $parsed = $raw | ConvertFrom-Json
        $propertyNames = @($parsed.PSObject.Properties.Name)
        foreach ($required in @(
            'Version',
            'RecoveryUtc',
            'SuppressedUntilUtc',
            'LastAttemptUtc',
            'LastAttemptResult'
        )) {
            if ($propertyNames -notcontains $required) {
                throw 'Missing state property.'
            }
        }
        if ([int]$parsed.Version -ne 1) {
            throw 'Unsupported state version.'
        }

        $normalizedRecoveryUtc = New-Object 'System.Collections.Generic.List[string]'
        foreach ($value in @($parsed.RecoveryUtc)) {
            if ($null -eq $value) {
                continue
            }
            $timestamp = [DateTimeOffset]::ParseExact(
                [string]$value,
                'o',
                [Globalization.CultureInfo]::InvariantCulture,
                [Globalization.DateTimeStyles]::RoundtripKind
            )
            $normalizedRecoveryUtc.Add($timestamp.ToUniversalTime().ToString('o'))
        }

        $suppressedUntilUtc = $null
        if ($null -ne $parsed.SuppressedUntilUtc -and
            -not [string]::IsNullOrWhiteSpace([string]$parsed.SuppressedUntilUtc)) {
            $suppression = [DateTimeOffset]::ParseExact(
                [string]$parsed.SuppressedUntilUtc,
                'o',
                [Globalization.CultureInfo]::InvariantCulture,
                [Globalization.DateTimeStyles]::RoundtripKind
            )
            $suppressedUntilUtc = $suppression.ToUniversalTime().ToString('o')
        }

        return [pscustomobject]@{
            Valid = $true
            State = [pscustomobject]@{
                Version = 1
                RecoveryUtc = @($normalizedRecoveryUtc)
                SuppressedUntilUtc = $suppressedUntilUtc
                LastAttemptUtc = $parsed.LastAttemptUtc
                LastAttemptResult = $parsed.LastAttemptResult
            }
            Reason = 'Loaded'
        }
    } catch {
        return [pscustomobject]@{
            Valid = $false
            State = $null
            Reason = 'StateUnreadable'
        }
    }
}

function Write-WatchdogState {
    param([object]$State)

    Write-AtomicUtf8Text -Path $statePath -Text (
        ($State | ConvertTo-Json -Depth 4) + [Environment]::NewLine
    )
}

function Test-RecoveryRateLimit {
    param(
        [object]$State,
        [DateTimeOffset]$Now
    )

    try {
        $timestamps = @($State.RecoveryUtc | ForEach-Object {
            [DateTimeOffset]::ParseExact(
                [string]$_,
                'o',
                [Globalization.CultureInfo]::InvariantCulture,
                [Globalization.DateTimeStyles]::RoundtripKind
            ).ToUniversalTime()
        })
        if ($State.SuppressedUntilUtc) {
            $suppressedUntil = [DateTimeOffset]::ParseExact(
                [string]$State.SuppressedUntilUtc,
                'o',
                [Globalization.CultureInfo]::InvariantCulture,
                [Globalization.DateTimeStyles]::RoundtripKind
            ).ToUniversalTime()
            if ($Now -lt $suppressedUntil) {
                return [pscustomobject]@{ Allowed = $false; Reason = 'FailureSuppression6h' }
            }
        }
    } catch {
        return [pscustomobject]@{ Allowed = $false; Reason = 'StateTimestampAmbiguous' }
    }

    if (@($timestamps | Where-Object { $_ -gt $Now.AddMinutes(-30) }).Count -ge 1) {
        return [pscustomobject]@{ Allowed = $false; Reason = 'RateLimit30m' }
    }
    if (@($timestamps | Where-Object { $_ -gt $Now.AddHours(-6) }).Count -ge 2) {
        return [pscustomobject]@{ Allowed = $false; Reason = 'RateLimit6h' }
    }
    if (@($timestamps | Where-Object { $_ -gt $Now.AddHours(-24) }).Count -ge 3) {
        return [pscustomobject]@{ Allowed = $false; Reason = 'RateLimit24h' }
    }

    [pscustomobject]@{ Allowed = $true; Reason = 'Allowed' }
}

function Resolve-SafeSqlite {
    if (-not [string]::IsNullOrWhiteSpace($SqlitePath)) {
        try {
            $resolved = (Resolve-Path -LiteralPath $SqlitePath).Path
            $item = Get-Item -LiteralPath $resolved
            if ($item.PSIsContainer -or
                $item.Name -ine 'sqlite3.exe' -or
                $item.Extension -ne '.exe') {
                throw 'Not an executable file.'
            }
            $signature = Get-AuthenticodeSignature -LiteralPath $resolved
            if ($signature.Status -ne 'Valid') {
                throw 'The explicit sqlite3.exe signature is not valid.'
            }
            return [pscustomobject]@{ Valid = $true; Path = $resolved; Trust = 'ExplicitSigned' }
        } catch {
            return [pscustomobject]@{ Valid = $false; Path = $null; Trust = 'ExplicitInvalid' }
        }
    }

    $candidates = @(Get-Command sqlite3.exe -CommandType Application -All -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Source -Unique)
    foreach ($candidate in $candidates) {
        try {
            $signature = Get-AuthenticodeSignature -LiteralPath $candidate
            if ($signature.Status -eq 'Valid') {
                return [pscustomobject]@{
                    Valid = $true
                    Path = [IO.Path]::GetFullPath($candidate)
                    Trust = 'AutoDiscoveredSigned'
                }
            }
        } catch {
        }
    }

    [pscustomobject]@{ Valid = $false; Path = $null; Trust = 'NoSignedCandidate' }
}

function Quote-NativePathArgument {
    param([string]$Path)

    if ($Path.IndexOf('"') -ge 0) {
        throw 'A native executable path contains an invalid quote.'
    }
    '"' + $Path + '"'
}

function Invoke-SqliteQuery {
    param(
        [string]$Executable,
        [string]$DatabasePath,
        [string]$Sql
    )

    $process = $null
    try {
        $startInfo = New-Object Diagnostics.ProcessStartInfo
        $startInfo.FileName = $Executable
        $startInfo.Arguments = '-readonly -batch -noheader -separator "|" ' +
            (Quote-NativePathArgument -Path $DatabasePath)
        $startInfo.UseShellExecute = $false
        $startInfo.CreateNoWindow = $true
        $startInfo.RedirectStandardInput = $true
        $startInfo.RedirectStandardOutput = $true
        $startInfo.RedirectStandardError = $true

        $process = New-Object Diagnostics.Process
        $process.StartInfo = $startInfo
        if (-not $process.Start()) {
            throw 'sqlite3 did not start.'
        }
        $outputTask = $process.StandardOutput.ReadToEndAsync()
        $errorTask = $process.StandardError.ReadToEndAsync()
        # The first SQL PRAGMA safely absorbs Windows PowerShell 5.1's UTF-8
        # BOM; the following sqlite dot-command can then set its 250 ms timeout.
        $process.StandardInput.Write($Sql)
        $process.StandardInput.Close()

        if (-not $process.WaitForExit(10000)) {
            try { $process.Kill() } catch {}
            $process.WaitForExit()
            return [pscustomobject]@{ Success = $false; Lines = @(); Reason = 'SqliteTimeout' }
        }

        $standardOutput = $outputTask.GetAwaiter().GetResult()
        $standardError = $errorTask.GetAwaiter().GetResult()
        if ($process.ExitCode -ne 0 -or
            -not [string]::IsNullOrWhiteSpace($standardError) -or
            $standardOutput.Length -gt 65536) {
            return [pscustomobject]@{ Success = $false; Lines = @(); Reason = 'SqliteError' }
        }

        $lines = @($standardOutput -split "`r?`n" | Where-Object { $_.Length -gt 0 })
        [pscustomobject]@{ Success = $true; Lines = $lines; Reason = 'Ok' }
    } catch {
        [pscustomobject]@{ Success = $false; Lines = @(); Reason = 'SqliteException' }
    } finally {
        if ($null -ne $process) {
            $process.Dispose()
        }
    }
}

function Get-DatabaseStamp {
    param([string]$DatabasePath)

    $parts = New-Object 'System.Collections.Generic.List[string]'
    foreach ($suffix in @('', '-wal', '-shm', '-journal')) {
        $candidate = $DatabasePath + $suffix
        if (Test-Path -LiteralPath $candidate) {
            $item = Get-Item -LiteralPath $candidate
            $parts.Add($suffix + ':' + $item.Length + ':' + $item.LastWriteTimeUtc.Ticks)
        } else {
            $parts.Add($suffix + ':absent')
        }
    }
    $parts -join ','
}

function Get-TransferGuardSnapshot {
    param([string]$Executable)

    $usersRoot = Join-Path $expectedRoot 'module\BrowserEngine\users'
    if (-not (Test-Path -LiteralPath $usersRoot)) {
        return [pscustomobject]@{ Safe = $false; Reason = 'TransferProfileMissing'; Canonical = $null }
    }

    $profiles = @(Get-ChildItem -LiteralPath $usersRoot -Directory -ErrorAction Stop |
        Where-Object { $_.Name -match '^[0-9a-fA-F]{32}$' } |
        Sort-Object -Property Name)
    if ($profiles.Count -eq 0) {
        return [pscustomobject]@{ Safe = $false; Reason = 'TransferProfileAmbiguous'; Canonical = $null }
    }

    $transmissionSql = @'
PRAGMA query_only=ON;
.timeout 250
SELECT 'objects=' || group_concat(type || ':' || name, ',') FROM (SELECT type, name FROM sqlite_master WHERE type IN ('table','view') ORDER BY type, name);
SELECT 'schema_version=' || schema_version FROM pragma_schema_version;
SELECT 'download_file=' || count(*) FROM download_file;
SELECT 'upload_file=' || count(*) FROM upload_file;
'@
    $uploadSql = @'
PRAGMA query_only=ON;
.timeout 250
SELECT 'objects=' || group_concat(type || ':' || name, ',') FROM (SELECT type, name FROM sqlite_master WHERE type IN ('table','view') ORDER BY type, name);
SELECT 'schema_version=' || schema_version FROM pragma_schema_version;
SELECT 'upload_file=' || count(*) FROM upload_file;
'@
    $deviceDownloadSql = @'
PRAGMA query_only=ON;
.timeout 250
SELECT 'objects=' || group_concat(type || ':' || name, ',') FROM (SELECT type, name FROM sqlite_master WHERE type IN ('table','view') ORDER BY type, name);
SELECT 'schema_version=' || schema_version FROM pragma_schema_version;
SELECT 'devicedownload_file=' || count(*) FROM devicedownload_file;
'@
    $syncStatusSql = @'
PRAGMA query_only=ON;
.timeout 250
SELECT 'objects=' || group_concat(type || ':' || name, ',') FROM (SELECT type, name FROM sqlite_master WHERE type IN ('table','view') ORDER BY type, name);
SELECT 'schema_version=' || schema_version FROM pragma_schema_version;
SELECT 'sync_status=' || count(*) FROM sync_status;
'@
    $expectedTransmissionObjects = 'objects=table:backup_file,table:download_file,table:download_history_file,table:upload_file,table:upload_history_file,table:version'
    $expectedUploadObjects = 'objects=table:upload_file,table:upload_history_file,table:version'
    $expectedDeviceDownloadObjects = 'objects=table:devicedownload_file,table:version'
    $expectedSyncStatusObjects = 'objects=table:sync_status,table:version'
    $canonicalParts = New-Object 'System.Collections.Generic.List[string]'

    foreach ($profile in $profiles) {
        $transmissionDb = Join-Path $profile.FullName 'transmission.db'
        $uploadDb = Join-Path $profile.FullName 'upload.db'
        $deviceDownloadDb = Join-Path $profile.FullName 'BaiduYunDevice.db'
        if (-not (Test-Path -LiteralPath $transmissionDb) -or
            -not (Test-Path -LiteralPath $uploadDb) -or
            -not (Test-Path -LiteralPath $deviceDownloadDb)) {
            return [pscustomobject]@{ Safe = $false; Reason = 'TransferDatabaseAmbiguous'; Canonical = $null }
        }

        $syncCandidates = @(Get-ChildItem -LiteralPath $profile.FullName -File -ErrorAction Stop |
            Where-Object { $_.Name -match '^S[0-9a-fA-F]{32}\.db$' })
        if (@($syncCandidates | Where-Object {
            $_.Name -cnotmatch '^S[0-9a-f]{32}\.db$'
        }).Count -gt 0) {
            return [pscustomobject]@{ Safe = $false; Reason = 'TransferSchemaAmbiguous'; Canonical = $null }
        }
        $syncDatabases = @($syncCandidates | Where-Object {
            $_.Name -cmatch '^S[0-9a-f]{32}\.db$'
        } | Sort-Object -Property Name)

        $transmission = Invoke-SqliteQuery -Executable $Executable -DatabasePath $transmissionDb -Sql $transmissionSql
        $upload = Invoke-SqliteQuery -Executable $Executable -DatabasePath $uploadDb -Sql $uploadSql
        $deviceDownload = Invoke-SqliteQuery -Executable $Executable -DatabasePath $deviceDownloadDb -Sql $deviceDownloadSql
        if (-not $transmission.Success -or
            -not $upload.Success -or
            -not $deviceDownload.Success) {
            return [pscustomobject]@{ Safe = $false; Reason = 'TransferQueryError'; Canonical = $null }
        }

        if ($transmission.Lines.Count -ne 4 -or
            $transmission.Lines[0] -cne $expectedTransmissionObjects -or
            $transmission.Lines[1] -notmatch '^schema_version=[0-9]+$' -or
            $transmission.Lines[2] -notmatch '^download_file=([0-9]+)$' -or
            $transmission.Lines[3] -notmatch '^upload_file=([0-9]+)$' -or
            $upload.Lines.Count -ne 3 -or
            $upload.Lines[0] -cne $expectedUploadObjects -or
            $upload.Lines[1] -notmatch '^schema_version=[0-9]+$' -or
            $upload.Lines[2] -notmatch '^upload_file=([0-9]+)$' -or
            $deviceDownload.Lines.Count -ne 3 -or
            $deviceDownload.Lines[0] -cne $expectedDeviceDownloadObjects -or
            $deviceDownload.Lines[1] -notmatch '^schema_version=[0-9]+$' -or
            $deviceDownload.Lines[2] -notmatch '^devicedownload_file=([0-9]+)$') {
            return [pscustomobject]@{ Safe = $false; Reason = 'TransferSchemaAmbiguous'; Canonical = $null }
        }

        $downloadCount = [int64]($transmission.Lines[2] -replace '^download_file=', '')
        $transmissionUploadCount = [int64]($transmission.Lines[3] -replace '^upload_file=', '')
        $legacyUploadCount = [int64]($upload.Lines[2] -replace '^upload_file=', '')
        $deviceDownloadCount = [int64]($deviceDownload.Lines[2] -replace '^devicedownload_file=', '')
        if ($downloadCount -gt 0 -or
            $transmissionUploadCount -gt 0 -or
            $legacyUploadCount -gt 0 -or
            $deviceDownloadCount -gt 0) {
            return [pscustomobject]@{ Safe = $false; Reason = 'ActiveTransferRows'; Canonical = $null }
        }

        # Profile identifiers remain in memory only and never enter logs or snapshots.
        $profileParts = New-Object 'System.Collections.Generic.List[string]'
        $profileParts.Add(
            ($transmission.Lines -join ';') + '|' +
            (Get-DatabaseStamp -DatabasePath $transmissionDb) + '|' +
            ($upload.Lines -join ';') + '|' +
            (Get-DatabaseStamp -DatabasePath $uploadDb) + '|' +
            ($deviceDownload.Lines -join ';') + '|' +
            (Get-DatabaseStamp -DatabasePath $deviceDownloadDb)
        )
        foreach ($syncDatabase in $syncDatabases) {
            $syncStatus = Invoke-SqliteQuery -Executable $Executable -DatabasePath $syncDatabase.FullName -Sql $syncStatusSql
            if (-not $syncStatus.Success) {
                return [pscustomobject]@{ Safe = $false; Reason = 'TransferQueryError'; Canonical = $null }
            }
            if ($syncStatus.Lines.Count -ne 3 -or
                $syncStatus.Lines[0] -cne $expectedSyncStatusObjects -or
                $syncStatus.Lines[1] -notmatch '^schema_version=[0-9]+$' -or
                $syncStatus.Lines[2] -notmatch '^sync_status=([0-9]+)$') {
                return [pscustomobject]@{ Safe = $false; Reason = 'TransferSchemaAmbiguous'; Canonical = $null }
            }
            $syncStatusCount = [int64]($syncStatus.Lines[2] -replace '^sync_status=', '')
            if ($syncStatusCount -gt 0) {
                return [pscustomobject]@{ Safe = $false; Reason = 'ActiveTransferRows'; Canonical = $null }
            }
            $profileParts.Add(
                $syncDatabase.Name + '|' +
                ($syncStatus.Lines -join ';') + '|' +
                (Get-DatabaseStamp -DatabasePath $syncDatabase.FullName)
            )
        }
        $canonicalParts.Add($profile.Name + '|' + ($profileParts -join '|'))
    }

    [pscustomobject]@{
        Safe = $true
        Reason = 'NoActiveTransfers'
        Canonical = $canonicalParts -join "`n"
    }
}

function Test-NoActiveTransfersTwice {
    $sqlite = Resolve-SafeSqlite
    if (-not $sqlite.Valid) {
        return [pscustomobject]@{ Safe = $false; Reason = 'TrustedSqliteUnavailable' }
    }

    $first = Get-TransferGuardSnapshot -Executable $sqlite.Path
    if (-not $first.Safe) {
        return [pscustomobject]@{ Safe = $false; Reason = $first.Reason }
    }

    Start-Sleep -Seconds $TransferRecheckSeconds
    $second = Get-TransferGuardSnapshot -Executable $sqlite.Path
    if (-not $second.Safe) {
        return [pscustomobject]@{ Safe = $false; Reason = $second.Reason }
    }
    if (-not $first.Canonical.Equals($second.Canonical, [StringComparison]::Ordinal)) {
        return [pscustomobject]@{ Safe = $false; Reason = 'TransferStateChanged' }
    }

    [pscustomobject]@{ Safe = $true; Reason = 'NoActiveTransfersStable' }
}

function Test-Launcher {
    if (-not (Test-Path -LiteralPath $launcherPath)) {
        return $false
    }
    try {
        $resolvedLauncher = (Resolve-Path -LiteralPath $launcherPath).Path
        $resolvedDirectory = [IO.Path]::GetFullPath((Split-Path -Parent $resolvedLauncher)).TrimEnd('\')
        $resolvedScriptRoot = [IO.Path]::GetFullPath($PSScriptRoot).TrimEnd('\')
        if (-not $resolvedDirectory.Equals($resolvedScriptRoot, [StringComparison]::OrdinalIgnoreCase)) {
            return $false
        }
        $tokens = $null
        $parseErrors = $null
        [Management.Automation.Language.Parser]::ParseFile(
            $resolvedLauncher,
            [ref]$tokens,
            [ref]$parseErrors
        ) | Out-Null
        return @($parseErrors).Count -eq 0
    } catch {
        return $false
    }
}

function Invoke-CheckedLauncher {
    param([int]$ExpectedProcessId)

    $powershell = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
    if (-not (Test-Launcher) -or -not (Test-Path -LiteralPath $powershell)) {
        return [pscustomobject]@{ Success = $false; Reason = 'CheckedLauncherUnavailable' }
    }

    $process = $null
    try {
        $startInfo = New-Object Diagnostics.ProcessStartInfo
        $startInfo.FileName = $powershell
        $startInfo.Arguments = '-NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File ' +
            (Quote-NativePathArgument -Path $launcherPath) +
            ' -ForceRestart -RequireExistingUiProcessId ' + $ExpectedProcessId
        $startInfo.WorkingDirectory = $PSScriptRoot
        $startInfo.UseShellExecute = $false
        $startInfo.CreateNoWindow = $true
        $startInfo.RedirectStandardOutput = $true
        $startInfo.RedirectStandardError = $true
        $process = New-Object Diagnostics.Process
        $process.StartInfo = $startInfo
        if (-not $process.Start()) {
            throw 'Launcher did not start.'
        }
        $outputTask = $process.StandardOutput.ReadToEndAsync()
        $errorTask = $process.StandardError.ReadToEndAsync()
        if (-not $process.WaitForExit(90000)) {
            try { $process.Kill() } catch {}
            $process.WaitForExit()
            return [pscustomobject]@{ Success = $false; Reason = 'LauncherTimeout' }
        }
        $outputTask.GetAwaiter().GetResult() | Out-Null
        $errorTask.GetAwaiter().GetResult() | Out-Null
        if ($process.ExitCode -ne 0) {
            return [pscustomobject]@{ Success = $false; Reason = 'LauncherFailed' }
        }
        [pscustomobject]@{ Success = $true; Reason = 'LauncherCompleted' }
    } catch {
        [pscustomobject]@{ Success = $false; Reason = 'LauncherException' }
    } finally {
        if ($null -ne $process) {
            $process.Dispose()
        }
    }
}

function Test-NewUiHealthy {
    param(
        [int]$OldProcessId,
        [DateTime]$OldProcessStartUtc
    )

    $deadline = [DateTime]::UtcNow.AddSeconds(45)
    $newProcessId = $null
    $newStartUtc = $null
    while ([DateTime]::UtcNow -lt $deadline) {
        $candidate = Get-BaiduUiState -SkipStartupGrace
        if ($candidate.Status -eq 'Ready' -and
            $candidate.ProcessId -ne $OldProcessId -and
            $candidate.ProcessStartUtc -gt $OldProcessStartUtc) {
            $newProcessId = $candidate.ProcessId
            $newStartUtc = $candidate.ProcessStartUtc
            break
        }
        Start-Sleep -Seconds 1
    }
    if ($null -eq $newProcessId) {
        return $false
    }

    for ($probe = 0; $probe -lt 6; $probe++) {
        if ($probe -gt 0) {
            Start-Sleep -Seconds 5
        }
        $candidate = Get-BaiduUiState -SkipStartupGrace
        if ($candidate.Status -ne 'Ready' -or
            $candidate.ProcessId -ne $newProcessId -or
            $candidate.ProcessStartUtc -ne $newStartUtc -or
            -not (Test-WindowMessage -Window $candidate.Handle)) {
            return $false
        }
    }
    return $true
}

function Set-FailedRecoveryState {
    param(
        [object]$State,
        [string]$Result
    )

    try {
        $State.LastAttemptResult = $Result
        Write-WatchdogState -State $State
    } catch {
        # The six-hour suppression was written before the launcher ran.
    }
}

function Invoke-WatchdogMain {
    $ui = Get-BaiduUiState
    if ($ui.Status -ne 'Ready') {
        Write-WatchdogEvent -Event 'Ignored' -Reason $ui.Status
        Write-RunResult -Status 'Ignored' -Reason $ui.Status
        return
    }

    $script:CurrentUiPid = $ui.ProcessId
    if (-not (Test-AllInitialProbesFailed -Window $ui.Handle)) {
        Write-WatchdogEvent -Event 'Healthy' -Reason 'UiResponded'
        Write-RunResult -Status 'Healthy' -Reason 'UiResponded'
        return
    }

    $afterProbes = Get-BaiduUiState
    if ($afterProbes.Status -ne 'Ready' -or
        $afterProbes.ProcessId -ne $ui.ProcessId -or
        $afterProbes.ProcessStartUtc -ne $ui.ProcessStartUtc -or
        $afterProbes.Handle -ne $ui.Handle) {
        Write-WatchdogEvent -Event 'Deferred' -Reason 'UiStateChanged'
        Write-RunResult -Status 'Deferred' -Reason 'UiStateChanged'
        return
    }

    try {
        Write-NonPrivateSnapshot -UiState $afterProbes
    } catch {
        Write-WatchdogEvent -Event 'Deferred' -Reason 'SnapshotWriteFailed'
        Write-RunResult -Status 'Deferred' -Reason 'SnapshotWriteFailed'
        return
    }

    if (-not $EnableRecovery) {
        Write-WatchdogEvent -Event 'ObservedUnresponsive' -Reason 'ObserveOnly'
        Write-RunResult -Status 'ObservedUnresponsive' -Reason 'ObserveOnly'
        return
    }

    $stateRead = Read-WatchdogState
    if (-not $stateRead.Valid) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $stateRead.Reason
        Write-RunResult -Status 'Deferred' -Reason $stateRead.Reason
        return
    }
    $now = [DateTimeOffset]::UtcNow
    $rate = Test-RecoveryRateLimit -State $stateRead.State -Now $now
    if (-not $rate.Allowed) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $rate.Reason
        Write-RunResult -Status 'Deferred' -Reason $rate.Reason
        return
    }

    $processScope = Test-BaiduProcessScope -ExpectedUiProcessId $ui.ProcessId
    if (-not $processScope.Safe) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $processScope.Reason
        Write-RunResult -Status 'Deferred' -Reason $processScope.Reason
        return
    }

    $transferGuard = Test-NoActiveTransfersTwice
    if (-not $transferGuard.Safe) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $transferGuard.Reason
        Write-RunResult -Status 'Deferred' -Reason $transferGuard.Reason
        return
    }

    $beforeRecovery = Get-BaiduUiState
    if ($beforeRecovery.Status -ne 'Ready' -or
        $beforeRecovery.ProcessId -ne $ui.ProcessId -or
        $beforeRecovery.ProcessStartUtc -ne $ui.ProcessStartUtc -or
        $beforeRecovery.Handle -ne $ui.Handle) {
        Write-WatchdogEvent -Event 'Deferred' -Reason 'UiStateChanged'
        Write-RunResult -Status 'Deferred' -Reason 'UiStateChanged'
        return
    }
    if (Test-WindowMessage -Window $beforeRecovery.Handle) {
        Write-WatchdogEvent -Event 'Healthy' -Reason 'UiRecoveredNaturally'
        Write-RunResult -Status 'Healthy' -Reason 'UiRecoveredNaturally'
        return
    }

    # Re-read after the 15-second transfer guard so an external state update
    # cannot bypass a newly active rate limit or suppression window.
    $stateRead = Read-WatchdogState
    if (-not $stateRead.Valid) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $stateRead.Reason
        Write-RunResult -Status 'Deferred' -Reason $stateRead.Reason
        return
    }
    $now = [DateTimeOffset]::UtcNow
    $rate = Test-RecoveryRateLimit -State $stateRead.State -Now $now
    if (-not $rate.Allowed) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $rate.Reason
        Write-RunResult -Status 'Deferred' -Reason $rate.Reason
        return
    }

    # Repeat the complete, twice-sampled transfer guard as the final safety
    # gate before recording and invoking a destructive restart.
    $finalTransferGuard = Test-NoActiveTransfersTwice
    if (-not $finalTransferGuard.Safe) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $finalTransferGuard.Reason
        Write-RunResult -Status 'Deferred' -Reason $finalTransferGuard.Reason
        return
    }

    $finalUi = Get-BaiduUiState
    if ($finalUi.Status -ne 'Ready' -or
        $finalUi.ProcessId -ne $ui.ProcessId -or
        $finalUi.ProcessStartUtc -ne $ui.ProcessStartUtc -or
        $finalUi.Handle -ne $ui.Handle) {
        Write-WatchdogEvent -Event 'Deferred' -Reason 'UiStateChanged'
        Write-RunResult -Status 'Deferred' -Reason 'UiStateChanged'
        return
    }
    if (Test-WindowMessage -Window $finalUi.Handle) {
        Write-WatchdogEvent -Event 'Healthy' -Reason 'UiRecoveredNaturally'
        Write-RunResult -Status 'Healthy' -Reason 'UiRecoveredNaturally'
        return
    }

    $processScope = Test-BaiduProcessScope -ExpectedUiProcessId $ui.ProcessId
    if (-not $processScope.Safe) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $processScope.Reason
        Write-RunResult -Status 'Deferred' -Reason $processScope.Reason
        return
    }

    $stateRead = Read-WatchdogState
    if (-not $stateRead.Valid) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $stateRead.Reason
        Write-RunResult -Status 'Deferred' -Reason $stateRead.Reason
        return
    }
    $now = [DateTimeOffset]::UtcNow
    $rate = Test-RecoveryRateLimit -State $stateRead.State -Now $now
    if (-not $rate.Allowed) {
        Write-WatchdogEvent -Event 'Deferred' -Reason $rate.Reason
        Write-RunResult -Status 'Deferred' -Reason $rate.Reason
        return
    }

    $history = @($stateRead.State.RecoveryUtc | Where-Object {
        [DateTimeOffset]::ParseExact(
            [string]$_,
            'o',
            [Globalization.CultureInfo]::InvariantCulture,
            [Globalization.DateTimeStyles]::RoundtripKind
        ) -gt $now.AddHours(-24)
    })
    $stateRead.State.RecoveryUtc = @($history + $now.ToString('o'))
    $stateRead.State.SuppressedUntilUtc = $now.AddHours(6).ToString('o')
    $stateRead.State.LastAttemptUtc = $now.ToString('o')
    $stateRead.State.LastAttemptResult = 'InProgress'
    try {
        # The tentative six-hour suppression makes crashes and failed launches safe.
        Write-WatchdogState -State $stateRead.State
    } catch {
        Write-WatchdogEvent -Event 'Deferred' -Reason 'StateWriteFailed'
        Write-RunResult -Status 'Deferred' -Reason 'StateWriteFailed'
        return
    }

    Write-WatchdogEvent -Event 'RecoveryStarted' -Reason 'UiUnresponsiveNoTransfers'
    $launch = Invoke-CheckedLauncher -ExpectedProcessId $ui.ProcessId
    if (-not $launch.Success) {
        Set-FailedRecoveryState -State $stateRead.State -Result $launch.Reason
        Write-WatchdogEvent -Event 'RecoveryFailed' -Reason $launch.Reason
        Write-RunResult -Status 'RecoveryFailed' -Reason $launch.Reason
        return
    }

    if (-not (Test-NewUiHealthy -OldProcessId $ui.ProcessId -OldProcessStartUtc $ui.ProcessStartUtc)) {
        Set-FailedRecoveryState -State $stateRead.State -Result 'NewUiVerificationFailed'
        Write-WatchdogEvent -Event 'RecoveryFailed' -Reason 'NewUiVerificationFailed'
        Write-RunResult -Status 'RecoveryFailed' -Reason 'NewUiVerificationFailed'
        return
    }

    try {
        $stateRead.State.SuppressedUntilUtc = $null
        $stateRead.State.LastAttemptResult = 'Succeeded'
        Write-WatchdogState -State $stateRead.State
    } catch {
        # A stale suppression is conservative; the successful recovery is still valid.
    }
    Write-WatchdogEvent -Event 'Recovered' -Reason 'NewUiPassed6x5sVerification'
    Write-RunResult -Status 'Recovered' -Reason 'NewUiPassed6x5sVerification'
}

$runLock = $null
$mutex = $null
$mutexAcquired = $false
try {
    if (-not (Test-Path -LiteralPath $dataRoot)) {
        New-Item -ItemType Directory -Path $dataRoot -Force | Out-Null
    }
    try {
        # FileShare.None supplies the cross-session exclusion that a Local\
        # mutex alone cannot provide. The handle stays open for the whole run.
        $runLock = [IO.File]::Open(
            $runLockPath,
            [IO.FileMode]::OpenOrCreate,
            [IO.FileAccess]::ReadWrite,
            [IO.FileShare]::None
        )
    } catch [IO.IOException] {
        Write-RunResult -Status 'Ignored' -Reason 'AlreadyRunningCrossSession'
        return
    }

    $userSid = [Security.Principal.WindowsIdentity]::GetCurrent().User.Value
    $mutexName = 'Local\BaiduNetdiskWatchdog-' + $userSid
    $createdNew = $false
    $mutex = New-Object Threading.Mutex($false, $mutexName, [ref]$createdNew)
    try {
        $mutexAcquired = $mutex.WaitOne(0, $false)
    } catch [Threading.AbandonedMutexException] {
        $mutexAcquired = $true
    }

    if (-not $mutexAcquired) {
        Write-RunResult -Status 'Ignored' -Reason 'AlreadyRunning'
        return
    }

    try {
        Invoke-WatchdogMain
    } catch {
        Write-WatchdogEvent -Event 'Deferred' -Reason 'InternalError'
        Write-RunResult -Status 'Deferred' -Reason 'InternalError'
    }
} finally {
    if ($mutexAcquired -and $null -ne $mutex) {
        try { $mutex.ReleaseMutex() } catch {}
    }
    if ($null -ne $mutex) {
        $mutex.Dispose()
    }
    if ($null -ne $runLock) {
        $runLock.Dispose()
    }
}

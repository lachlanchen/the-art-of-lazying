#Requires -Version 5.1
[CmdletBinding()]
param(
    [switch]$EnableRecovery,

    [string]$SqlitePath,

    [ValidateRange(15, 3600)]
    [int]$IntervalSeconds = 60
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$watchdogPath = Join-Path $PSScriptRoot 'Watch-BaiduNetdisk.ps1'
$dataRoot = Join-Path $env:LOCALAPPDATA 'BaiduNetdiskWatchdog'
$loopLockPath = Join-Path $dataRoot 'loop.lock'
$pidFilePath = Join-Path $dataRoot 'loop.pid.json'
$instanceId = [Guid]::NewGuid().ToString('N')

function Assert-PowerShellScript {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Required PowerShell script not found: $Path"
    }
    $tokens = $null
    $parseErrors = $null
    [Management.Automation.Language.Parser]::ParseFile(
        $Path,
        [ref]$tokens,
        [ref]$parseErrors
    ) | Out-Null
    if (@($parseErrors).Count -gt 0) {
        throw "Required PowerShell script has parse errors: $Path"
    }
}

function Resolve-SignedSqlite {
    param([string]$Path)

    $resolved = (Resolve-Path -LiteralPath $Path).Path
    $item = Get-Item -LiteralPath $resolved
    if ($item.PSIsContainer -or
        $item.Name -ine 'sqlite3.exe' -or
        $item.Extension -ine '.exe') {
        throw '-SqlitePath must identify sqlite3.exe.'
    }
    $signature = Get-AuthenticodeSignature -LiteralPath $resolved
    if ($signature.Status -ne 'Valid') {
        throw '-SqlitePath must identify an Authenticode-valid sqlite3.exe.'
    }
    $resolved
}

function Get-TextSha256 {
    param([string]$Text)

    $sha256 = [Security.Cryptography.SHA256]::Create()
    try {
        $bytes = (New-Object Text.UTF8Encoding($false)).GetBytes($Text)
        ([BitConverter]::ToString($sha256.ComputeHash($bytes))).Replace('-', '')
    } finally {
        $sha256.Dispose()
    }
}

function Write-AtomicUtf8Text {
    param(
        [string]$Path,
        [string]$Text
    )

    $directory = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }
    $temporaryPath = Join-Path $directory ('.tmp-' + [Guid]::NewGuid().ToString('N'))
    $backupPath = Join-Path $directory ('.bak-' + [Guid]::NewGuid().ToString('N'))
    $encoding = New-Object Text.UTF8Encoding($false)
    try {
        [IO.File]::WriteAllText($temporaryPath, $Text, $encoding)
        if (Test-Path -LiteralPath $Path) {
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

function Get-OwnCommandLine {
    $self = Get-CimInstance -ClassName Win32_Process -Filter "ProcessId = $PID" -ErrorAction Stop
    if ($null -eq $self -or [string]::IsNullOrWhiteSpace([string]$self.CommandLine)) {
        throw 'The loop process command line could not be verified.'
    }
    [string]$self.CommandLine
}

function Remove-OwnedPidFile {
    try {
        if (-not (Test-Path -LiteralPath $pidFilePath -PathType Leaf)) {
            return
        }
        $item = Get-Item -LiteralPath $pidFilePath
        if ($item.Length -gt 16384) {
            return
        }
        $record = [IO.File]::ReadAllText($pidFilePath) | ConvertFrom-Json
        if ([int]$record.ProcessId -eq $PID -and
            [string]$record.InstanceId -ceq $instanceId) {
            Remove-Item -LiteralPath $pidFilePath -Force -ErrorAction SilentlyContinue
        }
    } catch {
    }
}

if (-not $EnableRecovery -and -not [string]::IsNullOrWhiteSpace($SqlitePath)) {
    throw '-SqlitePath is only valid with -EnableRecovery.'
}

Assert-PowerShellScript -Path $watchdogPath
$resolvedWatchdogPath = (Resolve-Path -LiteralPath $watchdogPath).Path
$resolvedLoopPath = (Resolve-Path -LiteralPath $PSCommandPath).Path
$resolvedSqlitePath = $null
if (-not [string]::IsNullOrWhiteSpace($SqlitePath)) {
    $resolvedSqlitePath = Resolve-SignedSqlite -Path $SqlitePath
}

if (-not (Test-Path -LiteralPath $dataRoot)) {
    New-Item -ItemType Directory -Path $dataRoot -Force | Out-Null
}

$loopLock = $null
try {
    try {
        # FileShare.None is a machine-wide filesystem lock, including across
        # interactive sessions for this user's shared LOCALAPPDATA directory.
        $loopLock = [IO.File]::Open(
            $loopLockPath,
            [IO.FileMode]::OpenOrCreate,
            [IO.FileAccess]::ReadWrite,
            [IO.FileShare]::None
        )
    } catch [IO.IOException] {
        return
    }

    $ownCommandLine = Get-OwnCommandLine
    $pidRecord = [ordered]@{
        Version = 1
        ProcessId = $PID
        InstanceId = $instanceId
        StartedUtc = [DateTimeOffset]::UtcNow.ToString('o')
        ScriptPath = $resolvedLoopPath
        Mode = if ($EnableRecovery) { 'RecoveryEnabled' } else { 'ObserveOnly' }
        CommandLineSha256 = Get-TextSha256 -Text $ownCommandLine
    }
    Write-AtomicUtf8Text -Path $pidFilePath -Text (
        ($pidRecord | ConvertTo-Json -Depth 3) + [Environment]::NewLine
    )

    $watchdogParameters = @{}
    if ($EnableRecovery) {
        $watchdogParameters.EnableRecovery = $true
    }
    if ($resolvedSqlitePath) {
        $watchdogParameters.SqlitePath = $resolvedSqlitePath
    }

    while ($true) {
        $cycle = [Diagnostics.Stopwatch]::StartNew()
        try {
            # Watch-BaiduNetdisk.ps1 ignores an absent, hidden, or starting app.
            # The loop itself never invokes Baidu or its launcher directly.
            & $resolvedWatchdogPath @watchdogParameters | Out-Null
        } catch {
            # A failed observation must not terminate the persistent login loop.
        }

        $remainingMilliseconds = [int][Math]::Floor(
            ($IntervalSeconds * 1000.0) - $cycle.Elapsed.TotalMilliseconds
        )
        if ($remainingMilliseconds -gt 0) {
            Start-Sleep -Milliseconds $remainingMilliseconds
        } else {
            Start-Sleep -Milliseconds 250
        }
    }
} finally {
    Remove-OwnedPidFile
    if ($null -ne $loopLock) {
        $loopLock.Dispose()
    }
}

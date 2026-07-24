#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    [switch]$EnableRecovery,

    [string]$SqlitePath,

    [switch]$Uninstall
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$runSubKey = 'Software\Microsoft\Windows\CurrentVersion\Run'
$runValueName = 'BaiduNetdiskWatchdog'
$loopPath = Join-Path $PSScriptRoot 'Run-BaiduNetdiskWatchdogLoop.ps1'
$watchdogPath = Join-Path $PSScriptRoot 'Watch-BaiduNetdisk.ps1'
$dataRoot = Join-Path $env:LOCALAPPDATA 'BaiduNetdiskWatchdog'
$pidFilePath = Join-Path $dataRoot 'loop.pid.json'
$loopLockPath = Join-Path $dataRoot 'loop.lock'
$installerLockPath = Join-Path $dataRoot 'login-installer.lock'
$powershellPath = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'

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

function Quote-ExactArgument {
    param([string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value) -or $Value.IndexOf('"') -ge 0) {
        throw 'A managed command argument is empty or contains an invalid quote.'
    }
    '"' + $Value + '"'
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

function Get-ManagedRunCommand {
    param(
        [bool]$RecoveryEnabled,
        [string]$ExplicitSqlitePath
    )

    $command = (Quote-ExactArgument -Value $powershellPath) +
        ' -NoLogo -NoProfile -NonInteractive -WindowStyle Hidden' +
        ' -ExecutionPolicy Bypass -File ' +
        (Quote-ExactArgument -Value $resolvedLoopPath)
    if ($RecoveryEnabled) {
        $command += ' -EnableRecovery'
    }
    if (-not [string]::IsNullOrWhiteSpace($ExplicitSqlitePath)) {
        $command += ' -SqlitePath ' + (Quote-ExactArgument -Value $ExplicitSqlitePath)
    }
    $command
}

function Test-ManagedRunCommand {
    param([string]$Command)

    if ([string]::IsNullOrWhiteSpace($Command)) {
        return [pscustomobject]@{ Managed = $false; Mode = $null; SqlitePath = $null }
    }

    $observeCommand = Get-ManagedRunCommand -RecoveryEnabled $false -ExplicitSqlitePath $null
    if ($Command -ceq $observeCommand) {
        return [pscustomobject]@{ Managed = $true; Mode = 'ObserveOnly'; SqlitePath = $null }
    }

    $recoveryCommand = Get-ManagedRunCommand -RecoveryEnabled $true -ExplicitSqlitePath $null
    if ($Command -ceq $recoveryCommand) {
        return [pscustomobject]@{ Managed = $true; Mode = 'RecoveryEnabled'; SqlitePath = $null }
    }

    $explicitPrefix = $recoveryCommand + ' -SqlitePath "'
    if (-not $Command.StartsWith($explicitPrefix, [StringComparison]::Ordinal) -or
        -not $Command.EndsWith('"', [StringComparison]::Ordinal)) {
        return [pscustomobject]@{ Managed = $false; Mode = $null; SqlitePath = $null }
    }

    $candidate = $Command.Substring(
        $explicitPrefix.Length,
        $Command.Length - $explicitPrefix.Length - 1
    )
    try {
        if ($candidate.IndexOf('"') -ge 0 -or
            -not [IO.Path]::IsPathRooted($candidate) -or
            [IO.Path]::GetFileName($candidate) -ine 'sqlite3.exe') {
            throw 'Invalid explicit sqlite path.'
        }
        $fullCandidate = [IO.Path]::GetFullPath($candidate)
        if (-not $fullCandidate.Equals($candidate, [StringComparison]::OrdinalIgnoreCase)) {
            throw 'Non-canonical explicit sqlite path.'
        }
        $reconstructed = Get-ManagedRunCommand `
            -RecoveryEnabled $true `
            -ExplicitSqlitePath $candidate
        if ($Command -cne $reconstructed) {
            throw 'Managed command mismatch.'
        }
    } catch {
        return [pscustomobject]@{ Managed = $false; Mode = $null; SqlitePath = $null }
    }

    [pscustomobject]@{
        Managed = $true
        Mode = 'RecoveryEnabled'
        SqlitePath = $candidate
    }
}

function Get-RunValueRecord {
    $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey($runSubKey, $false)
    if ($null -eq $key) {
        return [pscustomobject]@{ Present = $false; Value = $null; Kind = $null }
    }
    try {
        $names = @($key.GetValueNames())
        if ($names -notcontains $runValueName) {
            return [pscustomobject]@{ Present = $false; Value = $null; Kind = $null }
        }
        $value = $key.GetValue(
            $runValueName,
            $null,
            [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames
        )
        $kind = $key.GetValueKind($runValueName)
        [pscustomobject]@{ Present = $true; Value = [string]$value; Kind = $kind }
    } finally {
        $key.Dispose()
    }
}

function Test-RunValueSnapshot {
    param([object]$Expected)

    $current = Get-RunValueRecord
    if ([bool]$current.Present -ne [bool]$Expected.Present) {
        return $false
    }
    if (-not $current.Present) {
        return $true
    }
    $current.Kind -eq $Expected.Kind -and $current.Value -ceq $Expected.Value
}

function Open-InstallerLock {
    if (-not (Test-Path -LiteralPath $dataRoot)) {
        New-Item -ItemType Directory -Path $dataRoot -Force | Out-Null
    }
    try {
        [IO.File]::Open(
            $installerLockPath,
            [IO.FileMode]::OpenOrCreate,
            [IO.FileAccess]::ReadWrite,
            [IO.FileShare]::None
        )
    } catch [IO.IOException] {
        $null
    }
}

function Test-LoopLockAvailable {
    $probe = $null
    try {
        $probe = [IO.File]::Open(
            $loopLockPath,
            [IO.FileMode]::OpenOrCreate,
            [IO.FileAccess]::ReadWrite,
            [IO.FileShare]::None
        )
        return $true
    } catch [IO.IOException] {
        return $false
    } finally {
        if ($null -ne $probe) {
            $probe.Dispose()
        }
    }
}

function Set-ExactRunValue {
    param([string]$Command)

    $key = [Microsoft.Win32.Registry]::CurrentUser.CreateSubKey($runSubKey)
    if ($null -eq $key) {
        throw 'The current-user Run registry key could not be opened for writing.'
    }
    try {
        $key.SetValue(
            $runValueName,
            $Command,
            [Microsoft.Win32.RegistryValueKind]::String
        )
    } finally {
        $key.Dispose()
    }

    $written = Get-RunValueRecord
    if (-not $written.Present -or
        $written.Kind -ne [Microsoft.Win32.RegistryValueKind]::String -or
        $written.Value -cne $Command) {
        throw 'The exact current-user Run command could not be verified after writing.'
    }
}

function Remove-ExactRunValue {
    param([string]$ExpectedCommand)

    $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey($runSubKey, $true)
    if ($null -eq $key) {
        return $false
    }
    try {
        $names = @($key.GetValueNames())
        if ($names -notcontains $runValueName -or
            $key.GetValueKind($runValueName) -ne [Microsoft.Win32.RegistryValueKind]::String) {
            return $false
        }
        $current = [string]$key.GetValue(
            $runValueName,
            $null,
            [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames
        )
        if ($current -cne $ExpectedCommand) {
            return $false
        }
        $key.DeleteValue($runValueName, $false)
        return $true
    } finally {
        $key.Dispose()
    }
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

function Get-VerifiedLoopProcess {
    param([string]$ExpectedRunCommand)

    try {
        if (-not (Test-Path -LiteralPath $pidFilePath -PathType Leaf)) {
            throw 'PID file absent.'
        }
        $pidItem = Get-Item -LiteralPath $pidFilePath
        if ($pidItem.Length -le 0 -or $pidItem.Length -gt 16384) {
            throw 'PID file size invalid.'
        }
        $record = [IO.File]::ReadAllText($pidFilePath) | ConvertFrom-Json
        $required = @(
            'Version',
            'ProcessId',
            'InstanceId',
            'ScriptPath',
            'Mode',
            'CommandLineSha256'
        )
        foreach ($name in $required) {
            if (@($record.PSObject.Properties.Name) -notcontains $name) {
                throw 'PID record property absent.'
            }
        }
        $processId = [int]$record.ProcessId
        if ([int]$record.Version -ne 1 -or
            $processId -le 0 -or
            [string]$record.InstanceId -notmatch '^[0-9a-f]{32}$' -or
            -not ([string]$record.ScriptPath).Equals(
                $resolvedLoopPath,
                [StringComparison]::OrdinalIgnoreCase
            ) -or
            [string]$record.CommandLineSha256 -notmatch '^[0-9A-F]{64}$') {
            throw 'PID record validation failed.'
        }

        $managed = Test-ManagedRunCommand -Command $ExpectedRunCommand
        if (-not $managed.Managed -or [string]$record.Mode -cne $managed.Mode) {
            throw 'PID mode does not match the exact Run command.'
        }

        $process = Get-CimInstance `
            -ClassName Win32_Process `
            -Filter "ProcessId = $processId" `
            -ErrorAction Stop
        if ($null -eq $process -or
            -not ([string]$process.ExecutablePath).Equals(
                $powershellPath,
                [StringComparison]::OrdinalIgnoreCase
            ) -or
            [string]$process.CommandLine -cne $ExpectedRunCommand -or
            (Get-TextSha256 -Text ([string]$process.CommandLine)) -cne
                [string]$record.CommandLineSha256) {
            throw 'Loop process identity validation failed.'
        }

        [pscustomobject]@{
            Verified = $true
            ProcessId = $processId
            InstanceId = [string]$record.InstanceId
        }
    } catch {
        [pscustomobject]@{
            Verified = $false
            ProcessId = $null
            InstanceId = $null
        }
    }
}

function Remove-MatchingPidFile {
    param(
        [int]$ExpectedProcessId,
        [string]$ExpectedInstanceId
    )

    try {
        if (-not (Test-Path -LiteralPath $pidFilePath -PathType Leaf)) {
            return
        }
        $record = [IO.File]::ReadAllText($pidFilePath) | ConvertFrom-Json
        if ([int]$record.ProcessId -eq $ExpectedProcessId -and
            [string]$record.InstanceId -ceq $ExpectedInstanceId) {
            Remove-Item -LiteralPath $pidFilePath -Force -ErrorAction SilentlyContinue
        }
    } catch {
    }
}

function Stop-VerifiedLoopProcess {
    param([string]$ExpectedRunCommand)

    $verified = Get-VerifiedLoopProcess -ExpectedRunCommand $ExpectedRunCommand
    if (-not $verified.Verified) {
        return $false
    }

    try {
        Stop-Process -Id $verified.ProcessId -Force -ErrorAction Stop
        for ($attempt = 0; $attempt -lt 25; $attempt++) {
            Start-Sleep -Milliseconds 200
            if ($null -eq (Get-Process -Id $verified.ProcessId -ErrorAction SilentlyContinue)) {
                Remove-MatchingPidFile `
                    -ExpectedProcessId $verified.ProcessId `
                    -ExpectedInstanceId $verified.InstanceId
                return $true
            }
        }
    } catch {
        return $false
    }
    return $false
}

function Start-HiddenLoopProcess {
    param([string]$RunCommand)

    $startupClass = [WmiClass]'\\.\root\cimv2:Win32_ProcessStartup'
    $startup = $startupClass.CreateInstance()
    $startup.ShowWindow = 0
    $processClass = [WmiClass]'\\.\root\cimv2:Win32_Process'
    $result = $processClass.Create($RunCommand, $PSScriptRoot, $startup)
    if ($null -eq $result -or [int]$result.ReturnValue -ne 0 -or [int]$result.ProcessId -le 0) {
        throw 'The hidden watchdog loop could not be started.'
    }
    [int]$result.ProcessId
}

function Wait-ForVerifiedLoopProcess {
    param(
        [string]$ExpectedRunCommand,
        [int]$ExpectedProcessId
    )

    for ($attempt = 0; $attempt -lt 50; $attempt++) {
        Start-Sleep -Milliseconds 200
        $verified = Get-VerifiedLoopProcess -ExpectedRunCommand $ExpectedRunCommand
        if ($verified.Verified -and $verified.ProcessId -eq $ExpectedProcessId) {
            return $true
        }
    }
    return $false
}

Assert-PowerShellScript -Path $loopPath
Assert-PowerShellScript -Path $watchdogPath
if (-not (Test-Path -LiteralPath $powershellPath -PathType Leaf)) {
    throw "Windows PowerShell 5.1 was not found: $powershellPath"
}
$resolvedLoopPath = (Resolve-Path -LiteralPath $loopPath).Path

if ($Uninstall) {
    if ($EnableRecovery -or -not [string]::IsNullOrWhiteSpace($SqlitePath)) {
        throw '-EnableRecovery and -SqlitePath cannot be combined with -Uninstall.'
    }

    $existing = Get-RunValueRecord
    if (-not $existing.Present) {
        [pscustomobject]@{ Status = 'NotInstalled'; LoopStopped = $false }
        return
    }
    $managed = if ($existing.Kind -eq [Microsoft.Win32.RegistryValueKind]::String) {
        Test-ManagedRunCommand -Command $existing.Value
    } else {
        [pscustomobject]@{ Managed = $false }
    }
    if (-not $managed.Managed) {
        [pscustomobject]@{ Status = 'RefusedForeignRunValue'; LoopStopped = $false }
        return
    }

    if ($PSCmdlet.ShouldProcess(
        'HKCU\Software\Microsoft\Windows\CurrentVersion\Run\BaiduNetdiskWatchdog',
        'Remove the exact managed Run command and stop only its verified loop PID'
    )) {
        $installerLock = Open-InstallerLock
        if ($null -eq $installerLock) {
            [pscustomobject]@{ Status = 'DeferredInstallerBusy'; LoopStopped = $false }
            return
        }
        try {
            if (-not (Test-RunValueSnapshot -Expected $existing) -or
                -not (Remove-ExactRunValue -ExpectedCommand $existing.Value)) {
                [pscustomobject]@{ Status = 'DeferredRunValueChanged'; LoopStopped = $false }
                return
            }
            $loopStopped = Stop-VerifiedLoopProcess -ExpectedRunCommand $existing.Value
            [pscustomobject]@{
                Status = 'Uninstalled'
                LoopStopped = $loopStopped
            }
        } finally {
            $installerLock.Dispose()
        }
    }
    return
}

if (-not $EnableRecovery -and -not [string]::IsNullOrWhiteSpace($SqlitePath)) {
    throw '-SqlitePath is only valid with -EnableRecovery.'
}
$resolvedSqlitePath = $null
if (-not [string]::IsNullOrWhiteSpace($SqlitePath)) {
    $resolvedSqlitePath = Resolve-SignedSqlite -Path $SqlitePath
}
$newRunCommand = Get-ManagedRunCommand `
    -RecoveryEnabled ([bool]$EnableRecovery) `
    -ExplicitSqlitePath $resolvedSqlitePath

$existing = Get-RunValueRecord
$existingManaged = $null
if ($existing.Present) {
    if ($existing.Kind -ne [Microsoft.Win32.RegistryValueKind]::String) {
        [pscustomobject]@{ Status = 'RefusedForeignRunValue'; LoopStarted = $false }
        return
    }
    $existingManaged = Test-ManagedRunCommand -Command $existing.Value
    if (-not $existingManaged.Managed) {
        [pscustomobject]@{ Status = 'RefusedForeignRunValue'; LoopStarted = $false }
        return
    }
}

$mode = if ($EnableRecovery) { 'RecoveryEnabled' } else { 'ObserveOnly' }
if ($PSCmdlet.ShouldProcess(
    'HKCU\Software\Microsoft\Windows\CurrentVersion\Run\BaiduNetdiskWatchdog',
    "Set the exact $mode login command and start its hidden loop now"
)) {
    $installerLock = Open-InstallerLock
    if ($null -eq $installerLock) {
        [pscustomobject]@{
            Status = 'DeferredInstallerBusy'
            Mode = $mode
            LoopStarted = $false
            LoopAlreadyRunning = $false
        }
        return
    }
    try {
        if (-not (Test-RunValueSnapshot -Expected $existing)) {
            [pscustomobject]@{
                Status = 'DeferredRunValueChanged'
                Mode = $mode
                LoopStarted = $false
                LoopAlreadyRunning = $false
            }
            return
        }

        $alreadyRunning = Get-VerifiedLoopProcess -ExpectedRunCommand $newRunCommand
        if ($existing.Present -and $existing.Value -ceq $newRunCommand -and
            $alreadyRunning.Verified) {
            [pscustomobject]@{
                Status = 'Installed'
                Mode = $mode
                LoopStarted = $false
                LoopAlreadyRunning = $true
            }
            return
        }

        if ($existing.Present -and $existing.Value -cne $newRunCommand) {
            $oldLoop = Get-VerifiedLoopProcess -ExpectedRunCommand $existing.Value
            if ($oldLoop.Verified) {
                if (-not (Stop-VerifiedLoopProcess -ExpectedRunCommand $existing.Value)) {
                    [pscustomobject]@{
                        Status = 'DeferredExistingLoopStopFailed'
                        Mode = $mode
                        LoopStarted = $false
                        LoopAlreadyRunning = $false
                    }
                    return
                }
            } elseif (-not (Test-LoopLockAvailable)) {
                [pscustomobject]@{
                    Status = 'DeferredExistingLoopUnverified'
                    Mode = $mode
                    LoopStarted = $false
                    LoopAlreadyRunning = $false
                }
                return
            }
        } elseif (-not $alreadyRunning.Verified -and -not (Test-LoopLockAvailable)) {
            [pscustomobject]@{
                Status = 'DeferredExistingLoopUnverified'
                Mode = $mode
                LoopStarted = $false
                LoopAlreadyRunning = $false
            }
            return
        }

        Set-ExactRunValue -Command $newRunCommand

        if ($alreadyRunning.Verified) {
            [pscustomobject]@{
                Status = 'Installed'
                Mode = $mode
                LoopStarted = $false
                LoopAlreadyRunning = $true
            }
            return
        }

        try {
            $startedProcessId = Start-HiddenLoopProcess -RunCommand $newRunCommand
            $verifiedStart = Wait-ForVerifiedLoopProcess `
                -ExpectedRunCommand $newRunCommand `
                -ExpectedProcessId $startedProcessId
            [pscustomobject]@{
                Status = if ($verifiedStart) { 'Installed' } else { 'InstalledStartUnverified' }
                Mode = $mode
                LoopStarted = $verifiedStart
                LoopAlreadyRunning = $false
            }
        } catch {
            [pscustomobject]@{
                Status = 'InstalledStartFailed'
                Mode = $mode
                LoopStarted = $false
                LoopAlreadyRunning = $false
            }
        }
    } finally {
        $installerLock.Dispose()
    }
}

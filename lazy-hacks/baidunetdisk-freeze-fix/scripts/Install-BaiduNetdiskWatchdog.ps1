#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    [switch]$EnableRecovery,

    [string]$SqlitePath,

    [switch]$Uninstall,

    [ValidatePattern('^[A-Za-z0-9_.-]+$')]
    [string]$TaskName = 'BaiduNetdiskWatchdog'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$taskPath = '\'
$watchdogPath = Join-Path $PSScriptRoot 'Watch-BaiduNetdisk.ps1'

function Quote-TaskArgument {
    param([string]$Value)

    if ($Value.IndexOf('"') -ge 0) {
        throw 'A scheduled-task argument contains an invalid quote.'
    }
    '"' + $Value + '"'
}

if ($Uninstall) {
    if ($EnableRecovery -or -not [string]::IsNullOrWhiteSpace($SqlitePath)) {
        throw '-EnableRecovery and -SqlitePath cannot be combined with -Uninstall.'
    }

    $existing = Get-ScheduledTask -TaskName $TaskName -TaskPath $taskPath -ErrorAction SilentlyContinue
    if ($null -eq $existing) {
        [pscustomobject]@{
            TaskName = $TaskName
            Status = 'NotInstalled'
        }
        return
    }

    if ($PSCmdlet.ShouldProcess("$taskPath$TaskName", 'Unregister current-user watchdog task')) {
        Unregister-ScheduledTask -TaskName $TaskName -TaskPath $taskPath -Confirm:$false
        [pscustomobject]@{
            TaskName = $TaskName
            Status = 'Uninstalled'
        }
    }
    return
}

if (-not (Test-Path -LiteralPath $watchdogPath)) {
    throw "Watchdog script not found: $watchdogPath"
}

$tokens = $null
$parseErrors = $null
[Management.Automation.Language.Parser]::ParseFile(
    $watchdogPath,
    [ref]$tokens,
    [ref]$parseErrors
) | Out-Null
if (@($parseErrors).Count -gt 0) {
    throw 'Refusing to install a watchdog script with PowerShell parse errors.'
}

$resolvedSqlitePath = $null
if (-not [string]::IsNullOrWhiteSpace($SqlitePath)) {
    $resolvedSqlitePath = (Resolve-Path -LiteralPath $SqlitePath).Path
    $sqliteItem = Get-Item -LiteralPath $resolvedSqlitePath
    if ($sqliteItem.PSIsContainer -or
        $sqliteItem.Name -ine 'sqlite3.exe' -or
        $sqliteItem.Extension -ne '.exe') {
        throw '-SqlitePath must identify sqlite3.exe.'
    }
    $sqliteSignature = Get-AuthenticodeSignature -LiteralPath $resolvedSqlitePath
    if ($sqliteSignature.Status -ne 'Valid') {
        throw '-SqlitePath must identify an Authenticode-valid sqlite3.exe.'
    }
}

$powershell = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
if (-not (Test-Path -LiteralPath $powershell)) {
    throw "Windows PowerShell 5.1 was not found: $powershell"
}

$arguments = New-Object 'System.Collections.Generic.List[string]'
$arguments.Add('-NoLogo')
$arguments.Add('-NoProfile')
$arguments.Add('-WindowStyle')
$arguments.Add('Hidden')
$arguments.Add('-NonInteractive')
$arguments.Add('-ExecutionPolicy')
$arguments.Add('Bypass')
$arguments.Add('-File')
$arguments.Add((Quote-TaskArgument -Value $watchdogPath))
if ($EnableRecovery) {
    $arguments.Add('-EnableRecovery')
}
if ($resolvedSqlitePath) {
    $arguments.Add('-SqlitePath')
    $arguments.Add((Quote-TaskArgument -Value $resolvedSqlitePath))
}

$action = New-ScheduledTaskAction -Execute $powershell -Argument ($arguments -join ' ')
$trigger = New-ScheduledTaskTrigger `
    -Once `
    -At (Get-Date).AddMinutes(1) `
    -RepetitionInterval (New-TimeSpan -Minutes 1)
$settings = New-ScheduledTaskSettingsSet `
    -MultipleInstances IgnoreNew `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 5) `
    -WakeToRun:$false `
    -StartWhenAvailable:$false `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent().Name
$principal = New-ScheduledTaskPrincipal `
    -UserId $currentUser `
    -LogonType Interactive `
    -RunLevel Limited
$descriptionMode = if ($EnableRecovery) { 'conservative recovery enabled' } else { 'observe only' }
$definition = New-ScheduledTask `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -Principal $principal `
    -Description "Baidu Netdisk UI watchdog ($descriptionMode). Does not start an absent app."

if ($PSCmdlet.ShouldProcess(
    "$taskPath$TaskName",
    "Register current-user Interactive/Limited watchdog task ($descriptionMode)"
)) {
    Register-ScheduledTask `
        -TaskName $TaskName `
        -TaskPath $taskPath `
        -InputObject $definition `
        -Force | Out-Null

    [pscustomobject]@{
        TaskName = $TaskName
        Mode = if ($EnableRecovery) { 'RecoveryEnabled' } else { 'ObserveOnly' }
        Status = 'Installed'
        Interval = 'PT1M'
        ExecutionTimeLimit = 'PT5M'
        MultipleInstances = 'IgnoreNew'
        WakeToRun = $false
        LogonType = 'Interactive'
        RunLevel = 'Limited'
    }
}

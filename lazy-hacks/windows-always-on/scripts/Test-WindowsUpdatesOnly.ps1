[CmdletBinding()]
param([string]$ScriptPath = "")

if (-not $ScriptPath) { $ScriptPath = Join-Path $PSScriptRoot "Configure-WindowsAlwaysOn.ps1" }

Set-StrictMode -Version 2.0
$ErrorActionPreference = "Stop"
$tokens = $null
$errors = $null
$ast = [System.Management.Automation.Language.Parser]::ParseFile($ScriptPath, [ref]$tokens, [ref]$errors)
if ($errors.Count) { throw ($errors | Out-String) }
# Load functions, not the production entrypoint. Registry writes stay in HKCU.
foreach ($node in $ast.FindAll({ param($n)
    $n -is [System.Management.Automation.Language.FunctionDefinitionAst]
}, $false)) {
    . ([scriptblock]::Create($node.Extent.Text))
}
$id = [guid]::NewGuid().ToString("N")
$testRoot = "HKCU:\Software\LazyingArt-Update-Test-$id"
$StateRoot = Join-Path $env:TEMP "LazyingArt-Update-Test-$id"
$installStatePath = Join-Path $StateRoot "install-state.json"
$defaultBackupPath = Join-Path $StateRoot "state-before-first-apply.json"
$windowsUpdatePolicy = Join-Path $testRoot "WindowsUpdate"
$automaticUpdatePolicy = Join-Path $windowsUpdatePolicy "AU"
$powerPolicyBase = Join-Path $testRoot "Power"
$BackupPath = ""
$UpdatesOnly = $true
$scope = "UpdatesOnly"
$powerSettings = @([pscustomobject]@{Name="Test";MachinePolicy=$true;Setting="test"})
$script:checks = 0
function Assert-Test {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { throw $Message }
    $script:checks++
}
function Assert-Throws {
    param([scriptblock]$Action, [string]$Message)
    $thrown = $false
    try { & $Action } catch { $thrown = $true }
    Assert-Test $thrown $Message
}
function Get-ActivePowerSchemeGuid { return "00000000-0000-0000-0000-000000000001" }
function Get-PowerSettingState { return [pscustomobject]@{AC=120;DC=60} }
function Invoke-PowerCfg { throw "UpdatesOnly must not mutate power" }
function Get-OrCreateAlwaysOnScheme { throw "UpdatesOnly must not create a power plan" }
function Test-PowerSchemeExists { throw "UpdatesOnly restore must not depend on old power plans" }
function Invoke-PolicyRefresh { return "Test: no machine-policy refresh" }
try {
    $desired = @(Get-DesiredRegistryValues)
    Assert-Test ($desired.Count -eq 9) "Expected nine update policies"
    Assert-Test (@($desired | Where-Object { $_.Path -notlike "$testRoot*" }).Count -eq 0) "Unexpected target"
    Assert-Throws { Assert-StateScope ([pscustomobject]@{Scope="AlwaysOn"}) } "Cross-scope state accepted"
    Assert-Throws { Assert-StateScope ([pscustomobject]@{}) } "Legacy full-scope state accepted"
    Set-RegistryValue $automaticUpdatePolicy "NoAutoUpdate" DWord 0
    $applied = Invoke-Apply
    Assert-Test $applied.Status.ConfigurationCompliant "Apply failed"
    Assert-Test (-not $applied.Status.PowerCompliant) "Original power settings not retained"
    Assert-Test (-not $applied.Status.PowerSettingsManaged) "Scope manages power"
    Assert-Test ($null -eq $applied.AlwaysOnPowerSchemeGuid) "Power scheme created"
    $hash = (Get-FileHash $defaultBackupPath).Hash
    $again = Invoke-Apply
    Assert-Test $again.Success "Second Apply failed"
    Assert-Test ((Get-FileHash $defaultBackupPath).Hash -eq $hash) "Backup overwritten"
    $extra = Get-Content $defaultBackupPath -Raw | ConvertFrom-Json
    $extra.RegistryValues += [pscustomobject]@{Path=$testRoot;Name="unexpected";Exists=$false;Kind=$null;Data=$null}
    Assert-Throws { Assert-RollbackBackup $extra } "Unrelated rollback target accepted"
    $restored = Invoke-Restore
    Assert-Test $restored.RestoreVerification.Verified "Restore failed"
    Assert-Test ((Get-RegistryValueSnapshot $automaticUpdatePolicy "NoAutoUpdate").Data -eq 0) "Value not restored"
    Assert-Test (-not (Get-RegistryValueSnapshot $windowsUpdatePolicy "TargetReleaseVersion").Exists) "Absent value not removed"
    $restoredAgain = Invoke-Restore
    Assert-Test $restoredAgain.Success "Repeated Restore failed"
    $reapplied = Invoke-Apply
    Assert-Test $reapplied.Success "Reapply failed"
    Assert-Test ((Get-FileHash $defaultBackupPath).Hash -eq $hash) "Reapply changed baseline"
    $UpdatesOnly = $false
    $scope = "AlwaysOn"
    Assert-StateScope ([pscustomobject]@{})
    Assert-Test (@(Get-DesiredRegistryValues).Count -gt 9) "Full scope lost original policies"
    Assert-Throws { Assert-StateScope ([pscustomobject]@{Scope="UpdatesOnly"}) } "Full scope accepted update-only state"
    [pscustomobject]@{Success=$true;Checks=$script:checks;MachineSettingsChanged=$false} | ConvertTo-Json
}
finally {
    if (Test-Path $testRoot) { Remove-Item $testRoot -Recurse -Force }
    if (Test-Path $StateRoot) { Remove-Item $StateRoot -Recurse -Force }
}

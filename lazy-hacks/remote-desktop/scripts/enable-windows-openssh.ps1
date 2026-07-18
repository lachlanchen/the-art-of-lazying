# Run from an elevated Windows PowerShell session.
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$PublicKeyPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal]::new($identity)
$administrator = [Security.Principal.WindowsBuiltInRole]::Administrator

if (-not $principal.IsInRole($administrator)) {
    throw 'Open PowerShell as Administrator, then run this script again.'
}

$resolvedKeyPath = (Resolve-Path -LiteralPath $PublicKeyPath).Path
$authorizedKey = (Get-Content -LiteralPath $resolvedKeyPath -Raw).Trim()

if ($authorizedKey -notmatch '^ssh-(ed25519|rsa|ecdsa-[^ ]+)\s+[A-Za-z0-9+/]+={0,3}(?:\s+.*)?$') {
    throw "The file does not contain one valid OpenSSH public-key line: $resolvedKeyPath"
}

$capabilityName = 'OpenSSH.Server~~~~0.0.1.0'
$capability = Get-WindowsCapability -Online -Name $capabilityName

if ($capability.State -ne 'Installed') {
    Write-Host 'Installing OpenSSH Server...'
    Add-WindowsCapability -Online -Name $capabilityName | Out-Host
}

Set-Service -Name sshd -StartupType Automatic
Start-Service -Name sshd

$ruleName = 'OpenSSH-Server-In-TCP'
$rule = Get-NetFirewallRule -Name $ruleName -ErrorAction SilentlyContinue

if ($null -eq $rule) {
    $rule = New-NetFirewallRule `
        -Name $ruleName `
        -DisplayName 'OpenSSH Server (sshd)' `
        -Enabled True `
        -Direction Inbound `
        -Protocol TCP `
        -Action Allow `
        -LocalPort 22 `
        -Profile Any `
        -RemoteAddress LocalSubnet
} else {
    $rule | Set-NetFirewallRule -Enabled True -Action Allow -Profile Any
    $rule | Get-NetFirewallPortFilter |
        Set-NetFirewallPortFilter -Protocol TCP -LocalPort 22
    $rule | Get-NetFirewallAddressFilter |
        Set-NetFirewallAddressFilter -RemoteAddress LocalSubnet
}

$sshDataDirectory = Join-Path $env:ProgramData 'ssh'
$authorizedKeysPath = Join-Path $sshDataDirectory 'administrators_authorized_keys'
New-Item -ItemType Directory -Path $sshDataDirectory -Force | Out-Null

$existingKeys = if (Test-Path -LiteralPath $authorizedKeysPath) {
    @(Get-Content -LiteralPath $authorizedKeysPath |
        Where-Object { $_.Trim().Length -gt 0 })
} else {
    @()
}

if ($existingKeys -notcontains $authorizedKey) {
    $existingKeys += $authorizedKey
    Set-Content `
        -LiteralPath $authorizedKeysPath `
        -Value $existingKeys `
        -Encoding ascii
}

& icacls.exe $authorizedKeysPath `
    /inheritance:r `
    /grant:r '*S-1-5-32-544:F' `
    /grant:r '*S-1-5-18:F' | Out-Host

if ($LASTEXITCODE -ne 0) {
    throw "Failed to secure $authorizedKeysPath"
}

Restart-Service -Name sshd

$service = Get-Service -Name sshd
$addressFilter = Get-NetFirewallRule -Name $ruleName |
    Get-NetFirewallAddressFilter
$listeners = @(Get-NetTCPConnection -State Listen -LocalPort 22)

Write-Host ''
Write-Host "sshd status: $($service.Status); startup: $($service.StartType)"
Write-Host "Authorized keys: $authorizedKeysPath"
Write-Host "Firewall remote scope: $($addressFilter.RemoteAddress -join ', ')"
Write-Host "TCP 22 listeners: $($listeners.Count)"

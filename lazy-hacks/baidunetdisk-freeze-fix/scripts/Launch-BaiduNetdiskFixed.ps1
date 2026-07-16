[CmdletBinding()]
param(
    [switch]$ForceRestart
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$fixedRoot = [IO.Path]::GetFullPath((Join-Path $env:APPDATA 'baidu\BaiduNetdisk')).TrimEnd('\')
$fixedRootPrefix = $fixedRoot + '\'
$fixedExe = Join-Path $fixedRoot 'BaiduNetdisk.exe'
$fixedBrowser = Join-Path $fixedRoot 'module\BrowserEngine\BaiduNetdiskUnite.exe'
$expectedSigner = 'Beijing Duyou Science and Technology'
$artifacts = @(
    @{ Path = $fixedExe; ExpectedVersion = '8.5.8.107' },
    @{ Path = $fixedBrowser; ExpectedVersion = '8.5.8.443' }
)
$processNames = @(
    'BaiduNetdisk',
    'BaiduNetdiskUnite',
    'baidunetdiskhost',
    'YunDetectService'
)

foreach ($artifact in $artifacts) {
    $path = $artifact.Path
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Required Baidu Netdisk executable not found: $path"
    }
    $actualVersion = (Get-Item -LiteralPath $path).VersionInfo.FileVersion
    if ($actualVersion -ne $artifact.ExpectedVersion) {
        throw "Expected $($artifact.ExpectedVersion), but found $actualVersion at $path"
    }
    $signature = Get-AuthenticodeSignature -LiteralPath $path
    $signerSubject = if ($signature.SignerCertificate) {
        $signature.SignerCertificate.Subject
    } else {
        '<none>'
    }
    if ($signature.Status -ne 'Valid' -or $signerSubject -notlike "*$expectedSigner*") {
        throw "Refusing to launch untrusted executable: $path ($($signature.Status), $signerSubject)"
    }
}

$running = @(Get-Process -ErrorAction SilentlyContinue | Where-Object {
    $_.ProcessName -in $processNames
})
$otherRunning = @($running | Where-Object {
    -not $_.Path -or -not $_.Path.StartsWith($fixedRootPrefix, [StringComparison]::OrdinalIgnoreCase)
})

if ($ForceRestart -or $otherRunning.Count -gt 0) {
    $running | Stop-Process -Force -ErrorAction SilentlyContinue

    for ($attempt = 0; $attempt -lt 12; $attempt++) {
        Start-Sleep -Milliseconds 250
        $remaining = @(Get-Process -ErrorAction SilentlyContinue | Where-Object {
            $_.ProcessName -in $processNames
        })
        if ($remaining.Count -eq 0) {
            break
        }
    }

    $remaining = @(Get-Process -ErrorAction SilentlyContinue | Where-Object {
        $_.ProcessName -in $processNames
    })
    if ($remaining.Count -gt 0) {
        throw "Could not stop all conflicting Baidu processes: $($remaining.Id -join ', ')"
    }
}

Start-Process -FilePath $fixedExe -WorkingDirectory $fixedRoot

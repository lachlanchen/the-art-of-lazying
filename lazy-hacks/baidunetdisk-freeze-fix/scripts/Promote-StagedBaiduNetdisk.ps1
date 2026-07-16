[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
param(
    [Parameter(Mandatory)]
    [string]$StagedRoot,

    [Parameter(Mandatory)]
    [string]$BackupRoot,

    [string]$ExpectedMainVersion = '8.5.8.107',

    [string]$ExpectedBrowserVersion = '8.5.8.443'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$processNames = @(
    'BaiduNetdisk',
    'BaiduNetdiskUnite',
    'baidunetdiskhost',
    'YunDetectService'
)
$expectedSigner = 'Beijing Duyou Science and Technology'
$baiduParent = Join-Path $env:APPDATA 'baidu'
$activeRoot = Join-Path $baiduParent 'BaiduNetdisk'

if (-not (Test-Path -LiteralPath $StagedRoot -PathType Container)) {
    throw "Staged directory not found: $StagedRoot"
}
if (-not (Test-Path -LiteralPath $activeRoot -PathType Container)) {
    throw "Active Baidu Netdisk directory not found: $activeRoot"
}

$staged = (Resolve-Path -LiteralPath $StagedRoot).Path
$active = (Resolve-Path -LiteralPath $activeRoot).Path
$parent = (Resolve-Path -LiteralPath $baiduParent).Path

if ($staged.Equals($active, [StringComparison]::OrdinalIgnoreCase)) {
    throw 'The staged and active directories must be different.'
}
if (-not $active.StartsWith($parent, [StringComparison]::OrdinalIgnoreCase)) {
    throw "Unsafe active path: $active"
}

$stagedMain = Join-Path $staged 'BaiduNetdisk.exe'
$stagedBrowser = Join-Path $staged 'module\BrowserEngine\BaiduNetdiskUnite.exe'
foreach ($file in @($stagedMain, $stagedBrowser)) {
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
        throw "Required staged file not found: $file"
    }
    $signature = Get-AuthenticodeSignature -LiteralPath $file
    if ($signature.Status -ne 'Valid') {
        throw "Invalid Authenticode signature for ${file}: $($signature.Status)"
    }
    $signerSubject = if ($signature.SignerCertificate) {
        $signature.SignerCertificate.Subject
    } else {
        '<none>'
    }
    if ($signerSubject -notlike "*$expectedSigner*") {
        throw "Unexpected Authenticode signer for ${file}: $signerSubject"
    }
}

$mainVersion = (Get-Item -LiteralPath $stagedMain).VersionInfo.FileVersion
$browserVersion = (Get-Item -LiteralPath $stagedBrowser).VersionInfo.FileVersion
if ($mainVersion -ne $ExpectedMainVersion) {
    throw "Expected main version $ExpectedMainVersion, found $mainVersion"
}
if ($browserVersion -ne $ExpectedBrowserVersion) {
    throw "Expected BrowserEngine version $ExpectedBrowserVersion, found $browserVersion"
}

$activeVersion = (Get-Item -LiteralPath (Join-Path $active 'BaiduNetdisk.exe')).VersionInfo.FileVersion
$archiveName = 'BaiduNetdisk-{0}-installed-{1}' -f $activeVersion, (Get-Date -Format 'yyyyMMdd-HHmmss')
$backupParent = [IO.Path]::GetFullPath($BackupRoot)
$archive = Join-Path $backupParent $archiveName
$pathSeparator = [IO.Path]::DirectorySeparatorChar
if ($backupParent.Equals($active, [StringComparison]::OrdinalIgnoreCase) -or
    $backupParent.StartsWith($active + $pathSeparator, [StringComparison]::OrdinalIgnoreCase)) {
    throw "BackupRoot must not be inside the active installation: $backupParent"
}
if ($backupParent.Equals($staged, [StringComparison]::OrdinalIgnoreCase) -or
    $backupParent.StartsWith($staged + $pathSeparator, [StringComparison]::OrdinalIgnoreCase)) {
    throw "BackupRoot must not be inside the staged installation: $backupParent"
}

if (-not $PSCmdlet.ShouldProcess(
    $active,
    "Archive $activeVersion to '$archive' and promote signed $mainVersion from '$staged'"
)) {
    return
}

New-Item -ItemType Directory -Path $backupParent -Force | Out-Null
if (Test-Path -LiteralPath $archive) {
    throw "Backup destination already exists: $archive"
}

for ($attempt = 0; $attempt -lt 4; $attempt++) {
    $running = @(Get-Process -ErrorAction SilentlyContinue | Where-Object {
        $_.ProcessName -in $processNames
    })
    if ($running.Count -eq 0) {
        break
    }
    $running | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
}

$remaining = @(Get-Process -ErrorAction SilentlyContinue | Where-Object {
    $_.ProcessName -in $processNames
})
if ($remaining.Count -gt 0) {
    throw "Could not stop all Baidu processes: $($remaining.Id -join ', ')"
}

Move-Item -LiteralPath $active -Destination $archive
try {
    Move-Item -LiteralPath $staged -Destination $activeRoot
} catch {
    if (Test-Path -LiteralPath $activeRoot) {
        $failedPromotion = Join-Path $backupParent (
            'failed-promotion-{0}' -f (Get-Date -Format 'yyyyMMdd-HHmmss')
        )
        Move-Item -LiteralPath $activeRoot -Destination $failedPromotion
    }
    if (Test-Path -LiteralPath $archive) {
        Move-Item -LiteralPath $archive -Destination $activeRoot
    }
    throw
}

[pscustomobject]@{
    ActivePath          = $activeRoot
    MainVersion        = $mainVersion
    BrowserVersion     = $browserVersion
    ArchivedOldPath    = $archive
    ArchivedOldVersion = $activeVersion
}

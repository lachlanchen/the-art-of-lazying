[CmdletBinding()]
param(
    [ValidateRange(1, 120)]
    [int]$Samples = 6,

    [ValidateRange(1, 60)]
    [int]$IntervalSeconds = 5,

    [ValidateRange(100, 8192)]
    [int]$MaxMainPrivateMB = 600,

    [string]$ExpectedRoot = (Join-Path $env:APPDATA 'baidu\BaiduNetdisk'),

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
$expectedRootPath = (Resolve-Path -LiteralPath $ExpectedRoot).Path.TrimEnd('\')
$expectedRootPrefix = $expectedRootPath + '\'
$expectedArtifacts = @(
    @{ Path = (Join-Path $expectedRootPath 'BaiduNetdisk.exe'); Version = $ExpectedMainVersion },
    @{ Path = (Join-Path $expectedRootPath 'module\BrowserEngine\BaiduNetdiskUnite.exe'); Version = $ExpectedBrowserVersion }
)
foreach ($artifact in $expectedArtifacts) {
    $item = Get-Item -LiteralPath $artifact.Path
    $signature = Get-AuthenticodeSignature -LiteralPath $artifact.Path
    $signerSubject = if ($signature.SignerCertificate) {
        $signature.SignerCertificate.Subject
    } else {
        '<none>'
    }
    if ($item.VersionInfo.FileVersion -ne $artifact.Version) {
        throw "Unexpected version at $($artifact.Path): $($item.VersionInfo.FileVersion)"
    }
    if ($signature.Status -ne 'Valid' -or $signerSubject -notlike "*$expectedSigner*") {
        throw "Untrusted executable at $($artifact.Path): $($signature.Status), $signerSubject"
    }
}
$testStart = Get-Date
$failed = $false

for ($sample = 1; $sample -le $Samples; $sample++) {
    Start-Sleep -Seconds $IntervalSeconds

    $processes = @(Get-Process -ErrorAction SilentlyContinue | Where-Object {
        $_.ProcessName -in $processNames
    })
    $outsideRootProcesses = @($processes | Where-Object {
        -not $_.Path -or
        -not $_.Path.StartsWith($expectedRootPrefix, [StringComparison]::OrdinalIgnoreCase)
    })
    $browserProcess = Get-CimInstance Win32_Process -Filter "Name='BaiduNetdiskUnite.exe'" |
        Where-Object { $_.CommandLine -notmatch '--type=' } |
        Select-Object -First 1
    $main = if ($browserProcess) {
        $processes | Where-Object { $_.Id -eq $browserProcess.ProcessId } | Select-Object -First 1
    } else {
        $processes | Where-Object { $_.ProcessName -eq 'BaiduNetdisk' } | Select-Object -First 1
    }

    $totalWorkingSet = ($processes | Measure-Object WorkingSet64 -Sum).Sum
    $totalPrivate = ($processes | Measure-Object PrivateMemorySize64 -Sum).Sum
    $mainPrivateMB = if ($main) {
        [math]::Round($main.PrivateMemorySize64 / 1MB, 1)
    } else {
        $null
    }
    $mainVersion = if ($main -and $main.Path) {
        (Get-Item -LiteralPath $main.Path).VersionInfo.FileVersion
    } else {
        $null
    }
    $mainPathValid = $main -and $main.Path -and
        $main.Path.StartsWith($expectedRootPrefix, [StringComparison]::OrdinalIgnoreCase)

    [pscustomobject]@{
        Sample            = $sample
        Time              = (Get-Date).ToString('HH:mm:ss')
        Processes         = $processes.Count
        TotalWorkingSetMB = [math]::Round($totalWorkingSet / 1MB, 1)
        TotalPrivateMB    = [math]::Round($totalPrivate / 1MB, 1)
        MainPID           = if ($main) { $main.Id } else { $null }
        MainResponding    = if ($main) { $main.Responding } else { $false }
        MainPrivateMB     = $mainPrivateMB
        MainVersion       = $mainVersion
        MainPath          = if ($main) { $main.Path } else { $null }
        OutsideRootCount  = $outsideRootProcesses.Count
    }

    if (-not $main -or -not $main.Responding -or -not $mainPathValid -or
        $mainVersion -ne $ExpectedBrowserVersion -or
        $outsideRootProcesses.Count -gt 0) {
        $failed = $true
    }
    if ($null -ne $mainPrivateMB -and $mainPrivateMB -gt $MaxMainPrivateMB) {
        $failed = $true
    }
}

$newHangs = @(Get-WinEvent -FilterHashtable @{
    LogName   = 'Application'
    StartTime = $testStart
    Id        = 1002
} -ErrorAction SilentlyContinue | Where-Object {
    $_.Message -match 'BaiduNetdiskUnite'
})
if ($newHangs.Count -gt 0) {
    $failed = $true
}

[pscustomobject]@{
    TestStart     = $testStart
    TestEnd       = Get-Date
    NewHangEvents = $newHangs.Count
    Passed        = -not $failed
}

if ($failed) {
    Write-Error "Baidu Netdisk failed the health threshold ($MaxMainPrivateMB MB main private memory)."
    exit 1
}

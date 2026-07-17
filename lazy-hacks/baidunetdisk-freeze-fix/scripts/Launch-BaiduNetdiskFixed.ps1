[CmdletBinding()]
param(
    [switch]$ForceRestart,

    [int]$RequireExistingUiProcessId = 0
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$fixedRoot = [IO.Path]::GetFullPath((Join-Path $env:APPDATA 'baidu\BaiduNetdisk')).TrimEnd('\')
$fixedRootPrefix = $fixedRoot + '\'
$fixedExe = Join-Path $fixedRoot 'BaiduNetdisk.exe'
$fixedBrowser = Join-Path $fixedRoot 'module\BrowserEngine\BaiduNetdiskUnite.exe'
$fixedSdk = Join-Path $fixedRoot 'kernel_btsdk.dll'
$expectedSigner = 'Beijing Duyou Science and Technology'
$expectedSdkSha256 = 'EF50D1EFE473851442C10448BF120529C5491AA8B5FB4D373B8D9469024F8DCB'
$artifacts = @(
    @{
        Path = $fixedExe
        ExpectedVersion = '8.5.8.107'
        ExpectedSha256 = $null
        RequireReadOnly = $false
    },
    @{
        Path = $fixedBrowser
        ExpectedVersion = '8.5.8.443'
        ExpectedSha256 = $null
        RequireReadOnly = $false
    },
    @{
        Path = $fixedSdk
        ExpectedVersion = $null
        ExpectedSha256 = $expectedSdkSha256
        RequireReadOnly = $false
    }
)
$processNames = @(
    'BaiduNetdisk',
    'BaiduNetdiskUnite',
    'baidunetdiskhost',
    'YunDetectService'
)

function Get-ActiveBaiduProcesses {
    @(Get-Process -ErrorAction SilentlyContinue | Where-Object {
        if ($_.ProcessName -notin $processNames) {
            $false
        } else {
            try {
                -not $_.HasExited
            } catch {
                $false
            }
        }
    })
}

foreach ($artifact in $artifacts) {
    $path = $artifact.Path
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Required Baidu Netdisk component not found: $path"
    }
    $item = Get-Item -LiteralPath $path
    $actualVersion = $item.VersionInfo.FileVersion
    if ($artifact.ExpectedVersion -and $actualVersion -ne $artifact.ExpectedVersion) {
        throw "Expected $($artifact.ExpectedVersion), but found $actualVersion at $path"
    }
    if ($artifact.ExpectedSha256) {
        $actualHash = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
        if ($actualHash -ne $artifact.ExpectedSha256) {
            throw "Refusing unexpected Baidu component at ${path}: $actualHash"
        }
    }
    if ($artifact.RequireReadOnly -and -not $item.IsReadOnly) {
        throw "Pinned Baidu component is not read-only: $path"
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

$running = @(Get-ActiveBaiduProcesses)
$mayStopOnIntegrityFailure = $ForceRestart -or $running.Count -eq 0

if ($RequireExistingUiProcessId -lt 0) {
    throw '-RequireExistingUiProcessId must be a positive process ID.'
}
if ($RequireExistingUiProcessId -ne 0 -and -not $ForceRestart) {
    throw '-RequireExistingUiProcessId is only valid with -ForceRestart.'
}

function Assert-RequiredExistingUiProcess {
    param([object[]]$Processes)

    if ($RequireExistingUiProcessId -eq 0) {
        return
    }

    $required = @($Processes | Where-Object {
        $_.Id -eq $RequireExistingUiProcessId -and
        $_.ProcessName -eq 'BaiduNetdiskUnite'
    })
    if ($required.Count -ne 1) {
        throw "Required existing Baidu UI PID $RequireExistingUiProcessId is no longer running; refusing to restart or auto-start Baidu."
    }

    try {
        $requiredPath = [IO.Path]::GetFullPath($required[0].Path)
        if (-not $requiredPath.Equals($fixedBrowser, [StringComparison]::OrdinalIgnoreCase) -or
            $required[0].HasExited) {
            throw 'Required process changed.'
        }
    } catch {
        throw "Required existing Baidu UI PID $RequireExistingUiProcessId changed or exited; refusing to restart or auto-start Baidu."
    }
}

function Assert-AutomatedRestartProcessScope {
    param([object[]]$Processes)

    if ($RequireExistingUiProcessId -eq 0) {
        return
    }

    foreach ($process in $Processes) {
        try {
            $processPath = [IO.Path]::GetFullPath($process.Path)
            if (-not $processPath.StartsWith(
                $fixedRootPrefix,
                [StringComparison]::OrdinalIgnoreCase
            )) {
                throw 'Process is outside the checked root.'
            }
        } catch {
            throw "Baidu process PID $($process.Id) has an inaccessible or outside-root path; refusing automated restart."
        }
    }
}

Assert-RequiredExistingUiProcess -Processes $running
Assert-AutomatedRestartProcessScope -Processes $running

$otherRunning = @($running | Where-Object {
    -not $_.Path -or -not $_.Path.StartsWith($fixedRootPrefix, [StringComparison]::OrdinalIgnoreCase)
})
$hungVisibleUi = @($running | Where-Object {
    $_.ProcessName -eq 'BaiduNetdiskUnite' -and
    $_.MainWindowHandle -ne 0 -and
    -not $_.Responding
})

if (-not $ForceRestart) {
    if ($otherRunning.Count -gt 0) {
        throw "Baidu processes are running outside the checked 8.5.8 root: $($otherRunning.Id -join ', '). Normal launch will not terminate them; verify transfers and rerun with -ForceRestart only if interruption is safe."
    }
    if ($hungVisibleUi.Count -gt 0) {
        throw "Baidu's visible UI is not responding (PID $($hungVisibleUi.Id -join ', ')). Normal launch will not terminate possible transfers; use the sustained-hang watchdog or rerun with -ForceRestart only after confirming recovery is safe."
    }
}

if ($ForceRestart) {
    # Recheck immediately before the first destructive action. This prevents a
    # watchdog run from reopening Baidu when the user closed the observed UI.
    $running = @(Get-ActiveBaiduProcesses)
    Assert-RequiredExistingUiProcess -Processes $running
    Assert-AutomatedRestartProcessScope -Processes $running
    $running | Stop-Process -Force -ErrorAction SilentlyContinue

    for ($attempt = 0; $attempt -lt 120; $attempt++) {
        Start-Sleep -Milliseconds 250
        $remaining = @(Get-ActiveBaiduProcesses)
        if ($remaining.Count -eq 0) {
            break
        }
        if ($attempt % 8 -eq 7) {
            Assert-AutomatedRestartProcessScope -Processes $remaining
            $remaining | Stop-Process -Force -ErrorAction SilentlyContinue
        }
    }

    $remaining = @(Get-ActiveBaiduProcesses)
    if ($remaining.Count -gt 0) {
        throw "Could not stop all conflicting Baidu processes: $($remaining.Id -join ', ')"
    }
}

# Starting the same signed build again lets its single-instance handler focus an
# existing healthy window. Only explicit -ForceRestart is destructive; if Baidu
# is not running, this launches a fresh instance.
Start-Process -FilePath $fixedExe -WorkingDirectory $fixedRoot

Start-Sleep -Seconds 2
$sdkHashAfterLaunch = (Get-FileHash -LiteralPath $fixedSdk -Algorithm SHA256).Hash
if ($sdkHashAfterLaunch -ne $expectedSdkSha256) {
    if ($mayStopOnIntegrityFailure) {
        Get-ActiveBaiduProcesses |
            Stop-Process -Force -ErrorAction SilentlyContinue
    }
    throw "Baidu replaced the pinned SDK during launch: $sdkHashAfterLaunch"
}

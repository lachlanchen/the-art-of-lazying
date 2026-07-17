# Fix Baidu Netdisk 8.5.x freezes on Windows

This playbook covers two distinct `BaiduNetdiskUnite.exe` failures:

1. an 8.5.5/BrowserEngine 8.5.6 memory runaway, fixed by promoting the complete
   signed 8.5.8 client; and
2. an 8.5.8 physical right-click hang in Baidu's floating window, mitigated by
   disabling that window in Baidu's own settings.

The verified repair does not modify executable bytes, DLLs, or ASAR archives.

## Verified fix at a glance

The tested signed build is:

```text
BaiduNetdisk.exe       8.5.8.107
BaiduNetdiskUnite.exe  8.5.8.443
kernel_btsdk.dll       1.0.10.31
```

The active SDK SHA-256 is:

```text
EF50D1EFE473851442C10448BF120529C5491AA8B5FB4D373B8D9469024F8DCB
```

In Baidu, use only left-clicks to open:

```text
Settings -> Startup Settings -> Show floating window
设置 -> 启动设置 -> 显示悬浮窗
```

Uncheck that option. The floating window disappears immediately and remains
disabled after restart.

If Baidu is already frozen, save the names of any active transfers if possible,
then recover it with the checked launcher:

```powershell
.\scripts\Launch-BaiduNetdiskFixed.ps1 -ForceRestart
```

Run the health check after the UI is ready:

```powershell
.\scripts\Test-BaiduNetdiskHealth.ps1 `
  -Samples 6 `
  -IntervalSeconds 5
```

By default, the health check treats any visible small Baidu floating window as
a failure and prints the settings path above. `-AllowFloatingWindow` is a
diagnostic escape hatch, not the recommended configuration for 8.5.8.443.

## Verified outcome

On 2026-07-17, after unchecking `显示悬浮窗`:

- a clean restart produced one visible 1200-by-800 Baidu window and zero
  floating windows;
- the setting remained disabled across the restart;
- a real Windows right-click in the main file window stayed responsive for 40
  consecutive 250 ms samples;
- the renderer count stayed at four instead of creating a menu renderer; and
- no executable, DLL, shell registration, download directory, or cloud file
  was changed.

This is deliberately narrower than claiming every future 8.5.8 operation is
fixed. It removes the exact native window-creation path that was reproduced and
dumped, while normal main-window right-click menus continue to work.

## Why the floating window hangs

Synthetic posted mouse messages initially appeared to pass, but a real Windows
right-click consistently reproduced the hang. At the click timestamp, Baidu
created a new `--type=renderer` process and never produced a usable menu window.
The backend and network processes stayed alive while the visible UI stopped
responding.

The shipped 8.5.8 JavaScript explains the process creation:

```text
floating-window rightbuttondown
  -> OPEN_SESTON_MENU
  -> create /sestonMenu
  -> new Electron BrowserWindow (188 px wide)
```

Ordinary file-list context menus use a DOM menu in the existing renderer. They
do not create this extra `BrowserWindow`.

A full user dump placed the main `CrBrowserMain` thread inside themed window
positioning and an indefinite `WaitForSingleObject`. A live non-invasive WinDbg
query showed its wait handle was an unsignaled auto-reset event. A second Baidu
thread was inside `UIAutomationCore` and synchronously messaging the UI thread.
The evidence therefore supports a native Electron window/UI Automation
deadlock during floating-menu creation. It does not identify a safe binary byte
to patch.

## What did not fix the right-click regression

- Rolling signed `kernel_btsdk.dll` back from `1.0.10.31` to `1.0.10.30` did
  not change the physical-click hang. Normal signed writable `.31` was restored.
- Blocking Baidu's legacy and modern Explorer context-menu COM classes did not
  help. Those per-user block values should not be retained for this fix.
- Reposting `WM_RBUTTON*` messages was not a valid physical-input test.
- Cache cleanup was already exhausted, and `Local State` already had hardware
  acceleration disabled.
- Pagefile pressure, total RAM use, and GPU load did not match the freeze.

Keep diagnosis reversible. Do not replace a signed Baidu DLL based only on a
synthetic click, and do not publish a full process dump because it may contain
account/session data.

## Setting persistence

Baidu's settings page calls its native settings API with:

```text
scope:   personal user
section: local_info
key:     sestonSwitch
value:   false
```

The backing file is the current BrowserEngine user's `PersonalSetting.xml`.
It is managed/encrypted and has a `.bak`; do not hand-edit it. Use the settings
page so Baidu writes and applies the value consistently.

## Checked launcher

`scripts/Launch-BaiduNetdiskFixed.ps1` verifies:

- the normal `%APPDATA%\baidu\BaiduNetdisk` install path;
- main version `8.5.8.107`;
- BrowserEngine version `8.5.8.443`;
- valid Beijing Duyou Authenticode signatures; and
- the expected writable `.31` SDK hash before and after launch.

It also restarts a visibly hung UI and ignores already-terminating zombie
process objects when waiting for active Baidu processes to exit. A forced
restart interrupts active transfers, so use `-ForceRestart` intentionally.

The companion health script samples the active root BrowserEngine process,
validates its path/version/memory/responding state, checks the signed artifacts
again, detects the floating window, and checks Windows events 1001 and 1002 for
new Baidu hangs.

## Stable desktop shortcut and Start menu

The included command shim expects this repository at:

```text
%USERPROFILE%\Projects\the-art-of-lazying
```

Create a desktop shortcut that points to the shim:

```powershell
$shim = Join-Path $PWD 'scripts\baidunetdisk-stable.cmd'
$desktop = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktop 'BaiduNetdisk Stable.lnk'
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $shim
$shortcut.WorkingDirectory = Split-Path -Parent $shim
$shortcut.Save()
```

Remove any old Start-menu shortcut that points to 8.5.5 or a staging folder.
Keeping a single checked desktop entry avoids accidentally relaunching the
archived client. Do not remove the Apps & Features uninstaller entry.

## Upgrade an unstable 8.5.5 installation

This section is only for the older memory-runaway failure. If signed 8.5.8 is
already active, skip to the floating-window setting above.

### Inspect the staged full package

On the repaired machine, Baidu had staged:

```powershell
$cab = Join-Path $env:APPDATA `
  'baidu\BaiduNetdisk\AutoUpdate\Download\MainApp\fullpackage_858107_x64.cab'
expand.exe -D $cab
```

The observed CAB SHA-256 was:

```text
76B5E4637DA01D455A658F742AD8BC22B17994B0BEDA604CBC410C7D6F444A0F
```

Extract it outside the live install and verify the signed files:

```powershell
$stage = Join-Path $HOME 'Projects\BaiduNetdiskFreezeFix\BaiduNetdisk-8.5.8.107'
New-Item -ItemType Directory -Path $stage -Force | Out-Null
expand.exe '-F:*' $cab $stage

$main = Join-Path $stage 'BaiduNetdisk.exe'
$browser = Join-Path $stage 'module\BrowserEngine\BaiduNetdiskUnite.exe'

(Get-Item $main).VersionInfo.FileVersion
(Get-Item $browser).VersionInfo.FileVersion
Get-AuthenticodeSignature $main
Get-AuthenticodeSignature $browser
```

Hashes from the exact staged package used here were:

```text
BaiduNetdisk.exe       F2E50ECD012C7B8D4269045C3937BAFDEBE2E2B3ED938F1AE03CAE28075F16C6
BaiduNetdiskUnite.exe  380DF87F28850FD284DAEB9C10354AC503D23F7CDD193B8BE4D6E883970A6C68
```

A valid Baidu Authenticode signature is the durable trust check for a different
legitimate package; do not trust a filename alone.

### Test before promotion

Stop known Baidu processes and launch the staged copy from its own directory:

```powershell
$names = @(
  'BaiduNetdisk',
  'BaiduNetdiskUnite',
  'baidunetdiskhost',
  'YunDetectService'
)

Get-Process -ErrorAction SilentlyContinue |
  Where-Object { $_.ProcessName -in $names -and -not $_.HasExited } |
  Stop-Process -Force

Start-Process `
  -FilePath (Join-Path $stage 'BaiduNetdisk.exe') `
  -WorkingDirectory $stage
```

For an isolated CAB that has not created its runtime-managed SDK, skip only
that artifact check:

```powershell
.\scripts\Test-BaiduNetdiskHealth.ps1 `
  -ExpectedRoot $stage `
  -SkipSdkValidation `
  -AllowFloatingWindow `
  -Samples 6 `
  -IntervalSeconds 5
```

The diagnostic `-AllowFloatingWindow` is needed only until the staged UI can be
opened and the floating-window option turned off.

### Promote reversibly

Preview the included promotion script:

```powershell
.\scripts\Promote-StagedBaiduNetdisk.ps1 `
  -StagedRoot $stage `
  -BackupRoot "$HOME\Projects\BaiduNetdiskFreezeFix\backups" `
  -WhatIf
```

Review the paths, then rerun without `-WhatIf`. The script verifies versions
and signatures, stops only known Baidu processes, archives the active tree,
moves the staged signed build to the original path, and restores the old tree
automatically if promotion fails. It does not alter `%APPDATA%\BaiduNetdisk`
or any download directory.

## Rollback

To re-enable the floating window, use the same Baidu settings checkbox. On
BrowserEngine 8.5.8.443 this also restores the reproduced freeze path, so only
do that to test a newer signed build.

To restore an archived client, save active transfers, stop active Baidu
processes, move the current tree aside, and move the archive back to:

```text
%APPDATA%\baidu\BaiduNetdisk
```

Keep rollback archives outside the active tree and never point a normal
shortcut at them. Apps & Features can retain an older cosmetic version label;
the signed active executable versions are authoritative.

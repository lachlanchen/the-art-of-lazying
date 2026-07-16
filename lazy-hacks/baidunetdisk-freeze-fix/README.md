# Fix Baidu Netdisk 8.5.x Freezes on Windows

This playbook documents a reproducible `BaiduNetdiskUnite.exe` freeze and the
reversible migration that fixed it. The affected client was Baidu Netdisk
`8.5.5.103` with BrowserEngine `8.5.6.436`; the working client is the signed
`8.5.8.107` build with BrowserEngine `8.5.8.443`.

The final repair does **not** hex-edit or patch a signed executable. It promotes
an intact, signed, internally consistent Baidu build and archives the old client
for rollback.

## Outcome

The only active client now lives at Baidu's normal path:

```text
%APPDATA%\baidu\BaiduNetdisk
```

Verified active versions:

```text
BaiduNetdisk.exe       8.5.8.107
BaiduNetdiskUnite.exe  8.5.8.443
```

Both executables have valid Authenticode signatures from Beijing Duyou Science
and Technology Co., Ltd.

Here, "only 8.5.8" means that `8.5.8` is the only active and default-launched
client. No shortcut or normal entry point targets `8.5.5`; its executable
remains in a private archive and can be run manually only for rollback.

## Failure Evidence

Windows recorded three identical `AppHangB1` failures on 2026-07-16 for:

```text
BaiduNetdiskUnite.exe 8.5.6.436
```

The visible BrowserEngine process became non-responsive and reached roughly
1.67 GB working set. After Windows closed it, Baidu relaunched the UI and its
private memory again climbed from about 922 MB to 1.42 GB in less than one
minute. The complete Baidu tree reached roughly 2.68 GB across 17 processes.

An orphan renderer survived one parent hang and consumed close to one CPU core.
The embedded-browser log also contained repeated Mojo/IPC validation failures:

```text
VALIDATION_ERROR_UNKNOWN_ENUM_VALUE
Message ... rejected by interface baidu.netdisk.plugin.mojom.p2pServer
```

Useful local evidence sources:

```text
Windows Application log, event IDs 1001 and 1002
%APPDATA%\baidu\BaiduNetdisk\module\BrowserEngine\debug.log
%APPDATA%\baidu\BaiduNetdisk\module\BrowserEngine\users\...\btConfig\btsdk.log
```

Do not publish full process command lines or raw logs. They can contain an
encrypted `StartInfo` value, account identifiers, and per-user paths.

## Why Not Patch with `xxd` or `objdump`?

`xxd` and `objdump` are useful for inspecting PE headers, sections, imports,
and byte differences. They are not a safe repair mechanism here:

- changing even one byte invalidates Authenticode;
- the old and new clients differ across the main executable, BrowserEngine,
  plugins, resources, and IPC schemas;
- the freeze reproduced after cache reset and a single-plugin rollback;
- replacing only `BaiduNetdiskUnite.exe` risks a new ABI or resource mismatch.

The smallest coherent boundary is therefore the complete signed 8.5.8 payload,
not a byte offset in one executable.

## What Did Not Fix It

These reversible tests were useful diagnostically but did not stop the delayed
memory surge in 8.5.5/8.5.6:

1. Terminating the full Baidu process tree, including orphan renderers.
2. Renaming only browser runtime caches:
   - `Cache`
   - `Code Cache`
   - `GPUCache`
   - `DawnCache`
   - `VideoDecodeStats`
   - `blob_storage`
   - `lockfile`
3. Resetting the P2P `btConfig` directory.
4. Rolling `vastplayer.dll` back from signed `2.2.4.114` to signed
   `2.2.4.100`.
5. Passing `--disable-gpu` to `BaiduNetdisk.exe`; the bootstrap executable did
   not forward that switch to `BaiduNetdiskUnite.exe`.

The machine also had an old Intel HD 530 driver and an active GameViewer virtual
display adapter. Those can aggravate Chromium rendering, but the direct evidence
and version-to-version result pointed to the client build itself.

## Locate and Inspect the Staged Build

On the repaired machine, Baidu had already staged this full package:

```powershell
$cab = Join-Path $env:APPDATA `
  'baidu\BaiduNetdisk\AutoUpdate\Download\MainApp\fullpackage_858107_x64.cab'
```

List it without extracting:

```powershell
expand.exe -D $cab
```

The observed CAB SHA-256 was:

```text
76B5E4637DA01D455A658F742AD8BC22B17994B0BEDA604CBC410C7D6F444A0F
```

Do not trust the filename alone. Extract to an isolated directory and verify
the signed files:

```powershell
$stage = Join-Path $HOME 'Projects\BaiduNetdiskFreezeFix\BaiduNetdisk-8.5.8.107'
New-Item -ItemType Directory -Path $stage
expand.exe '-F:*' $cab $stage

$main = Join-Path $stage 'BaiduNetdisk.exe'
$browser = Join-Path $stage 'module\BrowserEngine\BaiduNetdiskUnite.exe'

(Get-Item $main).VersionInfo.FileVersion
(Get-Item $browser).VersionInfo.FileVersion
Get-AuthenticodeSignature $main
Get-AuthenticodeSignature $browser
```

Expected SHA-256 values from the staged package used here:

```text
BaiduNetdisk.exe       F2E50ECD012C7B8D4269045C3937BAFDEBE2E2B3ED938F1AE03CAE28075F16C6
BaiduNetdiskUnite.exe  380DF87F28850FD284DAEB9C10354AC503D23F7CDD193B8BE4D6E883970A6C68
```

Hashes are evidence for this exact package, while a valid Baidu Authenticode
signature is the more durable trust check for another legitimate build.

## Test Before Promotion

Stop every old Baidu process, then launch the extracted build from its own
working directory:

```powershell
$names = @(
  'BaiduNetdisk',
  'BaiduNetdiskUnite',
  'baidunetdiskhost',
  'YunDetectService'
)

Get-Process -ErrorAction SilentlyContinue |
  Where-Object { $_.ProcessName -in $names } |
  Stop-Process -Force

Start-Process `
  -FilePath (Join-Path $stage 'BaiduNetdisk.exe') `
  -WorkingDirectory $stage
```

Open the real Baidu window and click through the same UI path that previously
hung. Use `scripts/Test-BaiduNetdiskHealth.ps1` to sample the BrowserEngine
parent process rather than relying on the window title, which disappears when
the app minimizes to the tray:

```powershell
.\scripts\Test-BaiduNetdiskHealth.ps1 `
  -ExpectedRoot $stage `
  -Samples 6 `
  -IntervalSeconds 5
```

## Promote 8.5.8 Reversibly

After the isolated build passes, use the included promotion script:

```powershell
.\scripts\Promote-StagedBaiduNetdisk.ps1 `
  -StagedRoot $stage `
  -BackupRoot "$HOME\Projects\BaiduNetdiskFreezeFix\backups" `
  -WhatIf
```

Review the paths, then rerun without `-WhatIf`:

```powershell
.\scripts\Promote-StagedBaiduNetdisk.ps1 `
  -StagedRoot $stage `
  -BackupRoot "$HOME\Projects\BaiduNetdiskFreezeFix\backups"
```

The script:

1. validates the expected main and BrowserEngine versions;
2. requires valid Authenticode signatures;
3. stops only known Baidu processes;
4. moves the active client into a timestamped rollback directory;
5. moves the staged signed build into the original install path;
6. automatically restores the old client if promotion fails.

It does not modify the separate Chromium profile at `%APPDATA%\BaiduNetdisk`
or any download directory.

## Launcher and Start Menu

`scripts/Launch-BaiduNetdiskFixed.ps1` verifies both normal-path executables,
their expected `8.5.8` versions, valid signatures, and Baidu signer before
launching the client.

The desktop shortcut on the repaired machine points through
`scripts/baidunetdisk-stable.cmd` to that launcher. Install that exact shim and
create the desktop shortcut from the repository root with:

```powershell
$shim = Join-Path $HOME 'baidunetdisk-stable.cmd'
Copy-Item `
  -LiteralPath '.\lazy-hacks\baidunetdisk-freeze-fix\scripts\baidunetdisk-stable.cmd' `
  -Destination $shim `
  -Force

$desktop = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktop 'BaiduNetdisk Stable.lnk'
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $shim
$shortcut.WorkingDirectory = $HOME
$shortcut.IconLocation = `
  "$env:APPDATA\baidu\BaiduNetdisk\BaiduNetdisk.exe,0"
$shortcut.Save()
```

The shim deliberately launches the checked-in PowerShell script rather than
starting `BaiduNetdisk.exe` directly, so the version, signature, signer, and
normal install path are revalidated on every restart.

The checked-in shim assumes this repository is cloned at
`%USERPROFILE%\Projects\the-art-of-lazying`. Edit `FIX_LAUNCHER` in the copied
shim if the clone lives elsewhere.

The obsolete Start-menu launcher was moved into a rollback folder; the
uninstaller shortcut was retained.

If the old shortcut is a normal `.lnk`, remove it reversibly like this:

```powershell
$source = Join-Path $env:APPDATA `
  'Microsoft\Windows\Start Menu\Programs\百度网盘\百度网盘.lnk'
$backup = "$HOME\Projects\BaiduNetdiskFreezeFix\shortcut-backups"

New-Item -ItemType Directory -Path $backup -Force | Out-Null
Move-Item -LiteralPath $source -Destination $backup
```

## Verify the Final Normal Path

Launch the original path, not the staging directory:

```powershell
$exe = Join-Path $env:APPDATA 'baidu\BaiduNetdisk\BaiduNetdisk.exe'
Start-Process -FilePath $exe -WorkingDirectory (Split-Path -Parent $exe)

.\scripts\Test-BaiduNetdiskHealth.ps1 `
  -Samples 6 `
  -IntervalSeconds 5 `
  -MaxMainPrivateMB 600
```

Final observed result:

- six consecutive samples were responsive;
- main private memory stayed essentially flat at `105.7` to `106.1 MB`;
- total private memory stayed near `815` to `822 MB`;
- the process path was the normal `%APPDATA%\baidu\BaiduNetdisk` path;
- Windows recorded zero new Baidu event `1002` hangs.

Check for new hang events:

```powershell
$start = Get-Date
# Reproduce normal use here.

Get-WinEvent -FilterHashtable @{
  LogName  = 'Application'
  StartTime = $start
  Id       = 1002
} -ErrorAction SilentlyContinue |
  Where-Object { $_.Message -match 'BaiduNetdiskUnite' }
```

## Roll Back

The archived old client is outside `%APPDATA%\baidu\BaiduNetdisk` and is not
referenced by any shortcut or normal entry point. To restore it:

```powershell
$active = Join-Path $env:APPDATA 'baidu\BaiduNetdisk'
$old = 'C:\path\to\BaiduNetdisk-8.5.5.103-installed-YYYYMMDD-HHMMSS'
$failed = "$active.failed-$(Get-Date -Format yyyyMMdd-HHmmss)"

Get-Process -ErrorAction SilentlyContinue |
  Where-Object {
    $_.ProcessName -in @(
      'BaiduNetdisk',
      'BaiduNetdiskUnite',
      'baidunetdiskhost',
      'YunDetectService'
    )
  } |
  Stop-Process -Force

Move-Item -LiteralPath $active -Destination $failed
Move-Item -LiteralPath $old -Destination $active
```

Do not delete the 8.5.5 archive until 8.5.8 has survived normal long-running
downloads, playback, tray restore, and a reboot.

## Known Cosmetic Caveat

Apps & Features may continue to display `8.5.5`. That label is stored in a
protected HKLM uninstall key and does not determine which executable runs. Use
the signed file versions at the active path as the authoritative state:

```powershell
(Get-Item "$env:APPDATA\baidu\BaiduNetdisk\BaiduNetdisk.exe").VersionInfo.FileVersion
```

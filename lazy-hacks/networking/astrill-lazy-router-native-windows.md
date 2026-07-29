# Astrill Lazy Router Native Windows Setup

This note records the safe build, installation, and first-run flow for the
native Windows frontend in
[`lachlanchen/astrill-lazy-router`](https://github.com/lachlanchen/astrill-lazy-router).
It intentionally excludes passwords, private/public key bodies, and
machine-specific SSH fingerprints.

## Current Version And Paths

The source snapshot documented here reports application version `0.2.3` and
router companion version `0.2.3`.

| Artifact | Default path |
| --- | --- |
| Workstation checkout | `%USERPROFILE%\Projects\astrill-lazy-router` |
| Build virtual environment | `build\windows-venv` |
| PyInstaller work directory | `build\pyinstaller-windows` |
| Built application folder | `dist\windows\Astrill Lazy Router` |
| Per-user installation | `%LOCALAPPDATA%\Programs\Astrill Lazy Router` |
| Installed executable | `%LOCALAPPDATA%\Programs\Astrill Lazy Router\Astrill Lazy Router.exe` |
| Desktop shortcut | `%USERPROFILE%\Desktop\Astrill Lazy Router.lnk` |
| Login-startup shortcut | `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Astrill Lazy Router.lnk` |
| Configuration | `%LOCALAPPDATA%\Astrill Lazy Router\config.json` |
| App-owned host-key store | `%LOCALAPPDATA%\Astrill Lazy Router\known_hosts` |
| Default dedicated identity | `~/.ssh/astrill_lazy_router_ed25519` |

The PyInstaller result is a folder bundle. Keep the adjacent `_internal`
directory with the executable.

## Native UI

The Windows frontend is a native PySide6/Qt application. It does not need WSL,
GTK, VNC, or noVNC, and it does not install a local VPN, proxy, packet filter,
or network driver. DD-WRT remains the routing enforcement point.

The roomy layout targets `1360 x 860`, has a `960 x 640` minimum, and uses a
fixed navigation sidebar with scrollable content. Its vivid, saturated theme
uses an indigo-to-teal sidebar, purple/cyan accents, white cards, spacious
controls, and distinct status colors. The eight views are Policies, Services,
Countries, Devices, Endpoints, Astrill, Router, and Settings.

Fresh configurations start native-only, read-only, and with no policy applied.

The desktop reads router status once at startup, but it does not run a
recurring 60-second SSH poll. Later reads happen only through **Refresh
router**, a first page-demand load such as Devices, Endpoints, or Astrill, or
the status returned by an explicit router action. Leaving the app open does
not create periodic desktop-to-router SSH traffic. This affects only the
Windows frontend: the optional companion's router-local watchdog remains on
DD-WRT and continues maintaining its installed routing runtime independently.

The **Astrill** view follows the Ubuntu frontend's human-readable layout. Its
controls are grouped into **Routing**, **DNS**, **Connection**, and
**Advanced** sections instead of presenting a raw NVRAM table. Friendly labels
and appropriate switches, selectors, and text fields make common settings
easier to understand, while the exact NVRAM key remains visible as secondary
metadata for troubleshooting and comparison with DD-WRT.

This presentation layer still reads and writes only the same explicitly
allowlisted, validated NVRAM keys. Loading the page preserves the router's
current values, and read-only mode continues to prevent saves; reorganizing the
controls does not broaden the app's router access or invent replacement
defaults.

## Build And Install

Windows 10 or 11, Python 3.11 or newer, network access for the initial
dependency installation, and Windows OpenSSH Client are required to build.
Check OpenSSH first:

```powershell
Get-Command ssh.exe
ssh.exe -V
```

From the repository root:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File .\contrib\windows\build-native.ps1

powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File .\contrib\windows\install-native.ps1
```

The build script creates the virtual environment, installs the Windows
dependencies, creates the windowed PyInstaller bundle, and verifies that the
catalog, router package, and schema are present. The installer stages updates
before replacing the current per-user copy and refuses to update while the
installed app is running.

The router package builder canonicalizes its `VERSION` file to LF, so a Windows
CRLF checkout cannot turn an exact companion version such as `0.2.3` into a
mismatched runtime value.

The native installer creates one Desktop shortcut and one current-user Startup
shortcut. The latter opens the app after Windows sign-in, including after a
reboot, without a service or administrator access. Installation remains
idempotent and does not launch the app immediately. It removes an older
same-named Start Menu shortcut, creates no new Start Menu entry, and does not
alter router state.

Launch from the Desktop shortcut or directly:

```powershell
& "$env:LOCALAPPDATA\Programs\Astrill Lazy Router\Astrill Lazy Router.exe"
```

## First-Run SSH Onboarding

Keep the Windows PC and DD-WRT router on a trusted LAN for this one-time flow.
Telnet is unencrypted; never perform the bootstrap across an untrusted network.

In **Settings**:

1. Enter the router host, SSH user and port, and dedicated identity path.
2. Select **Set up key via Telnet**.
3. Independently compare the displayed SSH algorithm and SHA-256 fingerprint
   with the router's trusted record or local console. **Cancel** is the default.
4. Confirm the warning only when the fingerprint matches, then enter the
   one-time Telnet password.
5. Wait until the app reports that strict key-only SSH was verified.

The app scans the SSH endpoint before asking for a credential. After
confirmation it scans again, refuses a changed key, and atomically pins the
confirmed key in its own `known_hosts` file. It generates or reuses a dedicated
Ed25519 identity and uses the LAN Telnet session to append only the public key
material to DD-WRT's existing authorized keys.

The password exists only transiently in app memory. It is not stored in the
configuration, logs, files, command arguments, or environment variables.

The ordering is an important lockout guard:

1. preserve existing authorized keys and append the dedicated public key
   idempotently;
2. restart SSH and prove strict key-only access with Windows OpenSSH;
3. only after that successful proof, disable SSH password authentication,
   SSH forwarding, and WAN SSH;
4. restart SSH and prove key-only access a second time.

Background commands fail closed with batch mode, identity-only
authentication, strict host-key checking, and the app-owned `known_hosts`
file. The onboarding flow never uses `StrictHostKeyChecking=no` and never
silently accepts a new or changed host key.

On Windows, noninteractive OpenSSH helpers such as `ssh.exe`,
`ssh-keyscan.exe`, and `ssh-keygen.exe` run without creating a console window,
so normal status refreshes and onboarding checks do not flash a terminal. The
explicit **Open interactive SSH setup** action intentionally opens a visible
terminal because that action hands control of the SSH session to the user.

Telnet deliberately remains enabled as a recovery path. This is a security
tradeoff: keep it LAN-only and maintain physical or local-console access.

## Optional Router Companion

SSH onboarding and companion installation are separate decisions. A successful
fingerprint/Telnet confirmation does not install the companion.

Review native Astrill and router status while the read-only guard is still on.
When the optional DD-WRT companion is wanted, open **Router**, select
**Install / upgrade**, read the write summary, and confirm it separately.
Cancel is the default. On a fresh profile that confirmation also turns off the
local read-only guard; a failed installation restores the guard.

The confirmed installation writes the validated companion package, startup
hook, watchdog, routes, and MyPage entries. It does not change Astrill account
credentials or the selected endpoint. Applying routing policies is another
separately confirmed action; merely editing local policies does not change
traffic.

After a router reboot, the companion's router-local startup hook and watchdog
maintain or reconstruct its runtime from the validated package retained in
NVRAM; this does not depend on desktop polling. The Windows app inspects the
result on its next startup read or manual **Refresh router** action; other
pages load only their own data when first needed. If the router retained
neither the persistent markers nor runtime, the desktop falls back to usable
native-only mode and leaves **Install / upgrade** available. An unreachable
router does not trigger that fallback. Missing, stale, or inconsistent
packages are never silently installed or persistently rewritten.

The **Endpoints** page already provides **Connect router to selected endpoint**.
It loads the router's Astrill server catalog, requires the read-only guard to
be off and the companion to be healthy, and asks for a Cancel-default
confirmation. The companion reconnects DD-WRT's one shared tunnel and restores
the previous settings if the new endpoint fails. This action does not install
a VPN or change local routing on the Windows PC.

The page also has a separate manual **Test PC latency** action for the selected
endpoint, currently visible endpoints, or all loaded endpoints. It performs
bounded TCP connection checks from the Windows PC and reports the observed
connection latency. The test never starts automatically: opening the page,
loading or filtering the catalog, changing protocol, and refreshing status do
not launch it.

This PC-side check sends no SSH command to DD-WRT, does not read or write router
configuration, and does not connect or switch the router tunnel. It is not a
VPN throughput or download-speed test; it measures only TCP connection setup
over the PC's current network path, which can differ from the path used by the
router.

## Update Or Remove

Close the app before an update, rebuild, and run `install-native.ps1` again.
To uninstall the application:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File .\contrib\windows\uninstall-native.ps1
```

Uninstall removes the app folder and matching Desktop, Startup, and legacy
Start Menu shortcuts but preserves unrelated shortcuts, configuration, and SSH
keys. Review and remove retained configuration or keys manually only when they
are no longer needed.

The canonical, more detailed reference remains
[docs/WINDOWS_APP.md](https://github.com/lachlanchen/astrill-lazy-router/blob/main/docs/WINDOWS_APP.md)
in the Astrill Lazy Router repository.

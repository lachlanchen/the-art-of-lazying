# LazyRemote: native apps with an independent LazyTunnel core

LazyRemote is the product website at **https://remote.lazying.art**. Its engine
and current native preview application are named **LazyTunnel**. The repository
is [lachlanchen/LazyTunnel](https://github.com/lachlanchen/LazyTunnel).

The design keeps the server, endpoint clients, controller and interfaces
separate. Closing a GUI does not stop an endpoint's SSH carrier. Existing UU,
RDP and VNC services keep their own ownership and desktop sessions.

## What is available

- Native Flutter application source for Ubuntu, macOS, Windows, iOS and Android.
- Release builds for Ubuntu x64, Windows x64, macOS Intel and Android ARM64,
  ARMv7 and x64, with per-user desktop installers.
- iOS simulator and unsigned device builds; physical iPhone/iPad installation
  needs Apple signing and a provisioning profile. This is not an App Store or
  TestFlight release. Consult the verification record for host limitations.
- Native management widgets, optional secure saved profiles, verified SSH
  terminals, and private web/noVNC viewers. Mobile viewers stay inside the app;
  desktop viewers use the normal browser.
- A separate browser console for operators who prefer a web interface.

[Download the preview](https://github.com/lachlanchen/LazyTunnel/releases/tag/v0.2.0)
or read the [complete setup/build/signing guide](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/native-apps.md).

## Independent layers

| Layer | Implementation | Depends on an open GUI? |
| --- | --- | --- |
| Cloud relay | OpenSSH with restricted, separate identities | No |
| Endpoint carrier | Existing Linux/systemd, macOS or Windows client | No |
| Controller agent | Standard-library Python, loopback API | No |
| Native transport | Pure Dart API, SSH, PTY and forwarding library | No Flutter dependency |
| Browser console | Static assets and authenticated agent proxy | Optional |
| Native application | Flutter widgets and platform adapters | Optional |

The controller service currently targets Linux/systemd. Apps on other
platforms connect to it over SSH; this does not restrict the existing
cross-platform endpoint enrollment. The protocol is also usable by a Dart CLI.

The public launch website is **not** a private console. It never contacts an
operator's local agent or asks for a password, key, account or access code.

## Start the agent on an enrolled controller

From a reviewed checkout:

```bash
cd /path/to/LazyTunnel
python3 scripts/lazytunnel-client.py update --source .
lazytunnel agent install
lazytunnel agent status
```

The agent uses `127.0.0.1:17766`. The optional browser adapter uses
`127.0.0.1:17765`:

```bash
lazytunnel gui install
lazytunnel gui
```

An older running browser adapter needs one restart after the independent agent
is installed:

```bash
systemctl --user restart lazytunnel-gui.service
```

That command restarts only the browser adapter. It does not restart SSH, UU,
XRDP, VNC, or another application's viewer. The agent and GUI retain the
existing private access code, so migration does not reset enrollment.

## Install and open the native app

On Ubuntu, extract the complete release archive and run from its directory:

```bash
python3 scripts/install-native-linux.py --bundle bundle
~/.local/bin/lazytunnel-app
```

The installer adds **LazyTunnel Native** to Applications and stores a versioned
bundle under the user's local application data. Repeating the installation
from the same build selects the same release; open windows are not terminated.

On Windows, extract the complete ZIP and run PowerShell in that folder:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\install-native-windows.ps1 -Bundle .\bundle
```

Open **LazyTunnel Native** from Start. The process-local execution-policy flag
allows that reviewed installer; it does not change the system policy. The app
does not require administrator privileges. Keep all DLLs and the data folder,
not just the EXE. The preview is not Authenticode signed.

On macOS, extract the complete ZIP and run from its folder:

```bash
bash scripts/install-native-macos.sh LazyTunnel.app
open "$HOME/Applications/LazyTunnel.app"
```

The Intel preview is ad-hoc signed, not notarized. Verify the release/checksum
and use the app-specific macOS approval if needed; never disable Gatekeeper
globally. An Apple Silicon build can be made from the same source on that host.

On Android, install the APK matching the device architecture; most current
phones use ARM64. The release is signed with a persistent private key so future
updates can retain the same identity. The public checksum and signing
fingerprint are recorded with the release. No signing key belongs in Git.

## Connect from the app

On the controller's Ubuntu desktop, choose **This device**. The app can read
the current user's private local access-code file without printing or exporting
it. If necessary, obtain the code yourself with:

```bash
lazytunnel agent code
```

From another computer or phone, choose **Through SSH** and enter the controller
host, port, username, verified fingerprint, SSH key/password and agent access
code. Verify the endpoint fingerprint on that machine through a trusted route:

```bash
ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub
```

For a controller behind a private network, enable the cloud jump-host fields.
Use its separate restricted jump identity and fingerprint. The inner host and
port normally identify the controller's loopback reverse listener on the
relay. Use values from the private enrollment record, not a cloud admin login.

A phone does not inherit another computer's SSH aliases. Supply the actual
connection values. **Remember in secure storage** is optional: Keychain on
Apple platforms, Keystore-backed storage on Android, Secret Service on Linux,
and the Windows secure storage adapter. There is no plaintext fallback.

## Work without coupling the desktops

The native app's terminal uses SSH and a PTY; it does not take over a UU/RDP/VNC
desktop or modify the workstation's keyboard mapping. Output is UTF-8 and
bounded. Explicit paste and mobile modifier buttons are available. Use `tmux`
inside SSH for work that must survive a client disconnect.

Viewer cards distinguish existing services from app-owned forwards. Removing
a bookmark never stops its original application. A managed viewer forward is
a separate controller-owned service; stopping it does not stop the endpoint
carrier. Remote viewers receive a separate app-local loopback forward.

Closing the native app ends its own interactive SSH/viewer channels. Persistent
carriers, the controller agent and managed forwards remain running. Phones
may suspend networking in the background, so keep the app in the foreground
while using a terminal or viewer. Clipboard behavior also depends on the
actual noVNC page and mobile platform; no universal dictation guarantee is made.

## Validation lessons

The build uses Flutter 3.47.2 and Dart 3.13.2. Python tests, pure-Dart transport
tests and native widget tests passed. Live checks covered the existing fleet,
host-key rejection, SSH PTY commands and a private viewer. Android retained a
saved connection after restarting the app, and its embedded viewer rendered
Chinese and Japanese text. A temporary test bookmark was removed afterwards.

The Windows build needed Visual Studio's ATL component. A later SSH-side probe
reported no main window, but the same probe inside the interactive desktop
confirmed a visible, responsive window. The problem was the probe's window
station, not a graphics failure. A trial renderer override was removed.

Android API 37.0 required AGP 9.1.1; updating that specific patch fixed platform
resolution. The build retains lint and loopback-only cleartext exceptions.

Apple build success is separate from device signing and simulator rendering.
The current Mac's security settings prevented remote screen capture and
command-line signing with its existing identities. Its simulator also reported
a screen-surface timeout during initial review. No keychain ACL, screen privacy
setting or graphics driver was weakened to turn those into a success claim.
See the [detailed verification record](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/native-verification-2026-09-09.md)
for the current result and distribution limits.

The Ubuntu SSH carrier, UU bridge and XRDP process identities remained unchanged
during deployment. No reboot or logout was performed. Enabled startup units are
boot configuration evidence, not a reboot test.

## Website, logo and screenshots

`remote.lazying.art` uses GitHub Pages with the project's `website/` directory
and an automatic deployment workflow. The launch page has responsive layouts,
platform download tabs, an expandable screenshot gallery and a concise
architecture explanation. It needs no JavaScript framework or server process.

The blue portal logo was generated with Codex's built-in image generator and
saved in the project. Its exact prompt and provenance are documented. The
desktop and Android screenshots are actual application captures using a
read-only sample fleet; no real endpoint or credential information is shown.
The site labels the sample data explicitly. The full website was reviewed at
phone, tablet and desktop sizes.

- [Brand and generation prompt](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/lazyremote-brand.md)
- [Website maintenance and screenshot reproduction](https://github.com/lachlanchen/LazyTunnel/blob/main/website/README.md)
- [Existing fleet setup](lazytunnel-fleet-ssh-and-novnc.md)
- [Optional browser console](lazytunnel-optional-gui.md)

Private credentials, signing material, browser profiles, build SDKs and raw
session logs stay outside public repositories. Temporary review desktops and
emulators belong to their test session and are cleaned up after evidence is
captured; they are not part of a production installation.

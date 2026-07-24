# Windows RDP To The Current Ubuntu Desktop

## Result

This setup makes Windows RDP attach to the Ubuntu desktop that is already
visible on the physical monitor. It does not ask GNOME to create a second
login session.

Verified workstation:

| Item | Value |
| --- | --- |
| Ubuntu host | `OptiPlex-7090` |
| Ubuntu address | `192.168.1.227` |
| Ubuntu user | `lachlan` |
| Session | GNOME 46, Wayland, already logged in |
| Physical-desktop RDP port | `3391` |
| UU bridge | active and sharing the same desktop |

Connect from Windows with:

```powershell
mstsc /v:192.168.1.227:3391
```

Authenticate with the GNOME Desktop Sharing credentials. The credentials are
intentionally not recorded in this repository.

## Windows Desktop Shortcut

The verified Windows setup has these files on the Windows user's desktop:

```text
Ubuntu Physical Desktop.lnk
Ubuntu Physical Desktop.rdp
```

The `.rdp` profile contains the important endpoint and control settings:

```text
full address:s:192.168.1.227:3391
username:s:lachlan
screen mode id:i:2
desktopwidth:i:1920
desktopheight:i:1080
session bpp:i:32
smart sizing:i:1
redirectclipboard:i:1
prompt for credentials:i:1
```

Double-click `Ubuntu Physical Desktop.lnk` to open the current Ubuntu desktop.
The first connection may still ask for the RDP credential; this is expected and
is separate from the Windows account password.

## Why 3389 Shows Another Session

GNOME exposes two different RDP behaviors:

| Port | Service | Behavior |
| --- | --- | --- |
| `3389` | system Remote Login | authenticates through GDM and creates a remote/headless session |
| `3390` | ordinary user Desktop Sharing | normally shares an already-running GNOME desktop |
| `3391` | UU bridge Desktop Sharing | shares this workstation's active Wayland desktop and feeds the UU relay |

The UU bridge must run its GNOME Remote Desktop daemon on the same desktop
session bus as the physical Wayland session. On this workstation that daemon
owns `3391`, so it is also the correct direct RDP endpoint. Starting another
user GNOME RDP daemon on `3390` would compete for the same session bus and can
interrupt or replace the working relay.

Do not use `3389` when the goal is to control the desktop already on the
monitor. The “another session” or “Session Already Running” message is the
expected result of using the Remote Login endpoint while the local session is
active.

## Current Service Arrangement

The intended live state is:

```text
uu-remote-bridge.service                 active, enabled
gnome-remote-desktop-daemon --rdp-port 3391  active
gnome-remote-desktop-headless.service    disabled
gnome-remote-desktop.service             disabled while UU owns the session bus
system GNOME Remote Desktop daemon       listening on 3389
```

The system daemon on `3389` may remain listening. That does not change the
meaning of `3391`; clients must specify the physical-desktop port explicitly.

The UU bridge was left running during setup. The final health check showed:

```text
uu-remote-bridge.service: active/running
NRestarts: 0
TCP 3391: listening on all interfaces
```

## Verification

On Ubuntu:

```bash
ss -ltnp | grep ':3391'
systemctl --user show uu-remote-bridge.service \
  -p ActiveState -p SubState -p NRestarts
```

Expected output includes a GNOME Remote Desktop process on `3391`, an active
bridge, and `NRestarts=0`.

From Windows PowerShell:

```powershell
Test-NetConnection 192.168.1.227 -Port 3391 -InformationLevel Quiet
```

The result should be `True`.

## Recovery Rules

Do not stop or restart `uu-remote-bridge.service` while the physical desktop
is being used unless a short UU interruption is acceptable. Do not enable the
headless user service on `3391` or start a second GNOME sharing daemon on the
same session bus.

If the shortcut stops working, check the endpoint before changing services:

```powershell
Test-NetConnection 192.168.1.227 -Port 3391
```

Then check the Ubuntu bridge:

```bash
systemctl --user status uu-remote-bridge.service --no-pager
journalctl --user -u uu-remote-bridge.service -n 80 --no-pager
```

The saved RDP settings snapshot from the transition is kept outside the
repository at:

```text
~/.local/state/rdp-desktop-sharing/
```

Never commit RDP passwords, SSH private keys, keyring exports, or Windows
credential-manager data.

## SSH Companion

The Windows-to-Ubuntu SSH key was installed without changing the Ubuntu
password. The Windows SSH config alias is:

```powershell
ssh ubuntu-7090
```

The alias uses the Windows user's private key at:

```text
%USERPROFILE%\.ssh\id_ed25519_ubuntu_7090
```

The private key must remain only on the Windows account and must never be
committed to this repository.

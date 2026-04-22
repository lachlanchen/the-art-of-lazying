# Native GNOME RDP vs XRDP on Ubuntu 24.04

## Problem

On this workstation, native GNOME RDP worked well enough to connect, but opening some GUI apps remotely could crash the whole desktop session.

The machine stayed alive, but the remote desktop dropped and the graphical session restarted.

That is a different problem from a full kernel freeze.

## What was actually crashing

The app launch was only the trigger.

The thing that really crashed was:

- `gnome-shell`
- inside the GNOME Wayland remote session

Confirmed trigger examples:

- `Typora`
- `BaiduNetDisk`

The important pattern was:

1. app launched
2. `gnome-shell` crashed with `signal 11`
3. many processes reported `Error reading events from display: Broken pipe`
4. the RDP session stopped

So the remote desktop died because the shell session died, not because the whole computer died.

## Why Chrome and Firefox felt safer

They did not prove the native GNOME RDP path was healthy.

They just happened to be less likely to trigger the shell-crash path on this machine.

## Why native GNOME RDP was not kept as the default

Native GNOME RDP has one nice property:

- it can mirror a GNOME desktop more naturally

But on this machine it had two practical problems:

1. some app launches could crash the shell session
2. reconnect behavior was less predictable than desired

That made it a poor default for stable daily use.

## Why XRDP was chosen

XRDP uses a separate remote desktop session through Xorg.

That means:

- it is not the same console desktop
- but it is usually more robust for launching normal desktop apps remotely

For this workstation, that tradeoff was worth it.

## Installed setup

Packages:

```bash
sudo apt update
sudo apt install xrdp xorgxrdp
```

Session launcher:

File:

- [~/.xsession](/home/lachlan/.xsession)

Contents:

```sh
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export DESKTOP_SESSION=ubuntu
unset DBUS_SESSION_BUS_ADDRESS
unset SESSION_MANAGER
exec dbus-run-session -- gnome-session --session=ubuntu
```

XRDP listener:

- [/etc/xrdp/xrdp.ini](/etc/xrdp/xrdp.ini)
  - `port=3389`

## Final service arrangement

Recommended final state:

- `xrdp.service` enabled and active
- `xrdp-sesman.service` enabled and active
- native GNOME RDP disabled

This lets Windows App connect normally on standard RDP port `3389` without any custom port setting.

## XRDP tradeoff: safer but slower

On this workstation, XRDP is more stable than native GNOME RDP for launching apps remotely, but it is also heavier.

Why:

- XRDP runs a separate Xorg/X11 GNOME session
- the session is not getting normal accelerated graphics access
- full GNOME Shell over that path is expensive

The typical warning signs were:

- `systemd-logind: failed to take device /dev/dri/card...`
- `libEGL warning: DRI3 error: Could not get DRI3 device`

So the practical rule is:

- XRDP = safer default
- native GNOME RDP = smoother when it works

If you want XRDP to feel fast, the best next step is usually a lighter desktop than full GNOME.

## XRDP session types

Windows App exposed multiple XRDP session types:

- `Xorg`
- `Xvnc`
- `rdp-any`
- `neutrinordp-any`

On this workstation:

- `Xorg` worked first
- `Xvnc` initially failed because XRDP's `Xvnc` backend was colliding with the installed RealVNC `Xvnc`

The working fix was:

- install TigerVNC
- point XRDP's `[Xvnc]` backend at TigerVNC
- use a localhost-only wrapper for the internal XRDP-to-VNC hop

Files:

- [/etc/xrdp/sesman.ini](/etc/xrdp/sesman.ini)
- [xrdp-xtigervnc-wrapper.sh](/home/lachlan/scripts/xrdp-xtigervnc-wrapper.sh)

After that, `Xvnc` became usable from Windows App.

## XRDP multi-session conflict

Another practical problem showed up once both `Xorg` and `Xvnc` were available:

- an old disconnected XRDP GNOME session could remain alive
- a new XRDP GNOME session could start for the same user
- single-instance apps could then open in the wrong remote desktop

Confirmed example:

- `Chrome` was redirected into the stale old XRDP desktop instead of the current one

Mitigation:

- kill the stale old XRDP session
- add a startup hook that prunes other remote GNOME sessions on displays `:10+`

Files:

- [~/.xsession](/home/lachlan/.xsession)
- [xrdp-prune-other-remote-gnome-sessions.sh](/home/lachlan/scripts/xrdp-prune-other-remote-gnome-sessions.sh)

## Firefox note

The final Firefox issue in XRDP `Xvnc` was not the same as the Chrome session-conflict problem.

Root cause:

- Firefox was the Ubuntu `snap` build
- in the XRDP `Xvnc` session, the snap/portal path was failing or timing out

Working fix:

- switch Firefox from the Ubuntu snap path to Mozilla's normal Linux `deb` package
- migrate the Firefox profile out of the snap path

Current state:

- `/usr/bin/firefox` resolves to `/usr/lib/firefox/firefox`
- installed package: `firefox 149.0.2~build1`

Backup/migration snapshot:

- [firefox_migration_2026-04-15](/home/lachlan/Documents/SystemTutorial/system_health/env_snapshots/firefox_migration_2026-04-15)

After that, Firefox launched successfully inside the current XRDP `Xvnc` desktop.

If Firefox feels "newer" now, that is expected:

- it is no longer the Ubuntu snap packaging path
- it is now Mozilla's direct Linux `deb` package

## Windows App behavior

You can connect the normal way:

- use the host name or IP
- no special port override needed if `xrdp` owns `3389`

Important behavior difference:

- **XRDP** gives a **separate remote GNOME session**
- it does **not** mirror the exact currently logged-in console desktop

## When to prefer native GNOME RDP anyway

Only prefer native GNOME RDP if you specifically need:

- GNOME's own remote-desktop mode
- a closer desktop-sharing workflow

But for this workstation, that should be treated as the more fragile option.

## Practical recommendation

For stable remote daily use on Ubuntu 24.04:

- use **XRDP** as the default
- keep native GNOME RDP off unless it is specifically needed
- avoid mixing RealVNC, native GNOME RDP, and XRDP at the same time while debugging stability
- avoid leaving old disconnected `Xorg` and `Xvnc` XRDP desktops alive together
- prefer the Mozilla `deb` Firefox package over the Ubuntu snap build for XRDP `Xvnc`

## Bottom line

If remote app launches are crashing the desktop session, `xrdp` is often the cleaner fix than trying to force GNOME native RDP to behave like a fully robust workstation remote stack.

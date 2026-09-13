# 3040 Remmina: Share the Existing Mac Desktop

Verified on 2026-09-13: Ubuntu OptiPlex 7090, Remmina, and the OptiPlex 3040
running macOS Monterey 12.7.6. The working 7050 configuration was left unchanged.

## Symptoms and Cause

The Mac already had an active `lachlan` Aqua session, but a password-authenticated
VNC connection created an additional root login-window session. The client could
show a blank or login screen instead of the desktop already used by UU Remote.
Successful VNC authentication alone was therefore not an adequate health check.

Two local launchers also referenced an obsolete `.remmina` filename. Remmina had
renamed the real profile, and an old Ubuntu RDP profile was ambiguously named
`OptiPlex 3040 - Desktop`. That RDP profile is for another operating system, not
the Mac's physical desktop.

## Minimal Mac Repair

Connect through the existing key-authenticated SSH alias:

```bash
ssh optiplex-3040-macos
sudo defaults write /Library/Preferences/com.apple.RemoteManagement \
  VNCAlwaysStartOnConsole -bool true
defaults read /Library/Preferences/com.apple.RemoteManagement VNCAlwaysStartOnConsole
```

The expected result is `1`. This preference was also found in Monterey's own
`screensharingd` binary. It took effect on the next connection without a reboot,
service restart, logout, or termination of WindowServer or loginwindow.

The change is persistent. Do not rerun the entire post-install script merely to
set this one preference: that script performs other administration and restarts
the sharing service. Its future-install path now includes the preference.

Authentication remains enabled. This shares the console; it does not disable
the Mac's lock screen or bypass a deliberately locked console. Apple's
[VNC administration guide](https://support.apple.com/guide/remote-desktop/virtual-network-computing-access-and-control-apde0dd523e/mac)
explains the separate VNC password and the limitations of third-party clients.

## Ubuntu Connection

Use `Connect to OptiPlex 3040` on the desktop, or select
`OptiPlex 3040 macOS - Current Desktop` in Remmina. The desktop shortcut now opens
VNC directly. Its right-click actions retain SSH and connection options.

Relevant saved profile settings:

```ini
protocol=VNC
server=OptiPlex-3040-macOS.local:5900
username=
disableencryption=1
disablepasswordstoring=0
viewonly=0
disableserverinput=0
disableclipboard=0
scale=1
resolution_mode=2
viewmode=1
window_maximize=1
```

The VNC password remains in GNOME Keyring; `password=.` in the current profile
is a keyring marker, not a literal password. Keep that file's path unchanged
when retaining its keyring entry. No credentials belong in this repository.

`disableencryption=1` restricts Remmina to compatible authentication methods;
it does **not** make this transport encrypted. Use it only on the trusted LAN,
or add an SSH tunnel on untrusted networks. Never expose port 5900 publicly.

The [connector](../hackintosh/scripts/connect-to-optiplex-3040-macos.sh) resolves
the profile by VNC protocol and destination rather than a mutable filename.
It rejects ambiguous duplicate profiles instead of guessing. `.local` discovery
avoids binding the shortcut to a router's old DHCP address; both computers must
be on a LAN where mDNS works.

```bash
~/.local/share/host-connectors/connect-to-3040 --test
~/.local/share/host-connectors/connect-to-3040 --profile
~/.local/share/host-connectors/connect-to-3040 --vnc
~/.local/share/host-connectors/connect-to-3040 --ssh
```

The old Ubuntu profile was retained but relabeled
`OptiPlex 3040 Ubuntu - Separate Login (RDP)`.
The [fresh-install helper](../hackintosh/scripts/install-optiplex-3040-vnc-launcher-ubuntu.sh)
now uses the hostname and installs the connector. It reuses an existing renamed
Mac profile, rather than adding a duplicate. The helper requests a VNC password;
it is unnecessary for this already-repaired workstation.

## Verification and Rollback

- The saved keyring credential passed an actual RFB VNCAuth challenge.
- A shared framebuffer connection captured the live 1920x1080 Monterey desktop,
  including the existing UU Remote and Disk Utility windows.
- Remmina established its own connection to the Mac on TCP 5900.
- `ioreg -l -n Root -d 1 | grep IOConsoleUsers` continued to show the original
  `lachlan` console session (ID 257) and no extra root login session.
- Original WindowServer PID 146 and user loginwindow PID 172 remained running.
- Connector tests covered missing profiles, renamed paths with spaces, exclusion
  of RDP profiles, and rejection of duplicate Mac profiles.
- Isolated installer checks passed for fresh and renamed existing profiles,
  including repeated installation, one-profile preservation, file permissions,
  and desktop-entry validation. The test used a mock encryption command, not
  real credentials or the live Remmina configuration.
- A reboot was not performed. Persistence is from the saved system preference,
  not from a watchdog or an in-memory adjustment.

Local backups: `~/.local/state/desktop-alias-fix-20260913/` on Ubuntu, and
`/var/root/RemoteManagement-before-console-20260913.plist` on the Mac.

The preference was absent before this repair. To undo just this change:

```bash
sudo defaults delete /Library/Preferences/com.apple.RemoteManagement VNCAlwaysStartOnConsole
```

Then reconnect the viewer. Avoid restoring the whole preferences file over
unrelated settings changed since the backup.

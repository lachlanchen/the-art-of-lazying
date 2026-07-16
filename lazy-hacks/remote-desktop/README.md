# Remote Desktop Hacks

Practical notes for keeping Ubuntu remote access usable when GNOME native RDP, RealVNC, and app launches interact badly.

## Files

- [windows-rdp-bootstrap-to-ssh-and-uu-remote.md](./windows-rdp-bootstrap-to-ssh-and-uu-remote.md)
  - how Remmina RDP was used as the one-time Windows bootstrap path
  - how to install OpenSSH Server, add an administrator public key, and keep TCP 22 LAN-scoped
  - companion helper: [scripts/enable-windows-openssh.ps1](./scripts/enable-windows-openssh.ps1)
  - the verified Ubuntu SSH alias and Windows service/firewall/ACL checks
  - how to install and verify native NetEase UU Remote on Windows
  - how to launch the UU GUI in the active RDP session when the command originates over SSH

- [native-gnome-rdp-vs-xrdp-on-ubuntu-24-04.md](./native-gnome-rdp-vs-xrdp-on-ubuntu-24-04.md)
  - why GNOME native RDP could crash the remote desktop session on app launch
  - why `xrdp` was chosen as the safer default
  - the exact `xrdp` setup used on this workstation
  - why `xrdp` is safer but laggier than native GNOME RDP here
  - how the `Xvnc` backend was fixed by moving XRDP to TigerVNC
  - why stale old `Xorg` and new `Xvnc` sessions can fight over single-instance apps
  - why Firefox feels different now after moving from the Ubuntu snap to Mozilla's `deb` package

- [gnome-system-rdp-remote-login-on-ubuntu-24-04.md](./gnome-system-rdp-remote-login-on-ubuntu-24-04.md)
  - why GNOME user desktop sharing can fail when no desktop session is active or the keyring is locked
  - how to configure GNOME's system Remote Login RDP backend with `grdctl --system`
  - how to verify the `3389` listener before connecting from Windows App / Microsoft Remote Desktop

- [xrdp-cjk-input-on-ubuntu-24-04.md](./xrdp-cjk-input-on-ubuntu-24-04.md)
  - why Chinese and Japanese input can work in terminal/Sublime but fail in Chrome, Firefox, and Typora over `xrdp`
  - how to use `ibus-mozc`, `libpinyin`, and `Wubi` together
  - how to make `ibus-daemon` come up reliably in XRDP sessions with `~/.xsessionrc`

- [japanese-mac-keyboard-through-windows-xrdp-on-ubuntu-24-04.md](./japanese-mac-keyboard-through-windows-xrdp-on-ubuntu-24-04.md)
  - how to keep Windows usable for Japanese input first
  - how to make Ubuntu XRDP use layout `jp` with `applealu_jis` and variant `mac` kept as separate settings
  - why putting the literal value `jp(mac)` in XRDP's layout map moved Kana onto the primary letter/number layer
  - why TigerVNC `RawKeyboard=1` was tested but did not repair the macOS RDP modifier path
  - how direct XRDP Xorg plus Windows App Unicode mode restored printable symbols in the double-remote Mac route
  - how physical JIS geometry, Unicode/Scancode transport, and Japanese IME/Kana input differ
  - why a corrected XRDP `jp` map can still type US-like characters when Unicode mode forwards the Mac relay's `ABC` source
  - a native Swift helper for listing and selecting macOS ABC, Romaji, and Kana input sources
  - why the Mac and Windows client routes require separate XRDP compatibility mappings
  - how valid saved credentials preserve the old one-password direct-login workflow
  - why this should be an XRDP-only override instead of a whole-machine keyboard change

- [click-to-open-private-vnc-for-an-xrdp-desktop.md](./click-to-open-private-vnc-for-an-xrdp-desktop.md)
  - why Windows App Unicode mode fixed printable symbols but lost `Ctrl`, while Scancode still lost held `Shift`
  - how to attach localhost-only `x11vnc` to the existing XRDP/Xorg desktop
  - how a Mac launcher creates an SSH tunnel and opens RealVNC Viewer with one click
  - how the helper enforces a true `1620x1080` framebuffer and restores the Japanese Mac XKB map
  - why the resize credential belongs in GNOME Keyring instead of a script
  - how to start, stop, verify, and recover the bridge without rebooting or exposing a VNC port

- [xrdp-caps-lock-all-uppercase-fix-on-ubuntu-24-04.md](./xrdp-caps-lock-all-uppercase-fix-on-ubuntu-24-04.md)
  - why Ubuntu can show Caps Lock off while XRDP still types uppercase
  - how to diagnose Caps Lock, Shift, and XRDP keymap state separately
  - how to patch XRDP keymaps so client-side Caps Lock is ignored while normal `Shift` still works

## Scope

- Ubuntu 24.04
- GNOME 46
- Windows App / Microsoft Remote Desktop
- Remmina RDP as a Windows bootstrap client
- Windows OpenSSH and NetEase UU Remote recovery access
- RealVNC, native GNOME RDP, and XRDP comparison

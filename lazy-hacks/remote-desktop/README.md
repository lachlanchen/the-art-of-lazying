# Remote Desktop Hacks

Practical notes for keeping Ubuntu remote access usable when GNOME native RDP, RealVNC, and app launches interact badly.

## Files

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
  - how to make Ubuntu XRDP use `applealu_jis` + `jp(mac)` instead of plain `pc105/us`
  - how `RawKeyboard=1` prevents XRDP `Xvnc` from translating JIS modifier keys twice
  - why this should be an XRDP-only override instead of a whole-machine keyboard change

- [xrdp-caps-lock-all-uppercase-fix-on-ubuntu-24-04.md](./xrdp-caps-lock-all-uppercase-fix-on-ubuntu-24-04.md)
  - why Ubuntu can show Caps Lock off while XRDP still types uppercase
  - how to diagnose Caps Lock, Shift, and XRDP keymap state separately
  - how to patch XRDP keymaps so client-side Caps Lock is ignored while normal `Shift` still works

## Scope

- Ubuntu 24.04
- GNOME 46
- Windows App / Microsoft Remote Desktop
- RealVNC, native GNOME RDP, and XRDP comparison

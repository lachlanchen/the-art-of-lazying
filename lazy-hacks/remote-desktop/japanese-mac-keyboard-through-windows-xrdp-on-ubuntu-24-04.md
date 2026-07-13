# Japanese Mac Keyboard Through Windows XRDP on Ubuntu 24.04

## Problem

The real path here is not just "keyboard -> Ubuntu".

It is:

- Japanese Mac keyboard
- remote-control app into Windows
- Windows App / RDP into Ubuntu
- `xrdp` on Ubuntu

Windows was already made usable for Japanese typing, but the Ubuntu XRDP desktop still behaved like plain `us` / `pc105`.

## Windows side

Windows does not expose a true "physical keyboard type = Japanese Mac keyboard" setting like macOS.

The practical setup is:

- add Japanese in Windows language settings
- use the Japanese keyboard / Microsoft IME
- remove or deprioritize `US` if Windows keeps switching back
- use Advanced keyboard settings if the wrong input method keeps coming back

Useful Windows helper commands:

```powershell
Start-Process 'ms-settings:regionlanguage'
Start-Process 'control.exe' -ArgumentList '/name Microsoft.Language /page pageAdvanced'
```

Meaning:

- make Windows itself type correctly first
- then make Ubuntu XRDP interpret that Japanese layout correctly

## Ubuntu side

### What XRDP already knew

`/etc/xrdp/xrdp_keyboard.ini` already maps Japanese RDP layout ids like `0x00000411` to `jp`.

That means the remaining mismatch is not "XRDP cannot see Japanese".

The mismatch is that the XRDP X11 session still needs the right Apple keyboard model and Japanese Mac variant.

### Closest local XKB profile

On Ubuntu 24.04, the closest built-in Apple/Japanese profile is:

```text
model:   applealu_jis
layout:  jp
variant: mac
```

### When the RDP client reports the wrong layout ID

`setxkbmap -query` can show the correct `jp(mac)` profile while punctuation
still behaves like US. A decisive example is:

```text
Shift+7 -> &     # US behavior
Shift+7 -> '     # Japanese JIS behavior
```

In the Mac -> UU Remote -> Windows -> XRDP chain, the XRDP log showed:

```text
keyboard_type:[0x07]
keyboard_subtype:[0x00]
keylayout:[0x00000804]
layout [us]
Loading keymap file /etc/xrdp/km-00000409.ini
```

Windows was reporting `0x00000804` (Simplified Chinese), not Japanese
`0x00000411`. Because XRDP had no local map for that ID, it fell back to the
US `0x00000409` keymap before GNOME's XKB setting could help.

The server-side compatibility fix is:

- generate `/etc/xrdp/km-00000804.ini` while the live X session is using
  `applealu_jis`, `jp`, `mac`
- map `0x00000804` to `jp(mac)` in `/etc/xrdp/xrdp_keyboard.ini`
- match the observed type `7`, subtype `0` to model `applealu_jis` and variant
  `mac`

Generate the compatibility keymap:

```bash
DISPLAY=:10.0 XAUTHORITY="$HOME/.Xauthority" \
  xrdp-genkeymap /tmp/km-00000804.ini

sudo install -o root -g root -m 0644 \
  /tmp/km-00000804.ini /etc/xrdp/km-00000804.ini
```

The generated map should contain this shifted key entry:

```ini
[shift]
Key16=39:39
```

Keysym `39` is the apostrophe expected from `Shift+7` on JIS. This keymap is
loaded by a new RDP connection; changing it does not require rebooting Ubuntu.

### Keep it XRDP-only

Do not switch the whole machine globally unless you really want every console and every desktop path changed.

For this workstation the safer choice is:

- leave system defaults alone
- override only XRDP sessions

### Persistent two-stage XRDP hook

The first implementation applied the layout only from `~/.xsessionrc`. That
command succeeded, but a later XRDP/GNOME startup step could replace it with:

```text
model:  pc105+inet
layout: us,us
```

The robust setup applies the same idempotent helper twice:

- [~/.xsessionrc](/home/lachlan/.xsessionrc)
- [~/scripts/set-xrdp-japanese-mac-keyboard.sh](/home/lachlan/scripts/set-xrdp-japanese-mac-keyboard.sh)
- [~/.config/autostart/xrdp-japanese-mac-keyboard.desktop](/home/lachlan/.config/autostart/xrdp-japanese-mac-keyboard.desktop)

`~/.xsessionrc` applies it early:

```sh
if [ "${XRDP_SESSION:-}" = "1" ] && [ -x "$HOME/scripts/set-xrdp-japanese-mac-keyboard.sh" ]; then
  "$HOME/scripts/set-xrdp-japanese-mac-keyboard.sh" >/tmp/xrdp-setxkbmap.log 2>&1 || true
fi
```

The GNOME autostart entry applies it once more after five seconds, after the
desktop's own keyboard initialization has finished:

```sh
Exec=sh -c "sleep 5; exec /home/lachlan/scripts/set-xrdp-japanese-mac-keyboard.sh"
```

The helper verifies that the current display belongs to an `xrdp-sesman`
session before changing anything, then runs:

```bash
setxkbmap -model applealu_jis -layout jp -variant mac -option caps:none
```

This remains XRDP-only, preserves the earlier CJK `ibus` setup, and adds no
new monitoring loop.

## Live check

To verify inside the XRDP desktop:

```bash
setxkbmap -query
```

Expected:

```text
rules:      evdev
model:      applealu_jis
layout:     jp
variant:    mac
```

## Apply immediately

For the current XRDP session:

```bash
DISPLAY=:10.0 XAUTHORITY="$HOME/.Xauthority" \
  setxkbmap -model applealu_jis -layout jp -variant mac -option caps:none
```

No reboot is required.

Future XRDP desktop logins apply it automatically; no reboot or XRDP service
restart is required.

## Caveat

This fixes the Ubuntu side correctly.

If exact `Kana` / `Eisu` behavior is still imperfect, the limitation is probably higher in the chain:

- Mac keyboard forwarding
- remote-control app
- Windows App / RDP

At that point the next step is a targeted remap for the specific keys that still arrive incorrectly.

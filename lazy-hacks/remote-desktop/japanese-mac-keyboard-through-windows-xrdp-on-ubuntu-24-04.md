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

### Keep it XRDP-only

Do not switch the whole machine globally unless you really want every console and every desktop path changed.

For this workstation the safer choice is:

- leave system defaults alone
- override only XRDP sessions

### Working XRDP session hook

File:

- [~/.xsessionrc](/home/lachlan/.xsessionrc)

Relevant contents:

```sh
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export CLUTTER_IM_MODULE=ibus

if command -v ibus-daemon >/dev/null 2>&1; then
  if ! pgrep -u "$(id -u)" -x ibus-daemon >/dev/null 2>&1; then
    ibus-daemon -drx >/tmp/ibus-xrdp.log 2>&1 &
  fi
fi

if [ "${XRDP_SESSION:-}" = "1" ] && command -v setxkbmap >/dev/null 2>&1; then
  setxkbmap -model applealu_jis -layout jp -variant mac >/tmp/xrdp-setxkbmap.log 2>&1
fi
```

This preserves the older XRDP CJK `ibus` fix and adds the XRDP-only Apple JIS keyboard override.

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
  setxkbmap -model applealu_jis -layout jp -variant mac
```

No reboot is required.

For persistence testing, log out of the XRDP desktop and reconnect once.

## Caveat

This fixes the Ubuntu side correctly.

If exact `Kana` / `Eisu` behavior is still imperfect, the limitation is probably higher in the chain:

- Mac keyboard forwarding
- remote-control app
- Windows App / RDP

At that point the next step is a targeted remap for the specific keys that still arrive incorrectly.

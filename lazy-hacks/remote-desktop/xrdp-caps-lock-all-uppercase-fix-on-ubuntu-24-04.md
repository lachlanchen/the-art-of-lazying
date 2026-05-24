# XRDP All-Caps Typing Fix on Ubuntu 24.04

## Problem

In an XRDP `Xvnc` session, every typed letter can arrive as uppercase even when
Ubuntu itself reports that Caps Lock is off.

This can happen in a chained remote setup:

- Japanese Mac keyboard
- remote-control app into Windows
- Windows App / Microsoft Remote Desktop
- Ubuntu `xrdp`
- `Xvnc` / GNOME session

The symptom is confusing because the live Ubuntu X session may look clean:

```bash
DISPLAY=:10.0 XAUTHORITY="$HOME/.Xauthority" xset q
DISPLAY=:10.0 XAUTHORITY="$HOME/.Xauthority" xmodmap -pm
```

Expected clean state:

```text
Caps Lock: off
lock
```

`lock` being empty means the local X session is not using Caps Lock as a lock
modifier.

## Root Cause

The broken layer was earlier than GNOME/XKB.

XRDP logged that the client was sending a Japanese keyboard layout:

```text
keyboard_type:[0x07], keyboard_subtype:[0x02], keylayout:[0x00000411]
Loading keymap file /etc/xrdp/km-00000411.ini
```

The local X session had Caps Lock off, but XRDP was still using the
`[capslock]` table in its keymap file. That table maps letter keys to uppercase
before the events reach the desktop.

So this was not only:

- GNOME Sticky Keys
- a stuck X11 Shift modifier
- an IBus problem
- a browser problem

It was XRDP input translation using the client-side Caps Lock state.

## Quick Live Checks

Check the current XRDP display:

```bash
ps -eo pid,user,comm,args | rg -i 'Xtigervnc|xrdp|gnome-session'
```

Check Caps Lock and modifier state:

```bash
DISPLAY=:10.0 XAUTHORITY="$HOME/.Xauthority" \
  xset q | sed -n '/XKB indicators:/,/auto repeat delay/p'

DISPLAY=:10.0 XAUTHORITY="$HOME/.Xauthority" \
  xmodmap -pm
```

Check whether Shift is stuck:

```bash
DISPLAY=:10.0 XAUTHORITY="$HOME/.Xauthority" python3 - <<'PY'
from Xlib import X, display

d = display.Display()
mask = d.screen().root.query_pointer().mask
print("mask:", mask)
print("shift:", bool(mask & X.ShiftMask))
print("lock:", bool(mask & X.LockMask))
PY
```

For the failure fixed here, Caps and Shift can both be clean while XRDP still
types uppercase.

## Session-Layer Mitigation

This can help if the X session itself has Caps Lock latched:

```bash
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:none']"
```

For the current display:

```bash
DISPLAY=:10.0 XAUTHORITY="$HOME/.Xauthority" setxkbmap -option
DISPLAY=:10.0 XAUTHORITY="$HOME/.Xauthority" setxkbmap -option caps:none
```

This disables Caps Lock as an X lock modifier, while keeping normal `Shift`
uppercase working.

However, this alone is not enough if XRDP is already translating the client
Caps Lock state through its own keymap.

## Durable XRDP Keymap Fix

Patch XRDP's keymap so client-side Caps Lock does not uppercase letters.

On this workstation the active client layout was Japanese:

```text
/etc/xrdp/km-00000411.ini
```

US layout was patched too as a fallback:

```text
/etc/xrdp/km-00000409.ini
```

The idea:

- `[capslock]` should behave like `[noshift]`
- `[shiftcapslock]` should behave like `[shift]`
- `[capslockaltgr]` should behave like `[altgr]`
- `[shiftcapslockaltgr]` should behave like `[shiftaltgr]`

Example patch script:

```bash
sudo python3 - <<'PY'
from pathlib import Path
from datetime import datetime

files = [
    Path("/etc/xrdp/km-00000411.ini"),
    Path("/etc/xrdp/km-00000409.ini"),
]

replacements = {
    "capslock": "noshift",
    "shiftcapslock": "shift",
    "capslockaltgr": "altgr",
    "shiftcapslockaltgr": "shiftaltgr",
}

def parse_sections(text):
    sections = []
    current_name = None
    current_lines = []
    prefix = []

    for line in text.splitlines(keepends=True):
        stripped = line.strip()
        if stripped.startswith("[") and stripped.endswith("]"):
            if current_name is None:
                prefix = current_lines
            else:
                sections.append((current_name, current_lines))
            current_name = stripped[1:-1]
            current_lines = [line]
        else:
            current_lines.append(line)

    if current_name is None:
        return prefix, []

    sections.append((current_name, current_lines))
    return prefix, sections

for path in files:
    text = path.read_text()
    prefix, sections = parse_sections(text)
    by_name = {name: lines for name, lines in sections}
    changed = False
    new_sections = []

    for name, lines in sections:
        source = replacements.get(name)
        if source and source in by_name:
            source_body = by_name[source][1:]
            new_lines = [f"[{name}]\n"] + source_body
            changed = changed or new_lines != lines
            new_sections.append((name, new_lines))
        else:
            new_sections.append((name, lines))

    if changed:
        backup = path.with_name(
            path.name + ".bak.ignore-capslock-" + datetime.now().strftime("%Y%m%d-%H%M%S")
        )
        backup.write_text(text)
        path.write_text("".join(prefix + [line for _, lines in new_sections for line in lines]))
        print(f"patched {path} backup={backup}")
    else:
        print(f"no change needed {path}")
PY
```

Then restart XRDP so new RDP connections load the patched keymap:

```bash
sudo systemctl restart xrdp
```

Disconnect and reconnect the RDP client once.

## Verification

Verify the keymap sections now match:

```bash
python3 - <<'PY'
from pathlib import Path

pairs = {
    "capslock": "noshift",
    "shiftcapslock": "shift",
    "capslockaltgr": "altgr",
    "shiftcapslockaltgr": "shiftaltgr",
}

for path in [Path("/etc/xrdp/km-00000411.ini"), Path("/etc/xrdp/km-00000409.ini")]:
    sections = {}
    name = None
    lines = []

    for line in path.read_text().splitlines():
        if line.startswith("[") and line.endswith("]"):
            if name is not None:
                sections[name] = lines
            name = line[1:-1]
            lines = []
        else:
            lines.append(line)

    if name is not None:
        sections[name] = lines

    print(path)
    for left, right in pairs.items():
        if left in sections and right in sections:
            print(f"  {left} == {right}:", sections[left] == sections[right])
PY
```

Expected for Japanese layout:

```text
/etc/xrdp/km-00000411.ini
  capslock == noshift: True
  shiftcapslock == shift: True
  capslockaltgr == altgr: True
  shiftcapslockaltgr == shiftaltgr: True
```

Expected for US layout:

```text
/etc/xrdp/km-00000409.ini
  capslock == noshift: True
  shiftcapslock == shift: True
```

Also confirm services:

```bash
systemctl is-active xrdp xrdp-sesman
```

## Revert

Restore the timestamped backups created by the patch:

```bash
sudo cp /etc/xrdp/km-00000411.ini.bak.ignore-capslock-YYYYMMDD-HHMMSS /etc/xrdp/km-00000411.ini
sudo cp /etc/xrdp/km-00000409.ini.bak.ignore-capslock-YYYYMMDD-HHMMSS /etc/xrdp/km-00000409.ini
sudo systemctl restart xrdp
```

Reconnect RDP after restarting `xrdp`.

## Notes

This intentionally makes XRDP ignore Caps Lock for the patched layouts. That is
acceptable for this workstation because the remote chain sometimes sends a bad
Caps state, and normal uppercase through `Shift` remains available.

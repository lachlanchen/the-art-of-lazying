# XRDP Chinese and Japanese Input on Ubuntu 24.04

## Problem

On Ubuntu 24.04 over `xrdp`, CJK input can work in terminal-like apps but fail in browsers and Electron apps.

Typical examples:

- works in terminal
- works in Sublime Text
- fails or behaves inconsistently in:
  - Chrome
  - Firefox
  - Typora

This is especially likely when the remote path is layered, for example:

- remote into Windows first
- then use Windows App / RDP into Ubuntu

## What to check first

Inside the remote Ubuntu session, check whether the session already has the normal IBus env vars:

```bash
locale | rg '^(LANG|XMODIFIERS|GTK_IM_MODULE|QT_IM_MODULE)='
```

Expected useful values:

```text
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
```

If those are already present, the remaining failure may be simpler:

- the needed Japanese/Chinese engines are missing
- or the user `ibus-daemon` is not actually running in that XRDP session

## Working fix

### Install Japanese IBus support

```bash
sudo apt update
sudo apt install ibus-mozc
```

### Keep Chinese input sources

Useful Chinese engines:

- `libpinyin`
- `table:wubi-jidian86`

On this machine, `Wubi` was already available from `ibus-table-wubi`.

### Add the GNOME input sources

Set GNOME input sources to:

```text
[('xkb', 'us'), ('ibus', 'libpinyin'), ('ibus', 'table:wubi-jidian86'), ('ibus', 'mozc-jp')]
```

and preload engines to:

```text
['xkb:us::eng', 'libpinyin', 'table:wubi-jidian86', 'mozc-jp']
```

The engine names used here are:

- English: `xkb:us::eng`
- Chinese Pinyin: `libpinyin`
- Chinese Wubi: `table:wubi-jidian86`
- Japanese Mozc: `mozc-jp`

You can verify the Mozc engine id with:

```bash
/usr/lib/ibus-mozc/ibus-engine-mozc --xml
```

### Ensure XRDP sessions actually start `ibus-daemon`

Create:

- [~/.xsessionrc](/home/lachlan/.xsessionrc)

with:

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

That makes the fix survive future XRDP logins.

Later, the same XRDP startup file was also used to force the Apple JIS keyboard profile for the Japanese Mac keyboard chain. See:

- [japanese-mac-keyboard-through-windows-xrdp-on-ubuntu-24-04.md](./japanese-mac-keyboard-through-windows-xrdp-on-ubuntu-24-04.md)

## Why this works

The issue is often not that XRDP failed to export `GTK_IM_MODULE` or `XMODIFIERS`.

The deeper problem is usually one of these:

- no Japanese engine installed
- no Wubi/Pinyin engine configured in GNOME
- no user `ibus-daemon` running in the actual XRDP desktop

Terminal-like apps can sometimes still accept already-committed characters, while browser and Electron text fields are less forgiving.

## After applying the fix

For already-open apps:

- close and reopen Chrome / Firefox / Typora

If they were started before `ibus-daemon` came up, log out of the XRDP desktop and reconnect once.

## Switching input methods

Typical GNOME switch shortcut:

- `Super+Space`

If the RDP client intercepts that shortcut, use the GNOME top-bar input menu instead.

## Bottom line

For XRDP CJK input, do not depend only on the client-side IME path.

Make Ubuntu provide a real local IBus stack inside the XRDP session:

- `libpinyin`
- `Wubi`
- `mozc-jp`
- `ibus-daemon` auto-start

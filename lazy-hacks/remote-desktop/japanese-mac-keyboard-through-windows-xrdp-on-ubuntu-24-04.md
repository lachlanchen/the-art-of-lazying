# Japanese Mac Keyboard Through Windows XRDP on Ubuntu 24.04

## Verified state on 2026-07-15

The working route was a 2019 MacBook Air with a Japanese/JIS keyboard,
remote-controlled into a Mac relay, followed by Windows App for macOS into an
Ubuntu XRDP desktop. The verified client and server state was:

```text
Windows App for macOS: 11.3.7
XRDP backend:           Xorg / libxup.so
RDP keyboard type:      4
RDP keyboard subtype:   0
RDP layout id:          0x00000000
Windows App mode:       Unicode (1)
XRDP layout map:        jp
XRDP-only XKB target:   applealu_jis + jp + variant mac
```

This restored ordinary English and printable symbols after Scancode mode lost
the held `Shift` modifier. It is a safe working fallback. Exact JIS punctuation
and the dedicated `Kana` / `Eisu` keys must still be tested separately because
those are different from merely being able to type a shifted symbol.

An important correction to an earlier version of this guide: do **not** put
`jp(mac)` in `default_layouts_map` while also setting `variant=mac`. On this
machine that was parsed as a literal layout name, and a fresh connection
produced:

```text
rules:   base
model:   pc104
layout:  jp(mac)
```

The primary key layer then contained Kana symbols, so English letters and
numbers appeared Japanese. The correct split is:

```ini
[default_layouts_map]
rdp_layout_jp_via_mac_unspecified=jp
rdp_layout_jp_via_zh_cn=jp

[rdp_keyboard_jp_mac_via_mac_rdp]
model=applealu_jis
variant=mac
```

After correcting the map, a new XRDP connection logged `layout [jp]`, and the
unwanted Kana-primary behavior disappeared.

The fresh display then reported `model pc104`, `layout jp` when queried, while
its effective key table contained the expected JIS shifted pairs:

```text
keycode 11 -> 2 / quotedbl
keycode 16 -> 7 / apostrophe
keycode 34 -> at / grave
keycode 61 -> slash / question
```

This is why the XRDP log, XKB query, effective key table, and real typed output
must all be checked. XRDP can translate through `km-*.ini` even when the model
shown by `setxkbmap -query` is less specific than the desired helper target.

## Three different things that should not be mixed together

1. **Physical key geometry**: a Japanese Apple/JIS keyboard has different
   punctuation positions from a US ANSI keyboard.
2. **Printable-character transport**: Windows App can send physical Scancodes
   or completed Unicode characters.
3. **Japanese text input**: macOS Japanese input or Ubuntu `ibus-mozc` converts
   Roman/Kana input into Japanese text.

The Mac relay can legitimately show the `ABC` input source while a physical
Japanese keyboard is connected. That does not automatically mean the hardware
is US. In Unicode mode, Windows App forwards the character produced by macOS;
in Scancode mode, Ubuntu must interpret the physical key and modifier sequence.

### Switching between English/JIS symbols and Japanese text

Do not make Kana the primary XKB layer. That was the broken state in which
ordinary letters and numbers became Kana.

For the Mac-to-Mac-to-XRDP route:

- keep macOS `ABC` selected for English text
- select macOS Japanese/Romaji or Japanese/Kana only when Japanese text is
  wanted
- keep Windows App in Unicode mode so it forwards the composed printable text

The tested Mac relay had both `ABC` and Apple's Japanese input method enabled,
with `ABC` selected during the successful English-symbol test. Use the macOS
input menu to switch deliberately; a remote-control application may consume or
misroute the physical `Kana` and `Eisu` keys.

For conversion inside Ubuntu instead, the XRDP desktop has `ibus-mozc` in its
configured engine list. From a terminal inside that desktop:

```bash
ibus engine mozc-jp       # Japanese input
ibus engine xkb:us::eng  # plain English input
```

Chinese Pinyin and Wubi are documented separately in
[xrdp-cjk-input-on-ubuntu-24-04.md](./xrdp-cjk-input-on-ubuntu-24-04.md).

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

`setxkbmap -query` can show layout `jp` and variant `mac` while punctuation
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
- map `0x00000804` to layout `jp` in `/etc/xrdp/xrdp_keyboard.ini`
- match the observed type `7`, subtype `0` to model `applealu_jis` and variant
  `mac` separately; do not encode the variant as the literal layout
  `jp(mac)`

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

### When a macOS RDP client reports layout `0x00000000`

A second client path was observed later:

- Japanese Mac keyboard on a MacBook Air
- UU/Wangyi remote control into a Mac Pro
- Windows App / Microsoft Remote Desktop for macOS
- XRDP `Xvnc` on Ubuntu

This client reported:

```text
keyboard_type:[0x04]
keyboard_subtype:[0x00]
keylayout:[0x00000000]
```

Generate and install `/etc/xrdp/km-00000000.ini` from the same live
`applealu_jis` + `jp` + variant `mac` XKB session. A new connection should
then show:

```text
Loading keymap file /etc/xrdp/km-00000000.ini
```

As with the `0x00000804` compatibility map, verify that its `[shift]` section
contains `Key16=39:39`.

### XRDP `Xvnc`: the `RawKeyboard` experiment was not the final fix

Loading the correct `km-00000000.ini` was necessary but not sufficient for
the `Xvnc` backend. A raw `xev` capture of the first `Shift+7` test showed:

1. `Shift_L` pressed
2. `Shift_L` released
3. keycode `16` delivered as plain `7`

The live XKB map and XRDP keymap both already mapped that combination to an
apostrophe. The extra change happened in TigerVNC's keysym-to-layout mapping,
after XRDP had already translated the RDP key event.

TigerVNC provides `RawKeyboard` to send key events through and let the server's
configured XKB layout decide the result. It was tested by launching a genuinely
new Xvnc server with:

```bash
exec /usr/bin/Xtigervnc "$@" -SecurityTypes None -RawKeyboard=1
```

The running process and reboot persistence were both verified, but `7` and
`Shift+7` still both produced `7`. Therefore `RawKeyboard` does not solve this
particular `Windows App for macOS -> XRDP libvnc -> TigerVNC` chain. The option
was removed again; the fallback wrapper remains:

```bash
exec /usr/bin/Xtigervnc "$@" -SecurityTypes None
```

File:

- [~/scripts/xrdp-xtigervnc-wrapper.sh](/home/lachlan/scripts/xrdp-xtigervnc-wrapper.sh)

This is a useful negative result: do not keep adding server-side XKB remaps
when `setxkbmap`, `xmodmap`, and `km-*.ini` are already correct.

### Mac route: direct XRDP Xorg plus Unicode keyboard mode

XRDP's `Xorg` backend removes the additional VNC translation hop. Keep it as
the first/default connection section in `/etc/xrdp/xrdp.ini`:

```ini
[Globals]
autorun=Xorg

[Xorg]
name=Xorg
lib=libxup.so
username=ask
password=ask
ip=127.0.0.1
port=-1
code=20

[Xvnc]
name=Xvnc
lib=libvnc.so
```

Putting `[Xorg]` first matters. `autorun=Xorg` only bypasses XRDP's login panel
when the client supplies valid saved credentials. If the client asks for
credentials instead, XRDP selects the first suitable section in the file.

The server log should confirm the direct backend:

```text
loaded module 'libxup.so'
```

It must not say `libvnc.so` for this route.

On Windows App / Microsoft Remote Desktop for macOS, use Unicode keyboard mode:

```text
Connections -> Keyboard Mode -> Unicode
```

Shortcuts:

```text
Control+Command+U  -> Unicode
Control+Command+K  -> Scancode
```

Microsoft documents these two modes and shortcuts in its
[macOS Remote Desktop keyboard guide](https://learn.microsoft.com/en-us/previous-versions/remote-desktop-client/client-features-macos#keyboard-modes).

Unicode mode sends the finished printable character instead of forwarding the
Mac/remote-control modifier sequence as physical scancode press/release events.
This matters in the double-remote Mac route because direct Xorg Scancode mode
still produced the same value for `7` and `Shift+7`: Ubuntu never received a
usable held-Shift sequence. Unicode mode restored printable shifted symbols
after the malformed server layout was corrected.

Do not interpret this as proof that every key is now exact JIS. Test at least:

```text
plain 7
Shift+7
Shift+2
the dedicated @ key
slash / question-mark key
Kana and Eisu keys
```

If symbols work but follow US positions, printable transport is repaired but
the local macOS input source/key geometry still needs adjustment. Do that on
the Mac relay; do not corrupt the Ubuntu keymap to compensate for a character
the Mac client is already producing.

For a persistent macOS setting, fully quit Windows App after changing the menu
option. Its preference is:

```text
ClientSettings.KeyboardDriverMode = 1
```

where `0` is Scancode and `1` is Unicode.

The controlled rollback is:

```bash
defaults write com.microsoft.rdc.macos ClientSettings.KeyboardDriverMode -int 0
```

Fully quit and reopen Windows App after changing this preference. Keep a copy
of its preferences before experimenting.

### Preserve the old one-password direct login

This setup still uses XRDP authentication; it does not add GNOME/GDM's second
login screen. In Windows App, edit the saved PC and select a valid saved
credential for the Ubuntu account. With a valid credential and
`autorun=Xorg`, the connection enters the Xorg desktop directly.

Windows App's official
[saved-credential instructions](https://learn.microsoft.com/en-us/windows-app/user-account-settings-add-remove-manage#manage-credentials-for-devices-and-apps)
describe the same client-side setup.

If XRDP's old-style login panel unexpectedly appears, inspect the log:

```bash
rg 'login failed|login successful' /var/log/xrdp.log | tail
```

An immediate `login failed` followed by a successful manual login means the
client's selected saved credential is stale or belongs to another host. Fix
the selected saved credential in Windows App rather than storing a password in
`xrdp.ini`.

### The two practical client routes

1. **Windows computer -> XRDP**: this client was observed as keyboard type `7`,
   layout `0x00000804`. Map that id to layout `jp`, apply model
   `applealu_jis` and variant `mac` separately, and keep Xorg as the preferred
   backend. Configure Japanese/Microsoft IME on Windows itself first.
2. **Mac computer -> Windows App for macOS -> XRDP**: this client was observed
   as type `4`, layout `0x00000000`. Use XRDP Xorg plus Windows App Unicode
   mode for the double-remote route. Scancode mode lost held Shift in both the
   tested Xvnc path and the later direct-Xorg test.

These identifiers are compatibility observations, not universal truths. Check
`/var/log/xrdp.log` after changing the client machine or RDP application.

Native GNOME system Remote Login can feel smoother on some machines, but this
workstation previously experienced `gnome-shell` crashes in native GNOME RDP
sessions. It remains a separate, explicitly tested alternative rather than the
automatic replacement for XRDP.

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

The helper verifies that the target display belongs to an `xrdp-sesman`
session before changing anything, then runs:

```bash
setxkbmap -rules evdev -model applealu_jis -layout jp -variant mac -option caps:none
```

The helper must also work when invoked over SSH. In that case the caller's
`XDG_SESSION_ID` belongs to SSH, not XRDP. The repaired guard first checks the
current session and then falls back to matching `DISPLAY` against all
`xrdp-sesman` sessions. Without that fallback, a remote repair could silently
exit without changing the desktop.

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

For the current XRDP session, use its actual display number from `pgrep -a
Xorg`; XRDP may allocate `:10`, `:11`, or another display:

```bash
DISPLAY=:11.0 XAUTHORITY="$HOME/.Xauthority" \
  setxkbmap -rules evdev -model applealu_jis -layout jp -variant mac -option caps:none
```

No reboot is required.

Future XRDP desktop logins apply it automatically; no reboot or XRDP service
restart is required.

## Caveat

This fixes the Ubuntu side correctly.

If exact `Kana` / `Eisu` behavior is still imperfect, the limitation is
probably higher in the chain:

- Mac keyboard forwarding
- remote-control app
- Windows App / RDP

At that point the next step is a targeted remap for the specific keys that still arrive incorrectly.

Do not claim success from `setxkbmap -query` alone. Compare `xmodmap -pke`, the
XRDP log, and real typed output. A syntactically plausible layout can still be
overridden on reconnect, and Unicode mode can bypass physical XKB punctuation
entirely by sending the completed character.

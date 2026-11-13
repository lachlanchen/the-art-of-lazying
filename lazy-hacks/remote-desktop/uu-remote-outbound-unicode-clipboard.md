# UU Remote: Chinese clipboard text becomes question marks on a phone

The affected direction was **Ubuntu copy → phone paste** through the UU
Remote Ubuntu bridge. Chinese, Japanese and emoji first arrived as `?`.
An incomplete correction changed the result to garbled strings such as
`ä¸­` instead of `中`.

The final correction was confirmed on a phone on **13 November 2026**, using
UU **4.44.1.3978**, Wine 11 and the shared X11/VNC desktop relay. The existing
desktop, terminals, UU connection, independent RDP and RealVNC remained running.

## Cause

There were three encoding boundaries to check:

1. The host helper had to publish fresh text directly as Win32
   `CF_UNICODETEXT`. Valid text in an X11 selection did not by itself prove
   that Wine's Win32 clipboard contained that text.
2. UU's mobile export explicitly requested ANSI `CF_TEXT`, losing characters
   that Wine's ANSI code page could not represent. The export needed a UTF-8
   snapshot from the Unicode format.
3. UU then decoded the exported bytes as ANSI before encoding them as UTF-8
   for transmission. That second conversion also needed correction.

The third step ran later through a Qt callback on another thread. Live
metadata recorded export on thread 2472 and decode on thread 996. A thread-local
marker failed because the receiving thread could not see it. Those IDs are
observations from one run, not values to configure.

## Working correction

The bridge's `uu-clipboard-unicode.dll` targets the reviewed export and decoder
call sites. A bounded process-wide table associates each UTF-8 export with its
later conversion by exact bytes, allowing different threads and callback order.
Both the decoder's size query and actual conversion use UTF-8. Nonmatching data
keeps normal ANSI behavior.

The table holds at most 16 copies of at most 60 KiB each. Consumed data is zeroed
and freed; stale entries are discarded on subsequent copies. Clipboard content
is never logged or written to disk. Original clipboard formats, keyboard
layouts, incoming dictation and unrelated applications are preserved. The
private VNC clipboard feedback channel remains disabled.

Source, tests and the complete diagnostic record are maintained in the
[UU bridge repository](https://github.com/lachlanchen/uu-remote-ubuntu-bridge)
and the [pinned source submodule](../../code/uu-remote-ubuntu-bridge):

- [Detailed repair and validation guide](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/outbound-mobile-unicode-clipboard.md)
- [Guard implementation](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/src/uu_clipboard_guard.c)
- [Cross-thread native regression test](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/tests/probes/uu_clipboard_guard_probe.c)
- [PR #31](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/pull/31)

## Persistence and verification

Outbound forwarding remains opt-in with the existing service override:

```ini
# ~/.config/systemd/user/uu-remote-bridge.service.d/30-host-clipboard.conf
[Service]
Environment=UURB_HOST_CLIPBOARD=on
```

The normal installer installs the helper and DLL; the launcher attaches the
guard during account bootstrap. That includes startup after reboot. A Git pull
alone does not refresh installed helpers. The live repair needed no restart;
reboot startup was configured but not reboot-tested during this repair.

From the bridge checkout:

```bash
./scripts/verify.sh --quick
systemctl --user is-active uu-remote-bridge.service
```

Check `uu-clipboard-guard.log` under the Wine user's `AppData/Local/Temp`.
A fresh copy should produce both `result=exported encoding=utf8` and
`result=decoded encoding=utf8`, potentially on different threads. A loaded
DLL or an export receipt alone is insufficient.

Use a fresh Ubuntu copy for the phone test:

```text
中文测试 日本語 😀 “引号”
第二行 123 ' @
```

The phone confirmed the Unicode phrase; automated tests covered multiline
text, two queued copies decoded on another thread in reverse order, exact
matching, unrelated ANSI data and bounds. The local suite completed 264 tests
with six optional skips, and GitHub CI passed. Repeat real-client tests after
updates, including the independent incoming clipboard and dictation routes.

## Future upgrades and rollback

The original repair recognized **4.44.1.3978**. The subsequent
[4.47 upgrade](uu-remote-4.47-x11-upgrade.md) adds separately reviewed signatures
and fixes startup attachment to the identically named outer launcher. Unknown
builds are left unmodified and reported by verification. Later upgrades need
their export/decoder paths reviewed and the phone test repeated; offsets must
not be reused blindly.

To restore inbound-only behavior, remove the outbound opt-in override and
restart only the UU bridge during a reconnect window, with independent remote
access available. Preserve the Wine prefix and account. Do not reset the
desktop, change the global Wine code page, or enable another clipboard relay
as a workaround. DLLs whose functions are still referenced must not be unloaded
from a running process.

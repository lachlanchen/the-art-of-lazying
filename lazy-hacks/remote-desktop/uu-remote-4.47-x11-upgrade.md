# UU Remote 4.47 on Ubuntu: preserve input, clipboard and login

UU **4.47.0.5146** was installed on Ubuntu 24.04 with Wine 11 on
13 November 2026. The bridge continued to share the existing physical X11
desktop through its private VNC relay. The upgrade retained the saved UU
account, desktop windows, independent RDP and RealVNC services.

The [bridge release review](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/releases/4.47.0.5146-review.md)
contains the exact hashes, patch offsets and regression evidence.
[PR #32](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/pull/32)
contains the source changes. Private account files and installer binaries are
excluded from the public repositories.

## Verify the download, not its filename

The official rolling endpoint advertised 4.47, but one redirected download
identified itself as 4.45. The explicit official CDN artifact was accepted
only after its installer, server, GUI and CLI resources all identified 4.47.

The accepted installer is 93,214,568 bytes with SHA-256:

```text
fb2d24a40a51ae82701ae2d145db387df4fb63f8bad2d020db4afccda928195e
```

The updater now rejects version, URL and size changes between its probe and
download, including incomplete responses. These checks catch metadata drift;
they do not replace PE-version inspection or exact-hash review.

## Re-review the input and clipboard boundaries

The new server moved its virtual-input Boolean from object offset `0x268`
to `0x270`. The reviewed patch disables the unavailable Windows virtual-input
driver path at its constructor, settings reader and setter, preserving the
vendor's ordinary SendInput path. Unrelated similar instructions were excluded.

The [outgoing Unicode clipboard correction](uu-remote-outbound-unicode-clipboard.md)
also needs version-specific call sites. Ubuntu publishes Unicode into Wine;
the guard supplies UTF-8 at UU's audited ANSI export and corrects the later
queued decoder. The two steps can run on different threads. Exact-byte matching
in a bounded in-memory table preserves that relationship without changing the
global Wine code page or logging clipboard contents.

Separate signatures now cover 4.44 and 4.47. Unknown builds remain unmodified.
Incoming dictation and the host keyboard layout use their existing paths.

## Fix startup attachment to the wrong process

UU has two executables called `GameViewer.exe`: an outer launcher and the real
GUI under `GameViewer/bin`. A basename-only search could attach the clipboard
guard to the launcher during startup. That executable was correctly rejected
as unreviewed. Attaching manually later appeared to work because the launcher
had already exited.

The bridge now selects the full GUI executable path. Missing targets fail
without falling back to the launcher. An isolated Wine regression test starts
two identically named programs and verifies that only the requested path
receives the DLL. This fixes fresh-start attachment for both reviewed builds.

## Upgrade sequence and evidence

1. Record current settings and independent remote-access services.
2. Stop only the UU prefix long enough to copy it consistently. Keep a complete
   private backup, including registry and account state.
3. Install offline into the copy. Compare existing account/cache digests before
   the first candidate launch.
4. Apply the exact approved server patch and current bridge helpers. Run
   isolated keyboard, Unicode, clipboard, mouse and terminal tests.
5. Start the candidate with a timed rollback. Require a fresh server log,
   exact local IPC reply, correct binary hashes and fresh clipboard attachment.
6. Observe one server process for 270 seconds before promoting the candidate
   to the normal prefix. Repeat verification after that fresh start.
7. Retain the previous prefix and restore existing maintenance timers after
   the production checks pass.

Both the candidate and the normal installation passed separate 270-second
stability checks after fresh starts. All 65 original desktop windows were preserved. The
automated suite completed 266 tests with seven optional integrations skipped;
the relevant Wine and input integrations were also run explicitly.

Rapid keys, Chinese/Japanese/emoji fixtures, multiline dictation revisions,
mouse coordinates, clipboard ownership and the authenticated native terminal
adapter passed local tests. The new version still needs phone-side confirmation
of the full remote path. The earlier accepted 4.44 phone test is not a 4.47 result.

Super Screen, native anti-peep, image/file clipboard and native file transfer
remain unverified. Audio stays disabled on this host. Port-mapped SSH also
depends on its carrier and peer. See the
[feature matrix](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/features.md).

## Backspace and selection: test the route from the input hook

A phone connection exposed a failure after the upgrade: text arrived, but
Backspace and Shift+Left did not. The server hook reported physical keys as
`route=direct result=1 error=0`, while the native broker received only text.
Wine accepted the keys on its private desktop without delivering them to the
visible native desktop. A successful SendInput return value was insufficient.

[Bridge PR #33](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/pull/33)
corrects this boundary. An active native-input broker advertises its route
through a prefix-local Windows event. The input hook then routes ordinary keys
and mouse events through that broker. Unicode keeps its existing route;
RDP-only and RDP semantic-only installations retain their direct/fallback path.
The marker disappears when its broker exits, and readers close their handles
immediately. A broker rejection does not trigger a second direct-input attempt.

An environment variable alone was insufficient: the Windows service-created
server did not inherit the launcher's custom environment. The event crosses
that service boundary without changing the client's keyboard layout.

Earlier input fixtures called the broker directly and missed this defect.
The regression now starts at the actual SendInput hook. It checks 46 ordered
transitions covering deletion, arrows, navigation, Return, Tab, Escape,
Shift+Left, Ctrl+A, Ctrl+Left, Shift+A and scan-code Backspace. The mouse test
also crosses the hook. A separate fixture makes Wine report success without
delivering input, then checks native routing, marker expiry and RDP behavior.

The corrected runtime passed these checks, the existing rapid-input and
dictation fixtures, 267 unit tests with eight optional integrations skipped,
and another 270-second live stability check. All 65 original windows remained
present, and independent RDP, RealVNC and SSH processes were unchanged. The
native-route regression was also run explicitly under Wine. Confirmation on
the actual phone remains a separate acceptance step.

## Routine checks and persistence

From the bridge checkout:

```bash
./scripts/verify.sh --quick
systemctl --user is-active uu-remote-bridge.service
systemctl --user is-enabled uu-remote-bridge.service
uu-agent cli status
```

Use `./scripts/verify.sh` for the longer stability check. After an update, copy
`中文测试 日本語 😀 “引号”` freshly in both directions and test rapid typing,
Backspace, Shift+Left, Ctrl+A, mouse clicks and continuous dictation from the
actual client. For a native X11 deployment, verification must report that the
native input route is advertised to the service-created UU process.

The normal prefix, enabled services and user lingering preserve the deployment
across restart. An operating-system reboot was not performed during this review.
The manifest intentionally has no unattended-promotion acceptance object;
the fresh-install default and older manifests remain unchanged. Follow the
[safe upgrade runbook](uu-remote-safe-upgrade-runbook.md) and keep a private
rollback copy until real-client acceptance is complete.

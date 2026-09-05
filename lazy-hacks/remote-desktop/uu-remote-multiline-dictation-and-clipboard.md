# Preserve Multiline Dictation and Clipboard Text Through UU Remote

## Result

Direct UU Remote input into an Ubuntu XRDP/Xorg desktop now preserves:

- ordinary fast keyboard text;
- continuous dictation whose provisional composition exceeds a short
  keystroke batch;
- dictated or phone-IME text containing multiple lines;
- Chinese, Japanese, emoji, and other Unicode that has no active keyboard
  chord; and
- one-way UU/private-to-Ubuntu text clipboard transfer without a reverse
  feedback loop.

It also prevents the production regressions in which typing one Chinese
dictation commit or smart punctuation pasted unrelated clipboard text, and in
which continuing to speak flushed a composition after it crossed 64 input
records. The selection fix is bridge commit
[`2518016`](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/commit/2518016c2b1fe677584637999d9112df2022744c);
the long-dictation extension is
[`6dee29a`](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/commit/6dee29a).

The change restarts only `uu-remote-bridge.service`. It does not restart XRDP,
Xorg, GNOME Shell, or applications on the shared desktop.

## September 5 regression: two further causes, reproduced and repaired

The latest repair is bridge commit
[`641357d`](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/commit/641357d).
It fixes two distinct problems without changing keyboard layouts, disabling
the clipboard manager, modifying the network, or adding an input-retry loop.

| Symptom | Reproduced cause | Correction |
| --- | --- | --- |
| Some Chinese/smart-quote commits disappear | The helper killed its old clipboard owner first. GNOME restored its cached selection during the owner=None gap and displaced the new owner. | Establish the new CLIPBOARD/PRIMARY owners before retiring the old pair. |
| Long dictation erases the draft but does not replace it | 300 deliberately paced Backspace pairs took about 1.5 seconds, exceeding the broker's fixed one-second socket deadline. | Budget the response deadline for selection handling and the requested number of paced edits. |

Evidence came from an owned temporary editor, not the user's existing typing
field. Before the ownership fix, shared-desktop trials delivered 8/10, 6/10,
and 6/10 CJK commits. The clipboard owner exited normally before paste;
content-free XRes owner-to-PID lookup identified GNOME Shell as its replacement.
After the fix, the same desktop passed 10/10 and then 30/30 commits exactly.
An isolated XFixes restoration fixture also reproduces the old error `31` and
passes with the new ownership handoff.

The separate long-revision test first failed with `count=608 result=0 error=1236`.
It now completes `608/608 error=0` and preserves the unrelated text preceding
dictation. A timeout budget is not an added delay: normal key/mouse batches
retain their one-second bound; semantic requests allow three seconds; each
paced Backspace release adds five milliseconds. The existing 2,048-record
limit remains. Ambiguous input is never replayed.

Validation passed 137 unit tests and the direct-X11 text, split-display RDP
semantic text, one-way VNC clipboard, and Japanese-layout VNC symbol tests.
Chinese, multiline revisions, smart punctuation, split emoji, and a
1,000-character Unicode commit remained exact.

On the affected workstation only the two input binaries were replaced, with
private backups and a rollback guard. A UU-bridge-only restart loaded them;
the existing GNOME/Xorg processes and open applications remained intact. The
enabled bridge service loads these files after reboot. Its UU product version,
login state, desktop target, physical-key path and audio settings were unchanged.
The already verified two-way shell route also survived this local UU restart.

Operational caveats: a two-binary deployment is **not** a full runtime refresh,
so do not overwrite its whole-source digest. The local verifier still flags
an unrelated pinned hash for the unused Windows FreeRDP binary; the active
VNC/direct-X11 checks pass. Do not replace working RDP software just to silence
that unrelated check. Actual phone/controller acceptance remains important;
the automated fixtures do not make arbitrary focus changes or interrupted GUI
edits atomic.

The reproducible tests, implementation and bounded diagnostic details are in
[the bridge's semantic-text guide](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/semantic-text-and-clipboard.md).

## Symptom and Control Experiment

The useful comparison was:

```text
UU -> Windows -> RDP -> Ubuntu: multiline and Chinese dictation worked
UU -> Ubuntu bridge directly:   typing worked, but multiline text collapsed
                                and some non-English commits disappeared
```

This ruled out UU's controller-to-host text transport as the complete cause.
The direct bridge received the text, but represented every UTF-16 unit as a
keyboard event.

Content-free broker metadata confirmed two separate defects:

- line breaks became `VK_RETURN`, so an editor or terminal could interpret
  them as submission rather than text inside one paste;
- `VkKeyScanW` returned `ERROR_NO_UNICODE_TRANSLATION` (`1113`) for characters
  that the active Windows keyboard layout could not express, including CJK.

The old route was therefore suitable for physical keys and representable
characters, but not for semantic text.

The same defect remained on the bridge's default Wayland/RDP profile after it
was fixed for the opt-in direct-X11 profile: no helper was started on `rdp`, so
CJK still fell through to `VkKeyScanW` and returned `1113`.

## Adaptive Design

The default is now:

```text
UURB_PHONE_TEXT_MODE=auto
```

It separates physical input from semantic input:

```text
ordinary representable phone text
  -> existing authenticated X11 key route

newline / tab / CJK / emoji / other non-representable Unicode
  -> bounded authenticated text request
  -> UTF-16 validation and CRLF normalization
  -> separate target-desktop CLIPBOARD and PRIMARY owners
  -> verify that both new X11 selection owners exist
  -> one Shift+Insert paste
```

Backspace remains an editing key. The helper also joins a UTF-16 surrogate
pair when a controller sends its high and low units in separate calls.

On the default RDP track, ownership and injection intentionally use different
displays. The helper owns both selections on the physical X11/Xwayland
display, then injects only `Shift+Insert` into the private Xvfb display where
`Ubuntu-Desktop-Relay` is focused. FreeRDP carries that ordinary chord to the
physical application. Semantic-only broker mode keeps normal ASCII, physical
keys, and mouse events on RDP, so enabling CJK does not replace the stable
routine-input path.

The two owners are not redundant. GTK and many graphical editors may read
`CLIPBOARD`, while GNOME Terminal/VTE reads `PRIMARY` for `Shift+Insert`. The
first implementation owned and verified only `CLIPBOARD`; therefore its
content-free broker log could correctly report
`route=x11-clipboard-text ... error=0` while VTE visibly inserted an older
`PRIMARY` selection. That was the real reason a single Chinese commit or smart
quotation appeared to become a paste of unrelated text. It was not a UU
dictation, network, XRDP, locale, or clipboard-history failure.

The helper starts two independently tracked `xclip` owners, verifies that
both selections changed to new non-empty owners through X11, and emits the
paste chord only after both checks pass. A replacement now establishes the
new pair before retiring the previous scoped owners, preventing the GNOME
restoration race described above. Shutdown terminates both safely. If
either owner exits, times out, or cannot be verified, the operation fails
closed without issuing `Shift+Insert`.

The text payload is not written to logs or runtime files. It intentionally
remains in both selections after paste; restoring an old selection too quickly
would race applications that request the data asynchronously and would make a
later manual paste inconsistent.

## Production Failure and Root-Cause Proof

The decisive observations were:

1. Ordinary physical typing still worked, so the whole remote desktop was not
   broken.
2. Chinese and smart punctuation selected the semantic route, whose broker
   result count and `error=0` showed that the request reached the helper.
3. The visible text was a previous clipboard item, proving that a paste chord
   occurred but the target application requested a different X11 selection.
4. GNOME Terminal/VTE's `Shift+Insert` behavior explained why owning only
   `CLIPBOARD` could still paste stale `PRIMARY` data.
5. An isolated test seeded `PRIMARY` with a sentinel value before sending
   semantic text. The old implementation reproduced the defect; the two-owner
   implementation replaced the sentinel and delivered the exact requested
   text.

This is a useful diagnostic pattern: a successful injection log proves that
the helper accepted an action, not that the receiving toolkit consumed the
selection the helper expected.

## Why Continuous Speech Still Failed

The first semantic fix made one short English or Chinese message reliable, but
it exposed a separate size boundary when dictation continued. UU accumulates a
provisional phrase and can submit the whole revision as one Windows
`SendInput` array. Content-free production metadata showed:

```text
short requests: count <= 64, result=count, error=0
long requests:  count=70/76/92/98/114/332, result=0, error=5
```

The rejection occurred in the injected DLL before the broker or X11 helper saw
the request. It was not an RDP, network, microphone, speech-recognition, or
desktop-focus failure. This explains the misleading user experience: a short
message worked, then a longer provisional revision disappeared or left only an
older fragment.

The corrected protocol uses the same explicit maximum in the injected DLL,
Wine broker, and authenticated X11 helper: 2,048 input records, enough for
1,024 UTF-16 press/release pairs. The whole provisional call stays one
transaction. This detail matters for Unicode: splitting it into rapid 64-record
clipboard pastes appeared reasonable, but an isolated test proved that lazy
X11 selection requests could all read the newest owner and retain only the
final fragment. A request beyond 2,048 records fails before injection rather
than partially changing the target.

## Clipboard Relay Settings

The dedicated RealVNC Viewer between the private Wine desktop and the shared
Ubuntu desktop now uses explicit settings instead of version-dependent
defaults:

```text
ClientCutText=1
ServerCutText=0
SendPrimary=0
SendInitialClipboard=0
ServerClipboardGraceTime=5000
x11vnc -seldir recv
```

`SendPrimary=0` makes the private VNC clipboard relay source its outgoing text
from that private display's `CLIPBOARD`, not its selection-only `PRIMARY`
buffer. Disabling initial transfer prevents bridge startup from replacing an
existing target clipboard with stale private-display text. The reverse
target-to-private path is disabled at both relay boundaries, preventing
semantic text on Ubuntu from echoing into the UU canvas and triggering another
paste.

This setting does **not** mean the Ubuntu semantic helper should ignore
`PRIMARY`. These are two different boundaries:

- private UU/Wine display -> Ubuntu: relay only intentional `CLIPBOARD`
  changes, one way;
- semantic phone text already on Ubuntu: own both target `CLIPBOARD` and
  `PRIMARY` before synthesizing `Shift+Insert`.

This enables the local UU/Wine-to-Ubuntu text clipboard boundary. Final
controller-side copy/paste still depends on the UU client exposing its own
clipboard synchronization, so validate that separately from phone dictation.
This is text clipboard support, not file transfer.

## Isolated Regression Tests

Run these before changing the live bridge:

```bash
cd ~/ProjectsLFS/uu-remote-ubuntu-bridge

./scripts/test-rdp-semantic-text.sh
./scripts/test-x11-clipboard-text.sh
./scripts/test-vnc-clipboard-relay.sh
./scripts/test-x11-phone-text.sh
./scripts/test-vnc-keyboard-relay.sh
./scripts/test-x11-mouse.sh
python3 -m unittest discover -s tests
```

The semantic-text test creates its own Xvfb, Wine prefix, editor, and helper.
It first gives `PRIMARY` the sentinel
`stale-primary-must-never-be-pasted`, then proves that exact Chinese, two-line,
split-surrogate emoji, and a 2,000-record Unicode composition replace that
selection. The phone-text test sends another 2,000-record call through the real
hooked `SendInput` boundary and verifies every X11 transition in exact order.
These tests catch stale selection, old size-limit, content-corruption, and
ordering regressions without typing into the logged-in desktop or reading its
clipboard. Failed runs preserve their isolated artifacts for diagnosis;
successful runs clean them. The scripts use a shared display-allocation lock
so parallel runs cannot choose the same X socket.

The RDP semantic test creates two X displays and a Wine relay window. It proves
that `UU broker 中文 123` is exposed exactly on the physical clipboard only
after the paste chord reaches the private relay, reports
`route=rdp-clipboard-text`, and separately proves 52 ASCII events remain on
`route=rdp`.

The VNC clipboard test proves that client cut text reaches the isolated relay,
the target Unicode paste is exact, and target clipboard data cannot feed back
to the private display.

Expected semantic evidence is:

```text
clipboard-text=unicode+multiline exact
broker-route=x11-clipboard-text error=0
long-unicode-text=2000/2000 one-paste exact
long-phone-text=2000/2000 one-batch order=exact
vnc-clipboard=client-cut-text received server-feedback=disabled
semantic-target-paste=unicode exact clipboard-loop=absent
```

The accepted `6dee29a` run retained all 99 unit tests plus the phone-key,
VNC-keyboard, mouse, and one-way clipboard regressions.

## Safe Deployment

The installer preserves existing bridge settings and account state:

```bash
cd ~/ProjectsLFS/uu-remote-ubuntu-bridge
git pull --ff-only origin main
./install.sh --skip-packages --skip-account-login
```

Do not overwrite the running `uu-x11-input` executable in place. Linux may
reject that with `Text file busy`, and a partial manual copy creates an unclear
deployment state. Let the installer stop and replace the bridge-owned helper,
or explicitly stop only `uu-remote-bridge.service`, install through a temporary
file followed by an atomic rename, and start the same service again. Keep a
private rollback copy under
`~/.local/state/uu-remote-bridge/deployment-backups/` before a manual
replacement.

UU disconnects briefly. Confirm that the target desktop survived by comparing
its logind leader and Xorg PID before and after, then run:

```bash
./scripts/verify.sh --quick

DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR:-/run/user/$UID}/bus" \
  systemctl --user status uu-remote-bridge.service --no-pager
```

A healthy X11 deployment reports:

```text
PASS  input broker uses the auto phone-text mode
PASS  direct X11 physical-key helper is active
PASS  semantic Unicode and multiline clipboard text is available
```

A healthy default Wayland/RDP deployment instead reports:

```text
PASS  compatible RDP physical-key route is active
PASS  RDP semantic Unicode clipboard relay is active
```

Do not start the dual-display helper before private Xvfb and its Xauthority
are ready. The first live rollout caught that ordering error even though the
isolated components passed. Current source asserts the order and the quick
verifier fails if the broker says `semantic-clipboard=unavailable`.

For this incident, live verification additionally showed two scoped `xclip`
processes—one owning `CLIPBOARD` and one owning `PRIMARY`—and fresh
`x11-clipboard-text` broker records with positive result counts and
`error=0`. No XRDP, Xorg, GNOME Shell, application, login session, or whole
machine restart was required.

Then test direct UU in a disposable editor—not a password field—with ordinary
typing, Chinese/Japanese dictation, two lines, copy, and paste. A normal RDP
test does not exercise the direct-UU route.

## Behavior Tracks and Rollback

Keep the adaptive default:

```bash
./install.sh --skip-packages --skip-account-login \
  --phone-text-mode auto
```

Force the former key-only behavior if a host needs rollback:

```bash
./install.sh --skip-packages --skip-account-login \
  --phone-text-mode keys
```

`clipboard` is a diagnostic mode that pastes every phone-text commit except
editing keys. `auto` is preferable because it preserves the low-latency key
route for ordinary text and uses clipboard paste only when text semantics
require it.

For immediate containment of a stale-selection regression, changing only the
saved mode to `keys` and restarting `uu-remote-bridge.service` disables
semantic paste without disturbing the desktop. It may temporarily lose CJK or
multiline semantics, but it cannot paste an unrelated selection. Return to
`auto` after the two-owner helper and its regression test are installed.

## Follow-up: mixed-language revisions can silently erase earlier text

On 5 September 2026, a new isolated regression reproduced lost text even with
the GNOME clipboard-handoff and long-revision timeout fixes installed. The
broker reported success for every request, but a previous four-character
Chinese phrase disappeared from the editor.

The key detail was an English replacement inside a dictation revision. It
took the ASCII fast path and bypassed the deletion limit used for Chinese.
Its Backspaces also failed to reduce the remaining composition allowance.
A separate insert/delete sequence within one request credited new characters
too late, leading to incorrect edits and inflated allowance for the next call.

The bridge now routes Unicode batches containing editing Backspaces through
the same bounded semantic path regardless of replacement language, and counts
insertions in event order. Physical typing and ordinary ASCII insertion keep
their existing paths. No global keyboard, input-method, network, or desktop
configuration change is needed.

The regression checks complete editor contents after Chinese → English →
Chinese revisions, interleaved edits, and stale excess Backspaces. Earlier
messages must remain exact. A broker response of `error=0` alone is not enough
evidence. The test uses a disposable desktop, not the user's typing field:

```bash
bash scripts/test-x11-clipboard-text.sh
```

Actual phone/controller acceptance remains a separate check. Arbitrary focus,
selection, or external clipboard changes cannot be made atomic by sending
synthetic keys, and ambiguous input is never automatically replayed.

The fix is in bridge commit `65524cc`. The workstation received only the new
broker, with a rollback copy and an UU-only restart; its existing desktop and
applications were preserved. All138 unit tests and five isolated input/
clipboard suites passed. The service remains enabled for boot. The quick
verifier still reports an unrelated, pre-existing hash mismatch for an unused
Windows FreeRDP executable on this VNC profile; it was not replaced merely to
silence that check.

## Reusable Lesson

Keyboard keys, IME/dictation commits, mouse events, and clipboard updates are
different protocols even when one remote-control app carries all of them.
When shifted symbols fail, repair the modifier boundary. When multiline or
CJK text fails, preserve semantic text instead of adding key delays or changing
the whole desktop keyboard layout. When the requested semantic route succeeds
but old content appears, inspect the target toolkit's X11 selection semantics;
do not add retries, because retries can paste the wrong selection repeatedly.
When short dictation works but continuous speech disappears, compare the
original request `count` with the protocol bound before changing timing,
network, RDP, or IME settings. Preserve one semantic transaction rather than
blindly splitting a lazy clipboard paste.

Implementation and deeper security details are in:

- [`docs/semantic-text-and-clipboard.md`](../../code/uu-remote-ubuntu-bridge/docs/semantic-text-and-clipboard.md)
- [`docs/security.md`](../../code/uu-remote-ubuntu-bridge/docs/security.md)
- [`docs/debugging-journey.md`](../../code/uu-remote-ubuntu-bridge/docs/debugging-journey.md)

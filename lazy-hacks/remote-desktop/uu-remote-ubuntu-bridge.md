# Control an Ubuntu GNOME Desktop Through UU Remote

## Result

The official Windows UU Remote 4.33.0.8907 client now runs in a dedicated Wine
prefix and can display and control a logged-in Ubuntu 24.04 GNOME desktop,
including Wayland and XRDP/Xorg targets. This is an experimental,
version-locked compatibility bridge, not a native Linux port.

The backward-compatible `v0.2.0` release also fixes the difficult fast-typing
case seen on one XRDP workstation. Physical UU keyboard input can bypass the
lossy nested Wine/FreeRDP conversion and enter the live Xorg desktop through a
small native XTEST helper. Video, pointer, clipboard, and phone text keep using
the established local RDP relay. In the accepted live run, 256 bounded sampled
physical-key calls used `route=x11`, all returned `error=0`, and typing was
reported as very smooth with almost all previous omissions resolved.

The implementation is kept in the
[public submodule](../../code/uu-remote-ubuntu-bridge). It can be fetched
without a GitHub account:

```bash
git submodule update --init code/uu-remote-ubuntu-bridge
cd code/uu-remote-ubuntu-bridge
./install.sh
```

The installer downloads only pinned upstream artifacts, builds the local
compatibility components, configures a user-level systemd service, and prompts
without echo for a separate GNOME RDP relay password. UU account sign-in is
still required through the official client.

## Data Path

```text
UU controller
  -> GameViewerServer.exe in Wine
       |
       +-> video, mouse, clipboard, phone text
       |     -> Windows SDL FreeRDP in private Xvfb
       |     -> GNOME Remote Desktop on 127.0.0.1
       |     -> logged-in GNOME desktop
       |
       +-> physical keyboard
             -> bounded normal-token broker
                  | default: Windows SendInput -> local RDP
                  | opt-in on Xorg: authenticated loopback helper
                  v
             XTEST -> live XRDP/Xorg desktop
```

UU captures the FreeRDP window as a normal Windows application. GNOME Remote
Desktop performs the normal final capture and input integration. The local RDP
hop pins the SHA-256 fingerprint of GNOME's configured TLS certificate. The
direct X11 route changes physical-key delivery only; it does not replace the
working capture or pointer path.

## Why the Bridge Is Needed

Windows UU normally uses its signed `gvinput.sys` HID driver. Wine cannot load
that driver, so the audited patch selects UU's existing user-mode `SendInput`
path. Wine then rejects input from UU's service token with error 5, so an
injected IAT hook forwards only bounded `INPUT` records to a normal user Wine
process. That broker focuses the relay window and calls the original Windows
input API.

UU exposes a second keyboard boundary that was easy to misdiagnose. Native
phone IME commits arrive as `KEYEVENTF_UNICODE`, while SDL FreeRDP expects
physical key events. The broker converts representable Unicode characters into
ordinary virtual-key chords and paces new installations by 8 ms per character.
The computer-keyboard panel instead sends physical Windows keys.

On the affected XRDP workstation, adding 8 ms and then 12 ms of physical-key
pacing improved typing but never fully solved it. A bounded 12 ms capture
showed 219 physical-key broker calls with matching results and `error=0`,
while fast letters, Enter, and Ctrl combinations could still disappear. That
proved that a successful Windows API result was not the same thing as delivery
through both nested RDP conversions.

Wine also aborts UU's periodic `EvtOpenPublisherMetadata` call. The injected
DLL returns the normal Windows failure
`ERROR_EVT_PUBLISHER_METADATA_NOT_FOUND`; the caller handles it and continues.
The upstream health monitor is replaced with a sleeping, reversible stub
because it incorrectly killed a healthy Wine process.

## Root Cause and Final Fix

The useful comparison was not “UU versus the network.” It was the same live
desktop through two paths:

| Path | Result | What it proved |
| --- | --- | --- |
| Direct XRDP keyboard | Normal | Xorg, GNOME, and the target application could consume fast input |
| Direct UU through Wine/FreeRDP | Occasional missing keys | Loss remained inside or before the nested conversion path |
| UU broker metadata at 12 ms | Every sampled call accepted | More `SendInput` success or delay could not prove final delivery |
| Native XTEST burst on isolated Xvfb | 58/58 transitions | The direct helper preserved alphabet, Ctrl, and Enter press/release ordering |
| Live UU with direct X11 route | 256/256 sampled calls successful; typing very smooth | The local conversion defect was practically resolved |

The final design is deliberately narrow:

1. Keep `rdp` as the global default so a known-good older/Wayland computer
   does not change.
2. Enable `x11` only for an affected, verified Xorg/XRDP desktop.
3. Accept only bounded, non-Unicode, keyboard-only records in the native
   helper.
4. Map the complete request before injecting its first event.
5. Fall back to RDP only when failure is known to occur before injection.
6. Never replay an ambiguous partial request; a late original plus a retry can
   type duplicate or dangerous shortcuts.
7. Track held keys and release them if the broker disconnects.
8. Supervise the helper inside the existing service instead of adding another
   polling daemon.

The helper dynamically loads the existing X11 and XTEST runtime libraries,
binds an ephemeral loopback-only port, and requires a fresh 256-bit token on
each service start. The port file lives in the user's mode-0700 runtime
directory. The token is inherited through process environments rather than
stored in configuration or exposed in the command line. Logs contain counts,
route, timing, and result only—never keycodes or typed text.

## Installation and Route Selection

The conservative install remains:

```bash
./install.sh
```

For an already authenticated bridge on an affected Xorg/XRDP desktop:

```bash
./install.sh --skip-packages --skip-account-login \
  --keyboard-route x11 --physical-key-delay-ms 0
./scripts/verify.sh --quick
```

The physical delay has two meanings:

- on `rdp`, it sleeps after an accepted physical-key segment;
- on `x11`, it is only a minimum down-to-up hold interval.

Zero is correct for the validated direct route because XTEST plus `XSync`
already preserves ordering without creating upstream back-pressure.

Available route modes are:

| Mode | Behavior |
| --- | --- |
| `rdp` | Compatible default; all input uses the established local relay |
| `x11` | Require direct physical-key injection and make verification fail if it cannot start |
| `auto` | Select direct input only when the discovered live target is X11 |

The choices are stored in
`~/.config/uu-remote-bridge/environment`. A later plain installer run
preserves them.

Rollback does not delete UU login state:

```bash
./install.sh --skip-packages --skip-account-login \
  --keyboard-route rdp --physical-key-delay-ms 0
```

Do not copy `x11` blindly to a Wayland host. The old `v0.1.0` tag remains
immutable, and `v0.2.0` defaults to `rdp`, physical delay `0`, and
unfiltered network adapters.

## Reusable Debugging Lessons

1. **Separate the input modes.** UU's computer-keyboard panel, native phone
   IME, mouse, and clipboard are different protocols. One passing path says
   little about another.
2. **Do not equate API acceptance with visible delivery.** `SendInput`
   returning the requested count proved only that Wine accepted a call, not
   that SDL FreeRDP, GNOME RDP, Xorg, and the application consumed it.
3. **Use a healthy bypass as the control.** Direct XRDP typing on the same
   desktop ruled out CPU load, Xorg, GNOME, and the target application as the
   complete cause.
4. **Instrument boundaries without recording content.** Separate quotas for
   keyboard, phone text, mouse, and other input prevented mouse traffic from
   hiding keyboard evidence while preserving privacy.
5. **Treat pacing as an experiment, not a cure.** Eight and twelve milliseconds
   gave useful evidence and partial improvement. Continuing to increase delay
   would only add back-pressure.
6. **Remove one bad hop, not the whole architecture.** Keeping working
   video/mouse/text channels unchanged made the final fix small and reversible.
7. **Never replay after uncertainty.** Retrying a possibly delivered modifier
   or shortcut is more dangerous than returning one failure.
8. **Preserve known-good machines.** New functionality is opt-in, migration
   retains old behavior, and the immutable release tag remains available.
9. **Verify deployed code, not only source.** The runtime digest prevents a
   freshly pulled checkout from being mistaken for the older installed helper.
10. **Require visible and machine evidence.** The isolated event count, live
    route counters, verifier, and human typing result each prove a different
    boundary; no single one is sufficient alone.

## Reproducible Record

The public submodule contains the complete source and operational record:

- `README.md` plus `i18n/`: polished overview and selector for 11 languages
- `docs/architecture.md`: process and trust boundaries
- `docs/methodology-and-toolkit.md`: complete problem-solving method and tool inventory
- `docs/reverse-engineering.md`: exact `strings`, `xxd`, `objdump`, hashes,
  disassembly addresses, instruction offsets, and replacement bytes
- `docs/upstream-maintenance.md`: repeatable workflow for a new UU release
- `docs/security.md`: credential handling and residual risk
- `docs/troubleshooting.md`: black video, failed input, NLA, and restart checks
- `docs/debugging-journey.md`: evidence from failed hypotheses through the
  final direct-X11 route
- `docs/xrdp-and-keyboard-recovery.md`: safe XRDP recovery, physical pacing,
  direct-X11 activation, acceptance, and rollback
- `docs/releases/v0.2.0.md`: backward-compatibility contract and validation
- `docs/mobile-keyboard-parity-handoff.md`: known-good 7090 keyboard baseline,
  cross-host comparison, acceptance matrix, and privacy-safe failure handoff
- `patches/*.json`: approved versioned release identities and patch signatures
- `scripts/stage-uu-release.sh`: private archive/sandbox staging
- `scripts/audit-gameviewer.py`: PE map, semantic candidates, disassembly report,
  draft generation, and explicit finalization gate
- `scripts/patch-gameviewer.py`: generic fail-closed patch, verify, and restore CLI
- `install.sh`: complete from-scratch setup

No NetEase binary, Wine prefix, account token, device ID, password, private
key, production log, or desktop screenshot is committed.

## Operations

```bash
uu-remote status
uu-remote restart
uu-remote logs
scripts/verify.sh --quick
scripts/verify.sh
```

The quick verifier must identify the active route. For this Xorg fix it reports:

```text
PASS  input broker uses a 0 ms physical-key delay
PASS  direct X11 physical-key helper is active
```

After reconnecting the UU controller, fresh content-free keyboard records use
`category=keyboard route=x11` with a matching result and `error=0`. A test
performed through ordinary RDP does not validate the UU route.

The full verifier holds one GameViewerServer PID for 270 seconds, crossing the
former four-minute failure interval. The original controller acceptance
rendered the live desktop, delivered mouse clicks, and typed through the
broker without disconnecting. The v0.2 direct-keyboard acceptance adds:

- 40 passing source, shell, documentation, migration, and helper-build tests;
- a lossless isolated 58-event alphabet/Ctrl/Enter XTEST run;
- 256 successful sampled live `route=x11` calls with no broker errors;
- the operator's visible report that typing became very smooth and almost all
  former omissions were fixed.

The wording is intentionally “strong practical acceptance,” not a universal
zero-loss promise. The bounded diagnostics cannot reconstruct typed content,
and UU's controller/network remains outside the host's control.

## Upstream Updates

Unknown UU binaries remain blocked. A new version follows this workflow:

1. Stage the installer without touching the live prefix; use the explicit
   root-managed, networkless systemd sandbox only if archive extraction fails.
2. Generate PE sections, semantic landmarks, masked candidates, targeted
   disassembly, hashes, and a deliberately non-runnable draft manifest.
3. Re-establish every patch's semantics against a Windows reference and the
   complete new function control flow.
4. Finalize only reviewed candidates; the tool derives the full patched hash
   without modifying the binary.
5. Prove patch, expected-state verify, byte-identical restore, controller
   input, reconnect, restart, and 270-second stability on disposable state.

The installer accepts an approved future manifest with
`--release-manifest`. Drafts, ambiguous signatures, unknown hashes, overlapping
patches, and restore over a different release fail closed.

Restore the audited upstream files while keeping UU account state:

```bash
./uninstall.sh --dry-run
./uninstall.sh
```

The dry run validates both audited backups without stopping anything. Use
`./uninstall.sh --purge` only when the dedicated Wine prefix, bridge
credential, and UU account state should also be deleted.

## Security Boundary

This setup preserves both UU and GNOME authentication. It does not modify an
OS account database, bypass a login, install a kernel driver, or expose a new
remote-control protocol. The service and bridge run as the logged-in Unix
user. Treat the Wine prefix and runtime logs as private because they contain
UU account and device metadata.

Do not weaken the patcher's version and signature checks after a UU update.
Audit the new executable and update the pinned hashes and disassembly record
as one reviewed change.

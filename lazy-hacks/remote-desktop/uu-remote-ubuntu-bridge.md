# Control an Ubuntu GNOME Desktop Through UU Remote

## Result

The official Windows UU Remote 4.33.0.8907 client now runs in a dedicated
Wine prefix and can both display and control the logged-in Ubuntu 24.04 GNOME
Wayland desktop. This is an experimental, version-locked compatibility bridge,
not a native Linux port.

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
  -> bounded local SendInput broker
  -> Windows SDL FreeRDP in a private Xvfb display
  -> GNOME Remote Desktop on 127.0.0.1:3390
  -> logged-in GNOME Wayland desktop
```

UU captures the FreeRDP window as a normal Windows application. GNOME Remote
Desktop performs the final Wayland capture and input integration. The local
RDP hop pins the SHA-256 fingerprint of GNOME's configured TLS certificate.

## Why the Bridge Is Needed

Windows UU normally uses its signed `gvinput.sys` HID driver. Wine cannot load
that driver, so the audited patch selects UU's existing user-mode `SendInput`
path. Wine then rejects input from UU's service token with error 5, so an
injected IAT hook forwards only bounded `INPUT` records to a normal user Wine
process. That broker focuses the relay window and calls the original Windows
input API.

Wine also aborts UU's periodic `EvtOpenPublisherMetadata` call. The injected
DLL returns the normal Windows failure
`ERROR_EVT_PUBLISHER_METADATA_NOT_FOUND`; the caller handles it and continues.
The upstream health monitor is replaced with a sleeping, reversible stub
because it incorrectly killed a healthy Wine process.

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

The full verifier holds one GameViewerServer PID for 270 seconds, crossing the
former four-minute failure interval. The validated controller test rendered
the live desktop, delivered mouse clicks, and typed a command through the
broker without disconnecting. The retained diagnostic record contains 1,000
successful bounded broker events without logging keys or coordinates.

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

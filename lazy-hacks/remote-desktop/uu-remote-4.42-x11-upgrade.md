# Recover and update the shared X11 UU desktop

On 1 October 2026, the shared X11 workstation was updated from patched UU
4.39.2 to the reviewed 4.42 installer, preserving the existing desktop and
account. The audited bundle is named 4.42.1.2835 in the bridge manifest; its
CLI reports 4.42.0.2770. Verify artifact hashes instead of trusting the filename.

The full, reusable evidence is in the bridge's
[workstation upgrade record](../../code/uu-remote-ubuntu-bridge/docs/releases/4.42-x11-workstation-20261001.md)
and [semantic input/clipboard guide](../../code/uu-remote-ubuntu-bridge/docs/semantic-text-and-clipboard.md).

## Lessons

- A running service is not sufficient evidence of remote connectivity. The
  old service had restarted after child failures and preferred-route changes;
  by inspection it had recovered locally. Its binaries were still correctly
  patched. Do not describe a vendor overwrite as this host's proven outage.
- The first helper refresh hit an expired FreeRDP artifact URL and rolled
  back. The installer now builds FreeRDP/libei only for the RDP relay, so an
  X11/VNC-only refresh has no unnecessary Windows RDP download dependency.
- Keep an entire **stopped**, signed-in Wine prefix for rollback. Prepare the
  exact-hash installer in a separate writable candidate with network access
  disabled. Compare login registry and account-cache digests before starting.
- Test a candidate with a timed return to the original. Require live IPC,
  exact patches, input helpers, stable service ownership and a real controller
  test. This user confirmed connection, controls and Chinese input.
- Move the tested candidate to the normal prefix, reinstall helpers for that
  path, and verify before canceling the return timer. Temporary candidate paths
  must not become the accidental permanent boot configuration.
- Preserve independent RDP/RealVNC and the shared desktop. Both services kept
  their original PIDs. No logout, application shutdown or reboot was needed.

## Clipboard without breaking dictation

The established inbound GameViewer-to-Ubuntu clipboard companion stays active.
This host also enables the new optional return path with:

```ini
# ~/.config/systemd/user/uu-remote-bridge.service.d/30-host-clipboard.conf
[Service]
Environment=UURB_HOST_CLIPBOARD=on
```

It watches fresh application CLIPBOARD changes using XFixes and obtains the
owner PID through XRes. It excludes bridge-owned input/clipboard processes,
does not replay the startup clipboard, and never sends a paste shortcut.
The redundant private VNC cut-text route is disabled while this extension is
active, preventing clipboard feedback into phone dictation.

This optional path requires `python3-xlib` and an X11/VNC desktop. It transfers
UTF-8 text up to 60 KiB; image/file transfer is not included. Isolated tests
verified multiline Chinese, emoji and the Windows CF_UNICODETEXT boundary,
owner filtering and oversized-copy rejection. Verify both directions with
the actual remote client too; mobile client policies can differ.

After changing this drop-in, reload user systemd and restart **only** UU:

```bash
systemctl --user daemon-reload
systemctl --user restart uu-remote-bridge.service
```

This briefly reconnects UU. Remove only this drop-in to return to the previous
inbound-only clipboard behavior. Do not globally enable VNC clipboard feedback
or replace the established phone Unicode/dictation route.

## Routine checks and rollback

```bash
uu-remote upgrade status
cd "$HOME/ProjectsLFS/uu-remote-ubuntu-bridge"
./scripts/verify.sh --quick
systemctl --user is-enabled uu-remote-bridge.service
```

Startup units and user lingering remain enabled, and the previous maintenance
timers were resumed. Automatic product promotion stays disabled; the managed
Wine process tree now blocks the known unmanaged `Upgrade.exe` entry point.
The patch, login, input and runtime checks are the authority, not a cached
updater status line. No new reboot test was performed.

Rollback prefixes, credentials, raw screenshots/logs and machine-specific
restore commands remain in private local state and SystemTutorial. They do
not belong in Git. Retain the old prefix until satisfied with real-controller
clipboard and dictation behavior; a complete prefix can consume tens of GiB.

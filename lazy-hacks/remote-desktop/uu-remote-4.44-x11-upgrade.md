# Upgrade a patched UU Remote X11 bridge to 4.44.1

UU Remote 4.44.1.3978 can run on the existing Ubuntu 24.04 X11 bridge with
reviewed, version-specific patches. The 26 October 2026 upgrade retained the
signed-in account, shared desktop, direct X11 input, semantic text helpers,
clipboard configuration and audio isolation. The independent RDP and RealVNC
services were not restarted.

The exact hashes, patch offsets and test results are in the bridge's
[4.44.1 compatibility review](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/releases/4.44.1.3978-review.md).
This record covers an operator-requested upgrade; it does not enable automatic
promotion or replace the fresh-install default.

## Verify the download and patch locations

The official release endpoint advertised 4.44.1 through HEAD while GET still
redirected to 4.44.0. A moving download URL alone was therefore insufficient.
The newer installer was downloaded from the exact official CDN URL and checked
against its full SHA-256. Its extracted PE version resources matched 4.44.1.3978.

The existing three virtual-input patches had moved. Their new locations were
checked against bounded functions, the `global/virtual_mouse_switch` setting
references and the SendInput backend. A masked search found four setter
candidates; only one matched both the full instruction sequence and the
setting reference. Reusing an offset or selecting the first pattern match
would have been unsafe.

The patcher accepts only the reviewed server hash. A disposable patch/restore
test reproduced the original file exactly.

## A running app can fail an outdated readiness check

UU 4.44 changed two command-line replies:

| Check | Older format | 4.44.1 format |
| --- | --- | --- |
| Version | `version` returns a bare version | `version` returns diagnostic fields; `--version` returns the bare version |
| Live IPC | `echo <nonce>` returns the nonce | It returns `echo: <nonce>` |

The first candidate was automatically returned to the previous version because
the old checker rejected these formats. The fix selects the exact expected
format for the audited release. It still rejects wrong versions and incorrect
or missing nonce replies. A version string alone does not prove that the
application is running or reachable.

## Keep account data and the desktop intact

1. Copy the complete Wine prefix while its own processes are stopped. Keep the
   original available for rollback.
2. Run the installer in the copy with networking disabled. Compare the login
   registry and account-cache digests before launching it.
3. Inspect any difference. Here, the installer added a version-specific log
   under the shared state directory. Moving that new log to private evidence
   allowed the strict account comparison to pass without excluding account
   files or changing credentials.
4. Test the copy through a temporary service override with a timed return to
   the original. Check patches, live IPC, input helpers, desktop geometry and
   process stability.
5. Move the tested copy to the normal prefix, refresh its helpers and remove
   the temporary override. Preserve the existing desktop and network settings.
   Cancel the return timer only after verification succeeds.

The local fixtures covered Chinese, punctuation, emoji, multiline text,
dictation revisions, mouse input, clipboard owner filtering and the native
terminal. The full suite passed 260 tests, with two optional checks skipped.
UU's own status reported logged in, service running, network connected and no
error. These checks do not replace a fresh phone/controller test for rapid
typing, dictation and clipboard transfer in both directions.

## Check the installed bridge

```bash
cd "$HOME/ProjectsLFS/uu-remote-ubuntu-bridge"
./scripts/verify.sh --quick
systemctl --user is-active uu-remote-bridge.service
systemctl --user is-enabled uu-remote-bridge.service
```

Autostart and user lingering were preserved. No reboot or desktop logout was
needed; a reboot was not performed as part of qualification. The old prefix,
machine-specific restore commands and raw logs remain in private local storage.

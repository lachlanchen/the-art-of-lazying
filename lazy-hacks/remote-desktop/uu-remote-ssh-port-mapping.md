# SSH through UU Remote between Ubuntu hosts

## Result and limitation

**Later real-use failure:** the Windows-assisted path described below dropped
on5 September2026 while the user was taking control of the Windows neighbor.
The peer recorded reverse-SSH exit255 at19:19:18 and disappearance of its UU
carrier listener; the return listener disappeared as well. Native Windows SSH
and its existing UU processes stayed alive. The exact vendor disconnect reason
was not decoded, but this demonstrates why earlier successful shell/file tests
must not be presented as takeover-safe, unattended availability.

Removing that Windows hop and making SSH independent of UU desktop ownership
are different objectives. A direct Ubuntu-to-Ubuntu mapping may satisfy the
first while still failing the second. Test both, cancel ownership prompts,
and never add a reconnect loop that competes with the user's desktop. A native
private network independent of UU is a separate user-approved option, not a
silent cloud/VPN fallback.

The coordinated follow-up tested **Port Mapping directly to the Ubuntu UU
endpoint**, not Windows. Its page reported another controller and UU displayed
an explicit takeover requirement for port mapping. The operator canceled;
the rule editor never opened and no scratch listener appeared. Existing
desktop focus and services were preserved. This establishes an ownership gate
in the tested state, not proof that port mapping is generally unsupported.

Keeping RDP/VNC open while voluntarily disconnecting only the direct UU viewer
would allow a coordinated test with the slot free. It would not prove that a
later direct-UU takeover leaves SSH alive. Do not confuse freeing a UU control
slot with logging out of Ubuntu; no logout or application closure is needed.

On 2026-09-05, UU's built-in TCP port mapping was tested from a Wine-hosted
Ubuntu controller to another Wine-hosted Ubuntu computer. A loopback port on
the controller reached the destination's native OpenSSH server, and a
dedicated Ed25519 key successfully authenticated as its Linux user.

Later the same day, both hosts independently verified **SSH in both
directions**, using one native UU mapping plus one reverse SSH forward. Each
host used its own key; neither private key was copied to the other machine.

No new network/Wine patch was required. The improvement is a small `uu-ssh`
helper in the [UU bridge repository](https://github.com/lachlanchen/uu-remote-ubuntu-bridge),
with persistent aliases, public-key setup, diagnostics, native UU Terminal
shortcuts, and optional reverse SSH forwarding. See its complete
[SSH guide](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/ssh-and-port-mapping.md).

**This is not a virtual LAN or guaranteed unattended VPN.** A mapping forwards
one service. The live mapping later disappeared; reopening it prompted for
takeover of an already-controlled device. The prompt was canceled to preserve
that controller. The initial listener loss was not definitively explained.
Do not automate takeover or promise coexistence without testing it.

An observed recovery on the tested 4.39.2 pair was to query native terminal
sessions. This initialized the vendor connection and reopened its existing
saved mapping, without a GUI takeover or bridge restart:

This is historical evidence, **not an automatic recovery recipe**: even a
session-list query can initialize a UU controller connection. Only try it in
a coordinated test window, never while another agent owns connection recovery.

```bash
# Store the peer device ID locally first if not already configured:
uu-ssh add lab --port 22709 --user YOUR_REMOTE_USER --device-id UU_DEVICE_ID
timeout 15 uu-ssh terminal lab --list-sessions
ss -ltn '( sport = :22709 )'
uu-ssh check lab
```

This worked twice, but **does not create a missing rule or guarantee sustained
connectivity**. A recovered mapping later dropped even though the local UU
service and server PIDs did not change. The reverse SSH process exited with
that lost path. Do not hide this limitation behind an always-retrying loop or
interpret binary `.slog` growth as a decoded cause.

The recovered path then passed **30/30 bidirectional SSH rounds with zero
failures over 348 seconds**, keeping the same owned reverse process. A known
237568-byte multilingual UTF-8 fixture was echoed byte-exactly through both
paths. This verifies current usable transport; it does not establish reboot
persistence or simultaneous direct-desktop-control acceptance. The latter
still awaited a real client connection.

Longer monitoring then caught another mapping loss, so the short pass must
not be read as uninterrupted reliability. The retained forward exited 255
with `Connection to 127.0.0.1 closed by remote host.` A one-time native
terminal attempt failed with vendor `Streamer error: 9012` before any shell
opened, despite the device still being listed online. The meaning of that
code was not established; the agents stopped additional connection attempts
to check controller ownership instead of guessing at a reset. In particular,
`uu-agent status` lists outgoing connections and cannot alone prove there is
no inbound desktop controller.

The latest `uu-ssh check` no longer suggests that session-list warm-up. It
checks only the configured TCP/SSH path, cancels nothing, and says to preserve
active desktops and cancel takeover prompts. A five-second timeout applies to
each socket stage; the strict key-only SSH diagnostic has its own 15-second
timeout and disables agent/configured forwarding. Nine isolated helper tests
cover failure, timeout cleanup, config preservation, and no UU recovery action.

SSH itself does not acquire a UU desktop-control slot. But **the native UU
mapping carrying it may be takeover-gated**. One mapping plus a reverse SSH
forward avoids a second UU connection; it does not prove that the first can
coexist with an active inbound viewer. Ordinary SSH, diagnostics, and agent
messages must consume an existing mapping and fail/queue if it is unavailable,
not silently open Terminal or steal control. Bulk file transfers still share
network bandwidth even when session ownership is independent.

Native UU Terminal is also worth testing separately when a remote shell, not
specifically SSH, is sufficient. In one direction a bounded fresh-session test
failed before shell creation with 9012; in the other it reached terminal startup
but reported an upgrade requirement despite both product versions being
4.39.2.1561. Static inspection found that error1004 covers both payload-version
and controller-platform compatibility rejection. The exact live branch remains
unproven, so do not reinstall or patch a working desktop merely from that generic
message. A terminal UI is not automatically a binary-safe file-transfer channel.

### Native-client comparison: a working mapping is not a standalone bridge fix

A later bounded comparison used an already-authorized nearby Mac with signed
native UU Remote 4.35.0. Its actual Port Mapping panel accepted one scratch
rule to the remote Ubuntu's `127.0.0.1:22` without a takeover prompt. The
listener bound to the Mac's loopback interface only. Through an existing
trusted LAN SSH hop to that Mac, the companion Ubuntu verified the remote
host key and public-key login. Five independent commands returned the expected
identity and preserved exit statuses `0, 7, 0, 17, 0` exactly. Neither Ubuntu's
bridge was restarted. This is peer-reported live evidence, not a local mock.

This establishes a usable **Mac-assisted UU SSH route**, not a repair of
Wine-to-Wine Terminal, a standalone two-Ubuntu connection, reboot persistence,
or user-verified desktop/input coexistence. The Mac and its mapping must remain
available; closing the mapping panel can stop its connections. Disclose that
dependency before selecting it as a default. Do not silently route through a
third computer or start a reconnect daemon merely because a diagnostic passed.
The return path and file transfer need their own acceptance checks.

The native Mac mapping subsequently returned to **Connection failed** and its
listener disappeared. One explicit reconnect also failed, without a takeover
prompt. The earlier five passing commands are historical evidence, not current
availability or proof of stability. No exact disconnect cause was recovered;
do not assume a vendor timeout or exclude a controller/panel lifecycle event.

A newly authorized nearby Windows client offered another comparison. Existing
key-only LAN SSH worked; native UU 4.38.3 saw both Ubuntu devices online. One
fresh native-Windows Terminal request reached terminal startup but reported
that the client was too old for the 4.39.2 host. No native broker session opened.
The SSH/ConPTY command returned zero despite the explicit error, so acceptance
must require actual remote identity/output, not just the wrapper's exit code.
The test left no CLI child and did not update or restart Windows or UU.

The useful Windows result came from **Port Mapping**, not native Terminal. A
Wine-hosted 4.39 controller opened one loopback-only rule through the already
authorized native Windows host to an SSH server reachable on that host's LAN:

```text
Ubuntu controller:127.0.0.1:22023
    -> native Windows UU host
    -> Windows-side LAN target:22
```

The controller recorded the real remote-side target with `--mapping-target`
and selected OpenSSH explicitly with `--shell-transport ssh`. Five fresh
shells preserved exit statuses `0, 7, 0, 17, 0`; a 237638-byte random/UTF-8
fixture made a byte-identical upload/download round trip. One reverse SSH
forward then passed an independent host/user check, real PTY, multilingual
UTF-8, exit status `17`, and byte-exact file transfer in the other direction.
Another 18 shell checks passed over about three minutes. This was the accepted
route: it removed the failed Mac hop, but it still depends on the native
Windows host and its one live UU mapping. It was not a reboot test.

An earlier native Mac TerminalWindow opened successfully but produced no new
native Ubuntu broker event. A window may be a session picker, so that alone
does not prove a shell request failed. Likewise, local-only CLI tests from
both the home directory and the UU binary directory hung before a broker
session appeared: there was no evidence for a working-directory patch.

## Durable agent messages without another service

The bridge now includes `uu-link`, a private inbox/outbox over the existing
OpenSSH aliases. Install only this standalone helper on both hosts to avoid
restarting a working desktop:

```bash
# From the uu-remote-ubuntu-bridge checkout, on each host:
install -m 0755 scripts/uu-link "$HOME/.local/bin/uu-link"

# Workstation -> configured lab peer:
printf '%s\n' 'Ready for your test. 中文 / 日本語 / "quotes"' | uu-link send lab

# Lab: inspect the message; read prints terminal-safe JSON.
uu-link inbox
uu-link read MESSAGE_UUID

# Lab -> its configured workstation peer:
printf '%s\n' 'Test completed; here is my result.' |
  uu-link send workstation --reply-to MESSAGE_UUID
```

The message is stored before the bounded SSH attempt. A successful receipt
confirms its ID and SHA-256 digest. If connectivity fails, the original stays
in the private outbox and can be retried with the same UUID:

```bash
uu-link outbox
uu-link retry MESSAGE_UUID
uu-link send lab --file /path/to/private-handoff.md --queue-only
```

Receiver retries deduplicate without overwriting another payload. Files are
`0600` under `0700` directories in `~/.local/state/uu-link/`; do not upload
them to public Git. No new daemon, network port, GUI input, password store,
automatic recovery, or execution of message contents is introduced. A receipt
is not a human/agent response; a paused agent must still be resumed and told
to read its inbox. The Unix SSH account is the trust boundary, not the sender
label written in a message. Keep shared private Markdown as an offline
fallback. See the complete [agent-link guide](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/agent-link.md).

The 2026-09-05 live test installed identical helpers on both hosts and obtained
actual receipts in both directions for English, Chinese, Japanese, emoji,
quotes, and multiple lines. The return test was driven by the workstation
over SSH, not represented as an independent response from the peer agent.
Ten isolated message tests and all 121 repository tests passed. A later
mapping drop also demonstrated the failure behavior: a new message stayed
queued instead of being lost or triggering a desktop restart.

### Do not confuse a short active pass with availability

The resumed recovery later passed the peer's **36/36 strict two-way checks over
433 seconds**, then disconnected again: the workstation return forward exited
255 at 15:23:01 HKT and its UU mapping listener vanished. The local bridge,
controller and server processes remained alive with unchanged identities.
This happened before the intended idle acceptance, so that idle test could
not be called a pass. The observed failure was loss of the UU connection and
mapping, not bad SSH authentication. The user later reported that some UU
connections may have been closed manually, so this is **not proof of a
spontaneous timeout or a bridge bug**. No `.bashrc` reload can restore a missing
listener.

The actual Port Mapping panel was then inspected: its saved rule was correct
and enabled, but the connection had failed. Clicking its Retry Connection
button once displayed a modal saying the target was already controlled and
required takeover before port mapping could be used. Cancel preserved that
controller. This is evidence of the **current ownership conflict**, not proof
that it caused every historical disconnection. Distinguish closing a viewer,
disconnecting a device, closing the mapping panel, and simply minimizing it.
The panel's minimize/close lifetime behavior still needs controlled acceptance.

Prefer the direct UU route when that is the user's choice. A cloud jump host
must not silently replace it. A possible direct-only alternative is to reverse
which host owns the native mapping, then use one SSH return forward; validate
the chosen direction and avoid a second native rule on the return port.

### Safely inspecting the existing panel

The bridge intentionally restores relay focus once per second. Standard window
activation can therefore appear broken unless a short console-focus lease is
used. Do not stop the supervisor or create a competing desktop:

```bash
uu-remote-console focus-client
# Inspect the actual Port Mapping panel; cancel any takeover prompt.
uu-remote-console release-client
```

Always release the lease in an EXIT trap during automation. Record the original
active relay window as an additional restore fallback. The improved helper
ignores transient UU toasts and restores either the SDL/FreeRDP relay or the
existing loopback RealVNC relay. Its old SDL-only lookup could return nonzero
on VNC installations. The isolated tests cover both profiles and cleanup when
no relay is found; the live VNC release test returned success, left no lease,
and preserved the original active window. Only the helper script was deployed,
with a private backup; no desktop/runtime restart was needed. All 124 repository
tests passed after this focused correction.

The companion peer's separate `error=1113` Chinese input fault was repaired
through a semantic clipboard route while preserving its RDP desktop and
routine input path. That input repair does not imply that UU TCP mapping is
stable; see [the semantic-text diagnosis](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/semantic-text-and-clipboard.md).

## Quick use

Both Ubuntu bridges can use the same short entry point. Its behavior comes
from the peer profile: `terminal` selects native UU Terminal, while `ssh`
selects the strict `uu-PEER` OpenSSH alias. It never guesses or falls back:

```bash
uu-shell lab
uu-shell lab --session-id SESSION_ID
uu-shell --help
```

With a `terminal` profile, `uu-shell` asks for a fresh native shell by default.
With an `ssh` profile, arguments and exit status pass through to OpenSSH.
Neither mode silently runs desktop connect, mapping recovery, a retry loop, or
a cloud fallback. **An alias is not a transport fix**: the selected transport
still needs live identity and file-transfer acceptance. See the bridge's
[native terminal guide](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/native-ubuntu-terminal.md).

On the controller, after installing `scripts/uu-ssh` to `~/.local/bin/uu-ssh`:

```bash
uu-ssh add lab --port 22709 --user YOUR_REMOTE_USER
uu-ssh key
```

When a native UU host forwards to a different SSH server on its own LAN, make
the route and shell choice explicit. The example address is documentation-only:

```bash
uu-ssh add lab --port 22023 --user YOUR_REMOTE_USER --direct \
  --mapping-target 192.0.2.25 --shell-transport ssh
uu-ssh check lab
uu-shell lab 'hostname; id -un'
```

`--direct` removes an old SSH jump host from that profile. The mapping target
is diagnostic metadata; `add` does not create or modify the UU rule.

Open UU -> destination -> **Port mapping / 端口映射**. Add local TCP `22709`
to target `127.0.0.1:22`. Target localhost means the remote Ubuntu, not the
controller. Verify SSH host identity through a trusted channel before
accepting first-use trust, then authorize the public key:

```bash
ssh-copy-id -i "$HOME/.ssh/id_ed25519_uu_bridge.pub" uu-lab
uu-ssh check lab
ssh uu-lab
scp ./report.md uu-lab:Documents/
rsync -av ./notes/ uu-lab:Documents/notes/
```

`add` prepares persistent SSH configuration only; it does not create or turn
on the UU rule. No `.bashrc` reload is needed. Repeated setup preserves the key
and original SSH configuration. The helper refuses unrelated aliases and
keeps host-key checking enabled.

## Two directions without two UU control sessions

After one UU mapping and SSH authentication work, an optional reverse SSH
forward can carry the return connection:

```bash
# On controller A, leave this running:
uu-ssh reverse lab --listen-port 22999

# On B, prepare an alias and B's own key:
uu-ssh add server --port 22999 --user YOUR_USER_ON_A
uu-ssh key
```

Authorize B's **public** key on A, verify A's host fingerprint, then use
`ssh uu-server` on B. Confirm B's listener is loopback-only. The underlying
command is ordinary `ssh -NT -R 127.0.0.1:22999:127.0.0.1:22 uu-lab`.
Ctrl+C closes the forward without changing either desktop. See
[OpenSSH's forwarding documentation](https://man.openbsd.org/ssh).

This return topology was subsequently verified between both live hosts after
the existing mapping recovered. It still depends on UU and the SSH process.
No new monitoring loop, automatic restart service, router rule, or general VPN
was introduced. Keep one named tmux session for the forward if it must remain
running after closing the launching terminal. Record its owner, ports, and
command in the private handoff; never start a competing native UU mapping on
the return port.

For a persistent owner during the current login session, use one deliberate
tmux name and preserve a failed pane for inspection:

```bash
tmux new-session -d -s uu-ssh-lab-return \
  uu-ssh reverse lab --listen-port 22999
tmux set-option -w -t uu-ssh-lab-return:0 remain-on-exit on
tmux capture-pane -p -t uu-ssh-lab-return:0.0 -S -20
```

This owner survives closing the launching terminal but does not retry and is
not boot autostart. A missing listener therefore remains visible instead of
triggering hidden UU reconnect or takeover behavior.

After a transport drop, restore the native mapping first, inspect the owned
reverse process and listener, and restart only that forward if it exited.
`tmux set-option -w -t SESSION:0 remain-on-exit on` can retain its exit message
for diagnosis; it is not an automatic reconnect service. The full bridge guide
includes copy-safe tmux examples and the loopback/forwarding policy checks.

## Native UU Terminal is different

With a destination patched by this repository, the vendor **PowerShell**
terminal entry opens a native Ubuntu PTY login shell. The proxy/broker path
keeps UU's own authenticated transport; it does not SSH back into itself.
An older peer may support port-mapped SSH before its native terminal patch is
installed. Use its own controlled upgrade procedure and preserve its profile.

Keep the proven login-shell prompt behavior. Previous cosmetic `$`-wrapping
fixes moved locally echoed typing to the beginning of the line. Do not change
global Bash, input sources, RDP, or physical keyboard mappings for this.

## Handoff and safety lessons

- Share peer names, repo/source versions, expected ports, verified host-key
  fingerprints, and **public** login keys in a private operational handoff.
- Keep passwords, private keys, login tokens, raw GUI captures, and private
  account/device IDs out of public GitHub.
- Give each computer's agent ownership of its runtime update and rollback.
  The original Wayland/RDP profile and the workstation X11/VNC profile are
  both valid; do not replace one with the other indiscriminately.
- Confirm SSH transport, key authentication, terminal, desktop/input, and
  reconnect independently. A saved rule or “online” indicator is not proof
  of all of them.
- Check for control-takeover prompts and release temporary management-window
  focus before handing back. Preserve all active desktop windows.
- Test reboot persistence separately; this task did not reboot either host.

### Why configuring mapping temporarily affected input

On the peer using the RDP relay, its agent had intentionally focused UU's
management window. During that interval mouse events logged
`route=rdp focus=timeout result=0 error=21`: the broker could not safely deliver
them to `Ubuntu-Desktop-Relay`. Releasing that management-focus lease restored
the expected foreground window in both X11 and Wine. There was no reason to
change global keyboard layouts or restart the desktop for this evidence.

The log samples were historical, so they did not prove failure continued
after release. Isolated mouse, physical-symbol, phone-text, Chinese/emoji, and
long-text tests passed, and read-only foreground checks agreed. Actual user
click/typing acceptance was still pending at the time of this note. A working
SSH connection, a green verifier, and silence in an old log are not substitutes
for that real-client check.

Validation included six isolated helper tests (with real OpenSSH config
parsing) and the existing terminal acceptance test: token rejection, native
shell, exact Chinese UTF-8, runtime-file handoff, and `24x80` PTY sizing.

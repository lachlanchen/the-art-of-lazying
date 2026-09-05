# SSH through UU Remote between Ubuntu hosts

## Result and limitation

On 2026-09-05, UU's built-in TCP port mapping was tested from a Wine-hosted
Ubuntu controller to another Wine-hosted Ubuntu computer. A loopback port on
the controller reached the destination's native OpenSSH server, and a
dedicated Ed25519 key successfully authenticated as its Linux user.

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

## Quick use

On the controller, after installing `scripts/uu-ssh` to `~/.local/bin/uu-ssh`:

```bash
uu-ssh add lab --port 22709 --user YOUR_REMOTE_USER
uu-ssh key
```

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

This return topology was documented but not verified between both live hosts:
we deferred further testing when it would have required taking over the peer.
It still depends on UU and the SSH process. No new monitoring loop, automatic
restart service, router rule, or general VPN was introduced.

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

Validation included six isolated helper tests (with real OpenSSH config
parsing) and the existing terminal acceptance test: token rejection, native
shell, exact Chinese UTF-8, runtime-file handoff, and `24x80` PTY sizing.

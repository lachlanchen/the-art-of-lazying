# Cloud relay for independent two-way SSH

Status: design reviewed on 2026-09-05; **not deployed**. The existing UU route
and desktop services remain unchanged. No cloud purchase is authorized by
this plan.

## Recommended small design

For two computers, use ordinary OpenSSH rather than recreating a remote-desktop
product. Each computer opens one outbound reverse tunnel to a public Linux
server. An authenticated SSH jump connection accesses the other computer's
reverse listener. The cloud does not need the endpoints' SSH private keys.

```text
Ubuntu workstation -- outbound SSH --> public cloud <-- outbound SSH -- Ubuntu peer
                                        |
                              two private loopback ports
```

This avoids home-router port forwarding and UU desktop ownership collisions.
UU, RDP and VNC stay separate: closing a desktop viewer no longer controls
the SSH relay's lifetime. This is a service relay, not a shared Ethernet LAN
and not a complete replacement for UU's GUI/video features.

[OpenSSH supports RemoteForward and ProxyJump](https://man.openbsd.org/ssh_config).
Use one systemd-supervised connection per computer, explicit connect timeouts,
keepalives, `ExitOnForwardFailure`, a restart delay and controlled logging.
[systemd describes recovery after network loss](https://systemd.io/NETWORK_ONLINE/);
`network-online.target` alone is not continuing connectivity supervision.

Automatic reconnection restores availability for new connections, not a dead
interactive SSH session. Keep long-running remote work in tmux. The cloud is
still a shared failure point; no claim of uninterrupted service or reboot
persistence is valid until those acceptance tests have actually run.

## Security boundaries

- Keep the two remote-forward ports on cloud `127.0.0.1` with `GatewayPorts no`.
- Use separate restricted tunnel identities and keys for each computer. Limit
  remote listening with `PermitListen`; deny shell sessions, TTY, X11 and agent
  forwarding for these identities. Preserve the existing administrator login.
- Give the jump identity only the required direct-forward targets using
  `PermitOpen`. Do not broadly enable arbitrary forwarding on a shared account.
- Pin both the cloud's host key and each endpoint's distinct host-key identity.
  Keep endpoint private keys at their original endpoint/client, not on the relay.
- Permit only the reviewed public SSH ingress in the provider security group
  and OS firewall. Do not expose the internal reverse ports, VNC, RDP or CDP.
- If port22 is filtered, test2222 or a dedicated443 listener. Raw SSH on443 is
  not HTTPS and may still be filtered. Never displace an existing HTTPS service.

The exact policy must be validated against the installed OpenSSH version.
See [sshd_config](https://man.openbsd.org/sshd_config) for account-scoped
forwarding restrictions. A single blanket forwarding setting is not enough.

## Relation to LazyEdge

[LazyEdge](https://github.com/lachlanchen/LazyEdge) already uses an outbound
OpenSSH reverse tunnel under an explicit service policy. Its v0.4 application
gateway exposes approved HTTP host/method/path contracts; it is not a generic
SSH jump service. Reuse the transport design and operations discipline, not
the HTTP guards or a live application's port/identity/unit. No LazyEdge source,
deployment, firewall or existing service was changed for this proposal.

## Buying guidance, not a provider endorsement

A planning starting point for SSH-only use is a small Linux VM with around
1vCPU, 1–2GiB RAM and a modest system disk; no GPU is needed. Those are rough
resource estimates, not a verified provider SKU. Public reachability, reliable
routing to **both** computers and bandwidth matter more than extra CPU.
Bulk SCP/rsync throughput is limited by the slower path and relay bandwidth;
all file data passes through the relay and may incur provider traffic charges.

Confirm the exact provider and plan URL before purchasing. If the intended
provider is Huawei Cloud, its official
[EIP and security-group guidance](https://support.huaweicloud.com/eip_faq/faq_eip_0007.html)
describes external reachability. Do not assume a differently named provider
has the same plans or network behavior. Test the chosen region's route from
both networks before a long commitment; a cloud hop is not automatically
faster than UU's direct path.

## Commands installed now vs a later cutover

On the workstation, `ssh-uu-7090` is a persistent executable shortcut:

```sh
#!/bin/sh
# Convenience command only: retain the existing pinned SSH alias and transport.
# No UU takeover, tunnel restart, alternate route, or retry.
exec /usr/bin/ssh uu-7090 "$@"
```

It is at `~/.local/bin/ssh-uu-7090`; the directory was already in PATH.
The peer already uses `ssh-uu-lachlanserver`. Examples:

```bash
ssh-uu-7090
ssh-uu-7090 hostname
ssh-uu-7090 -G
scp file.txt uu-7090:/remote/path/
```

Shell syntax and `-G` resolved the same user, loopback22709, strict host key
and dedicated key as `ssh uu-7090`; an extra ConnectTimeout argument also
passed through correctly. No network connection is opened by `-G`, so that
check does not claim a fresh end-to-end session succeeded. The existing
mapping and owned return process were left running.

A future cloud deployment should first add distinct explicit aliases such as
`edge-7090` / `edge-workstation`. Only after both directions, file transfer,
restart recovery and concurrent desktop use pass should any default change.
Keep the UU aliases intact and do not add a silent cross-transport fallback.

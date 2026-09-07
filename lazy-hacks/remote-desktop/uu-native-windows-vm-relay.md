# Native UU Remote in a Windows KVM guest

## Update: two-way SSH verified on 2026-09-08

The ordinary UU account login was completed. A native mapping in the Windows
guest now reaches the other Ubuntu machine through a dedicated Mac on its LAN:

```text
Ubuntu A -> Windows VM SSH -> VM localhost:23709 -> UU -> Mac -> Ubuntu B:22
Ubuntu B localhost:22440 -> SSH return on that carrier -> Ubuntu A:22
```

This separates the carrier's UU device ownership from both Ubuntu desktops.
One existing return unit was reused, and existing host-key pins and user keys
were retained. The familiar `ssh-uu-*` aliases now use the verified route;
cloud routes remain independently named. The signed UU application's Windows
Firewall prompt was accepted inside the guest, with no host firewall changes.

Both hostnames and Chinese/Japanese shell output passed. A 42496-byte binary
and Unicode file survived an SCP round trip, and the peer initiated its own
successful return transfer. Exact command exit statuses were preserved.
Restarting only the return SSH service with no active return clients restored
the listener and login. Existing desktops and UU processes stayed running.

UU's normal Windows auto-start switch was already enabled. This is not a
reboot-reconnection test: the guest, dedicated Mac, logged-in UU clients and
saved mapping remain dependencies. The SSH unit retries only its own channel;
it never takes over a desktop or opens a vendor connection automatically.

An existing Windows guest can provide a separate native UU identity alongside
an Ubuntu Wine bridge. Install the official Windows client normally; preserve
the Ubuntu desktop, input broker, dictation, clipboard, RDP, and VNC settings.
No Linux compatibility patch belongs in this native Windows installation.

The tested 2026-09-07 installation used UU **4.39.2.1561**, verified with a valid
NetEase Authenticode signature and a recorded SHA-256. Its automatic Windows
service started without rebooting the guest. The GUI opened the normal account
QR login. Existing Windows application processes stayed alive.

The reusable [installer and full relay guide](https://github.com/lachlanchen/kvm-qemu-workstation/blob/main/docs/uu-native-relay.md)
live in `kvm-qemu-workstation`. The
[Ubuntu bridge's SSH guide](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/ssh-and-port-mapping.md)
explains the earlier mapping and takeover tests.

## Where the port lives

```text
Ubuntu SSH client -> Windows guest SSH -> Windows localhost mapping
                                              -> native UU -> remote SSH
```

A UU listener created inside the guest is **not** on Ubuntu's loopback.
`ProxyJump uu-vm` reaches the guest's local listener without a new public port,
QEMU forward, firewall rule, or forwarding daemon. Keep the destination's
verified SSH host key and authorized user key. Use one distinct port and
`uu-NAME-via-vm` SSH alias per mapped server. A convenience executable can use:

```sh
#!/bin/sh
exec /usr/bin/ssh uu-NAME-via-vm "$@"
```

File transfer remains normal OpenSSH:

```bash
ssh uu-NAME-via-vm hostname
scp ./example.txt uu-NAME-via-vm:~/
```

In the reference QEMU user network the guest can also reach the Ubuntu host's
SSH service at `10.0.2.2:22`. A controller on another computer can target the
guest's separate UU device and forward to that address. Its final SSH host key
must still identify Ubuntu. One working SSH carrier can support a reviewed
loopback reverse forward for the return direction, sharing its availability.

## What is still conditional

The VM needs its own ordinary UU login; never clone another installation's
authentication/device state. A saved alias does not open a vendor mapping.
The inspected UU CLI has terminal commands but no public mapping-management
command. Configure the rule in UU's actual Port Mapping panel.

A dedicated VM separates its UU device identity from the Ubuntu desktop.
It does not remove the remote target's control-ownership rules or guarantee
unattended reconnection. Keep working LazyTunnel SSH aliases intact; test
the new path before considering any switch. Port mapping forwards TCP services,
not an entire LAN.

At the initial installation checkpoint the guest login and UU mapping were
pending. The acceptance update above supersedes that status for the tested
two-way route. Reboot reconnection and arbitrary takeover survival still need
their own tests; automatic Windows service startup alone does not prove them.

If a Windows virtual display is active, a QEMU physical-console screenshot may
show an old frame. Use the guest's existing live VNC view instead of rebooting
or moving other applications. Reuse the project-owned view and respect its
input lease while presenting the QR login.

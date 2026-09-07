# Native UU Remote in a Windows KVM guest

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

At this checkpoint, installation, an SSH jump through Windows to a LAN peer,
and the host SSH banner from the guest were verified. The guest's UU login,
mapping creation, SSH through the UU carrier, and reboot reconnection were
still pending. Automatic Windows service startup alone does not verify these.

If a Windows virtual display is active, a QEMU physical-console screenshot may
show an old frame. Use the guest's existing live VNC view instead of rebooting
or moving other applications. Reuse the project-owned view and respect its
input lease while presenting the QR login.

# Independent SSH and noVNC access with LazyTunnel

The reliable boundary is the operating system's SSH connection, not a remote
control application's current desktop connection. Taking over a UU desktop or
closing an RDP window must not own the inter-computer SSH carrier.

The reusable implementation lives in [LazyTunnel](https://github.com/lachlanchen/LazyTunnel).
Read its [fleet installation and operations guide](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/fleet.md)
for the complete scripts, server/client lifecycle, enrollment and rollback.
Machine addresses, account names, host keys and credentials stay in private
operator records rather than this public note.

## Architecture

Each enrolled device has its own keys. New devices establish one native,
supervised outbound SSH connection to the cloud. The relay listens for those
connections only on loopback. Other clients first authenticate to a restricted
jump identity, then authenticate independently to the destination SSH server.

The cloud also offers a pinned SSH configuration registry. Its per-device
account runs one fixed read-only command and cannot forward ports or start an
arbitrary shell. A client can refresh its device list without receiving the
cloud administrator's private key or password.

Code and identity are stored separately. Server and client upgrades preserve
keys and the current connection. Registry updates can add devices without
changing a running carrier. The fleet uses a separate account namespace, so
older, already working carriers can be explicitly reused and remain running.

## Everyday commands

After the operator enrolls a client, its device aliases work consistently:

```bash
lazytunnel status
lazytunnel devices
ssh-lazy-alpha
ssh-lazy-beta hostname
scp-lazy ./example.txt lazy-beta:Downloads/
lazytunnel sync
```

These examples use placeholder peer names. `lazytunnel devices` prints the
actual configured commands. Windows also has `ssh-lazy-*.cmd` wrappers and a
PowerShell client. These wrappers do not replace unrelated system SSH aliases.

Initial installation and login use an administrator-reviewed public enrollment
packet and a private returned bundle. This is device enrollment, not a second
web-account/password system. Private keys are generated only on their device.
See the implementation guide for both operating-system command syntaxes.

## Boot persistence

- Linux: user systemd service with lingering when startup before login is wanted.
- macOS: LaunchDaemon running as the endpoint user, independent of GUI login.
- Windows: S4U scheduled task without a stored account password; one active SSH
  worker, one-minute failure restart, and a five-minute native scheduler retry.

No desktop was logged out or rebooted to install the fleet. Boot settings were
inspected, which is not the same as testing a reboot. A powered-off device,
pre-boot disk-encryption prompt, lost Internet connection or wrong firmware boot
selection still requires the corresponding system/network issue to be resolved.

## Forward an existing noVNC viewer

The same SSH route carries HTTP and WebSockets. On a Linux/macOS client:

```bash
lazytunnel web alpha 6144 --local-port 16144 --path /wecom
```

On Windows:

```powershell
lazytunnel web -Device alpha -Port 6144 -LocalPort 16144 -Path /wecom
```

Open `http://127.0.0.1:16144/wecom` on the client that runs the command. The
original service may also offer `/wechat` on the same port. If the viewer is
served by a VM's Linux host, use the host's device name rather than the guest's.
Closing this forwarding command stops its private listener only.

A persistent Linux `lazy-web` service can be reused for frequently used viewers.
Do not create a duplicate viewer stack or take over an occupied local port.
For a computer's own desktop, forward the existing shared-session noVNC service;
transport alone does not require another GNOME desktop or an RDP restart.
Cloud relay bandwidth limits GUI throughput even when SSH commands feel fast.

## What the live checks found

The seven-device deployment passed all 49 directed hostname checks, including
self-routes. Its platforms included Linux, macOS and native Windows. The two
existing Linux carrier processes stayed running through the expansion.

A Windows-specific issue required a scoped fix. Microsoft's OpenSSH could run
`hostname`, print the correct hostname, and then hang while closing a nested
proxy with captured output. Adding `-n` did not solve it. Git's OpenSSH completed
the same command normally. The new aliases use an existing Git runtime when
available; a minimal VM received only the verified SSH/Bash DLL dependency set
(about 16.4 MiB), not a replacement Windows SSH server or a full development SDK.

Tiny Windows also marked its administrator authorized-keys file read-only. The
installer preserves its ACLs and temporarily clears/restores that attribute
only while adding the reviewed keys. It never replaces the SSH authorization
file with a permissive one. Windows Task Scheduler rejected a 30-second restart
interval; the corrected one-minute setting and single-instance retry policy
were validated on the actual machines.

The WeChat/WeCom viewer test verified HTTP 200, WebSocket 101 and an RFB banner
through the new tunnel. A first raw WebSocket request without an `Origin` header
was correctly rejected by the viewer's same-origin protection. A browser-shaped,
view-only request passed. No authentication or input-lease checks were disabled,
and the temporary test forward was removed afterward.

One UU device advertised itself online but failed terminal initialization from
both Wine and a native Windows controller. Other listed devices were offline.
They remain pending; an online indicator is not proof of working SSH enrollment.
An intermittent cloud TCP timeout also occurred; the local cloud firewall had
no matching ban and direct connectivity later returned. No unproven network
root cause was claimed and no global routing changes were made.

## Private state and updates

Keep real configurations under the operating system's private state directory,
not inside Git. The client uses `~/.config/lazytunnel-fleet` (under the Windows
user profile there), and code lives separately under `~/.local/share/lazytunnel`.
The cloud stores its registry under `/var/lib/lazytunnel-fleet` and owned SSH
policy under `/etc/lazytunnel-fleet`.

```bash
# Run each update on the corresponding machine, using a reviewed checkout.
lazytunnel update --source /path/to/LazyTunnel
sudo lazytunnel-server update --source /path/to/LazyTunnel --apply
```

Refreshing routing with `lazytunnel sync` is separate from updating code. Keep
UU/RDP/VNC and the original administrator connection available during changes.
Revocation must remove both cloud authorization and destination login keys;
removing an alias alone is not revocation. Long-running shell work should use
tmux, since reconnecting a carrier cannot resurrect a shell lost in an outage.

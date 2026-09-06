# Open another computer's local websites through LazyTunnel

A website bound to `127.0.0.1` is local to its host. A browser on another
computer can access it through an authenticated SSH local forward without
changing the application to listen on the LAN or publishing its port.

```text
Browser on beta → beta loopback port
                → LazyTunnel end-to-end SSH
                → alpha loopback port → original web app
```

The [LazyTunnel helper and full guide](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/private-web.md)
provide temporary forwards, named persistent user services, remote LAN
targets and an opt-in SOCKS proxy.

From a LazyTunnel checkout, install on both endpoints:

```bash
install -D -m 0755 scripts/lazy-web "$HOME/.local/bin/lazy-web"
```

On beta, using alpha's actual peer name from the private LazyTunnel SSH config:

```bash
lazy-web start alpha-wechat alpha 6144
lazy-web status alpha-wechat
```

Open `http://127.0.0.1:6144/wechat` **on beta**. The same path now reaches
alpha's application. If beta already uses port 6144, choose another local
port using `--local-port 16144` and open that port instead. The helper refuses
to take over an occupied port or rewrite a differently configured service.

For temporary access in the opposite direction, run on alpha:

```bash
lazy-web run beta 3000 --local-port 13000
```

Access a router/device as seen from the peer's network:

```bash
lazy-web run alpha 80 --host 192.168.1.1 --local-port 18080
```

This is useful when both locations use the same LAN subnet: the target is
reached from alpha, not from the browser's local router. Local listeners stay
loopback-only. This is selected TCP forwarding, not a shared broadcast LAN.

For applications that support SOCKS5:

```bash
lazy-web socks alpha --local-port 1080
curl --noproxy '' --socks5-hostname 127.0.0.1:1080 http://127.0.0.1:6144/wechat
```

Explicitly proxied requests resolve targets from alpha. Browsers may exempt
localhost from proxying, so the named local forward is simpler for one app.
The helper changes no global proxy, DNS, default route or desktop service.

Persistent forwards use independent user systemd units and OpenSSH keepalives.
Matching starts preserve the PID; SSH exits trigger a retry after 15 seconds.
Underlying carriers, the remote SSH server and the app must remain available.
Existing connections can drop during an outage; reconnecting restores new
requests, not an interrupted response. Before-login startup depends on user
lingering, and enablement alone is not a reboot test.

```bash
lazy-web stop alpha-wechat
```

This stops/disables only that forward and keeps its saved configuration.

## Verified behavior

The September 2026 deployment returned HTTP 200 and identical page checksums
from both computers. A matching start preserved the SSH PID. A deliberately
ended web-forward process recovered automatically; the page worked again.
Reverse-direction HTTP and SOCKS requests returned a known test marker.
Temporary test servers and clients were stopped. No UU, RDP, VNC or original
carrier restart was needed, and no public application port was added.

Fresh cloud SSH connections initially timed out while an older carrier
remained connected. An explicit wired-interface probe succeeded, and ordinary
SSH subsequently recovered too. This did not establish a root cause, so no
permanent interface override or global routing change was made. An active
carrier process alone does not prove that new end-to-end sessions can open.

Protocol reference: [OpenSSH local/dynamic forwarding](https://man.openbsd.org/ssh.1).

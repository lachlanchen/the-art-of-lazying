# A small optional GUI for LazyTunnel

The console puts enrolled computers, copyable SSH commands and existing noVNC
viewers in one local browser interface. It keeps the cloud relay small and
leaves established SSH, UU, RDP and VNC services independent.

Source and full instructions:
[LazyTunnel GUI](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/gui.md).
This extends the [fleet SSH and noVNC deployment](lazytunnel-fleet-ssh-and-novnc.md).

## Install and open

On an enrolled Linux client with a reviewed updated checkout:

```bash
cd /path/to/LazyTunnel
python3 scripts/lazytunnel-client.py update --source .
lazytunnel gui install
lazytunnel gui code
lazytunnel gui
```

Open `http://127.0.0.1:17765`, then paste the code into the unlock form. The
installer adds **LazyTunnel** to the application menu and enables its own user
service. User lingering must already be enabled for startup before desktop
login. No browser is launched automatically at boot.

The GUI uses standard-library Python and static browser assets. It needs no
Docker, Node runtime, build pipeline, cloud GUI server or new desktop. Initial
idle memory use was about 13 MiB. Cloud bandwidth still limits desktop streaming.

## Daily use

**Computers:** search names or aliases, choose grid/list, copy an SSH command
and paste it into a terminal. Check a device or the fleet when needed. Checks
use pinned SSH and the fixed `hostname` command, four concurrent probes at most.
Results show the last check, not continuous presence monitoring. No automatic
SSH scan runs in the background.

**Desktop & web:** add the enrolled host actually serving noVNC or a web app,
its HTTP port, a free local port and its original path, such as
`/vnc.html?resize=scale`, `/wechat`, or `/wecom`. A VM viewer may be served by
the Linux host rather than the guest itself.

Saving a card does not connect. Start creates a separately supervised
`lazytunnel-web-gui-ID.service`. Open launches the existing viewer in a new tab.
The source desktop, viewer authentication and input-control lease are preserved.
No automatic preview stream or desktop takeover occurs.

An **existing local viewer** is a bookmark: no new forward and no Start/Stop
ownership. Multiple paths can share its port. Removing the card leaves its
application intact. Managed forwards must be stopped before removing their
card. Stop never touches another project's service, a carrier or source desktop.

## Remote browsers and operating systems

Loopback means the computer running the browser. A browser inside Ubuntu's
RDP/VNC desktop uses these links directly. A browser on another computer needs
authenticated forwards for the console **and** viewer ports, retaining the same
local numbers. For example, Windows can run each command in its own terminal:

```powershell
lazytunnel web -Device alpha -Port 17765 -LocalPort 17765
lazytunnel web -Device alpha -Port 6144 -LocalPort 6144 -Path /wecom
```

The full GUI control backend targets Linux/systemd. macOS can run the foreground
Python console for inventory, SSH checks and existing bookmarks; managed-forward
controls are disabled there. Windows retains its native CLI and uses a browser
through forwarding. No public mobile gateway, native Windows GUI service or
complete VPN is introduced. Direct phone-browser access requires authenticated
SSH forwarding; a phone viewing the remote desktop can use its browser as usual.

## Security and lifecycle

- The console binds only `127.0.0.1`, with a random private access code.
- No code or password appears in a URL, log or Git. The browser keeps its code
  in tab session storage; Lock clears it.
- APIs require the code, exact Host and same-origin checks. Mutations require
  small JSON requests. Unknown endpoints and arbitrary shell commands are refused.
- Targets must be enrolled; controls accept only generated GUI-owned service IDs.
- SSH keeps separate identities and pinned host keys. No public desktop port,
  firewall change, default-route change or wildcard listener is introduced.
- Local state refresh pauses when the browser is hidden. Desktop video opens
  only on demand, with the original viewer's authentication and control rules.

```bash
lazytunnel update --source /path/to/LazyTunnel
systemctl --user restart lazytunnel-gui.service
lazytunnel gui status
lazytunnel gui stop
lazytunnel gui rotate-code
lazytunnel gui code
```

Restarting/stopping the GUI leaves independent forwards running. Stop individual
forwards first if desired. Code updates preserve SSH keys, the access code and
saved viewers. Private state is in `~/.config/lazytunnel-fleet/gui/`; versioned
code is in the client release. Disabled generated units may remain as small
diagnostic artifacts after removing cards; they have no running listener.

## Lessons and evidence

1. Numeric device names are valid in the fleet. The initial GUI validator
   rejected them; it now follows the fleet contract, with a regression test.
2. `systemctl start` can return before the HTTP listener is ready. The optional
   installer now performs a bounded readiness check before reporting success.
3. A running SSH process does not guarantee remote VNC health. Label the state
   “Forward active” and retain the original viewer's connection errors.
4. Timed-out probes must terminate their own proxy process groups, rather than
   leaving children behind or affecting another project's SSH process.
5. Keep the GUI separate from forwarding. The live test retained the same
   noVNC-forward SSH PID through a GUI service restart.
6. A retired device's existing forward must remain stoppable, while a new Start
   must still require the destination to be enrolled.
7. Older client installers knew only their old file list. Bootstrap this upgrade
   using the new checkout's installer, so its GUI assets are included. The new
   updater delegates to the reviewed source installer for future module additions.

The browser acceptance run passed all seven SSH checks, grid/list/search, both
themes, a 390-pixel phone layout, bookmarks, Start/Stop/Remove and Lock behavior.
A noVNC HTTP request through another enrolled computer returned 200. Its test
forward was then stopped. Existing WeChat/WeCom bookmarks were retained, and the
original carrier, UU bridge and RDP processes were preserved. Startup was enabled
and inspected without rebooting; this is not a reboot test. Private host details,
codes, credentials, raw logs and real-device screenshots remain outside Git.

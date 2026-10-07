# Reliable shell shortcuts across a mixed computer fleet

LazyTunnel SSH and UU Remote Terminal are different transports. A device being
online in UU does not prove that its terminal protocol is compatible, and a
listening relay port does not prove that SSH authentication succeeds. Test a
real command with the source computer's own identity and a pinned destination
host key.

## Daily commands

After LazyTunnel enrollment and installation of the optional UU shell tools:

```sh
uu-shell --list
uu-shell lab
uu-shell lab hostname
uu-shell --lazy lab
uu-shell --native lab
ssh-lazy lab
```

`lab` is an example enrolled device name. The private profile chooses the
default transport. A LazyTunnel profile prints `uu-shell: LazyTunnel SSH -> lab`
on stderr before connecting. `--native` selects the actual UU terminal and
never falls back silently. Existing `ssh uu-DEVICE` aliases keep their original
port-mapping configuration; installing these shortcuts does not repair a lost
UU port mapping. Use the existing `scp-lazy` helper for file transfers.

The fleet route works independently of UU desktop control and does not need
another Windows computer to hold a port-mapping session open. It still depends
on the private cloud relay, its available bandwidth, and the destination being
online. It is not a virtual LAN or a guarantee of continuous availability.

## Reusable installation

The optional helpers are in the
[UU bridge repository](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/fleet-shell.md).
Run from that checkout on Linux or macOS:

```sh
python3 scripts/install-shell-tools.py
uu-ssh add-fleet lab --fleet-peer lab --device-id YOUR_UU_DEVICE_ID
```

The installer also accepts a reviewed private inventory via `--inventory`.
For Windows:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\install-shell-tools.ps1 -Inventory C:\private\peers.json
uu-shell lab hostname
```

The Windows invocation applies execution-policy bypass only to that process.
It does not weaken the machine policy. Windows uses the existing LazyTunnel
Git OpenSSH backend to preserve its verified nested-proxy shutdown behavior.
No Python, Wine, additional daemon, or copied private identity is required on
Windows. Linux and macOS helpers use an existing Python 3 interpreter.

Profiles live in `~/.config/uu-ssh/peers/`, and changed files are backed up under
`~/.local/state/uu-shell-tools/backups/`. Windows uses the corresponding paths
below `%USERPROFILE%`. The installer leaves carrier, desktop, keyboard,
dictation, clipboard, and vendor application settings alone. Restoring the
specific saved helper/profile is the rollback; no desktop restart is required.

## What was verified on 3 October 2026

Eight enrolled Linux, macOS, and Windows endpoints passed real hostname checks
on all 64 directed SSH routes, including eight self routes. The first sweep
passed 58 routes; six Windows-source routes exceeded a ten-second connection
deadline and passed with thirty seconds. Their command times were about
16–27 seconds. Other attempts also saw transient network timeouts, without an
established firewall or daemon failure. Keep these failed attempts in the
record instead of claiming the first sweep was flawless.

The `uu-shell` helper was also exercised from every source. Each source reached
the intended workstation and preserved both successful exit zero and deliberate
`exit 7`. Native UU tests were recorded separately:

The final post-update `uu-shell` sweep subsequently passed all 64 directed
hostname checks without retry. Most Linux/macOS/Tiny11 routes took 0.8–4.3
seconds; routes involving the physical Windows computer took roughly 10–25
seconds. That startup delay remains a performance limitation.

- One current Mac installation accepted a real fresh vendor terminal. A later
  attempt also encountered Streamer error 9012.
- Two older Mac installations returned `invalid open response`.
- Two Windows installations and one Ubuntu bridge rejected native terminal
  startup with `Client version too low`.
- Another online Windows device returned `invalid open response` and was not
  enrolled in LazyTunnel.
- Nine other devices were offline, so their terminal access was not verified.

Both Ubuntu PTY adapters returned their actual hostnames and Chinese text, but
the installed native proxy returned zero even after `exit 7`. That adapter
check does not establish vendor controller compatibility. Native macOS
`uuyc-cli term DEVICE_ID` opens a GUI terminal picker; a success acknowledgement
alone is not proof of an interactive terminal inside the calling shell.

These results do not establish that all native UU devices work. Keep native
compatibility errors visible, do not bypass vendor checks, and use the explicit
verified SSH route for normal shell work. Offline devices need to come online
before enrollment or acceptance can finish.

## Two operational repairs

LazyTunnel 0.3.2 permits an administrator-managed `connect_timeout` from five
to sixty seconds per source peer. This fleet uses thirty seconds for outgoing
hop, registry and endpoint session establishment. Carrier configuration remains
byte-for-byte unchanged; ordinary `lazytunnel sync` distributes the setting.
A longer deadline tolerates slow setup; it does not accelerate a slow network.

One Mac also had a working GUI-domain launchd carrier and a failed system-domain
job repeatedly trying to bind the same reverse listener. Only the confirmed
failed duplicate was unloaded. The live carrier PID stayed unchanged and the
system LaunchDaemon plist was retained for the next boot. No separate user
LaunchAgent file was present. This is not a reboot test.

The updated `lazytunnel boot` checks launchd domains before activating another
carrier. It refuses an existing duplicate, or preserves a legacy GUI/user job
while preparing system activation for the next boot. Do not copy an unload
command to another Mac without first identifying its healthy carrier owner.

The cloud and eight clients were updated through their existing SSH routes.
Self-update was checked twice against the same reviewed release, with private
identities and running carriers preserved. Native UU applications and accepted
desktop input patches were not replaced as part of this shell-tool update.

See the implementation and deployment notes in
[LazyTunnel](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/fleet-shell-checks.md).

## Recheck and safer diagnostics — 7 October 2026

The Ubuntu controller reached all eight enrolled endpoints in the first sweep;
the second Ubuntu also reached it in return. An interactive SSH PTY preserved
Chinese, Japanese, punctuation and an intentional `exit 7`. Later SSH probes
completed a binary SCP upload/download with matching SHA-256 checksums and
encountered intermittent connection delays and timeouts, then succeeded again.
The cause of those delays was not established. Healthy services and successful
rechecks are point-in-time evidence, not a promise of uninterrupted access.

Native UU session listing from the Linux/Wine CLI succeeded, but opening the
terminal on the second
Ubuntu failed with `Client version too low` (status 6). Both installations
reported 4.42.0.2770. Each local Linux terminal adapter passed its separate
UTF-8/symbol test. The rejection therefore preceded the working Linux shell;
the exact vendor compatibility condition remains unresolved. This CLI result
does not establish failure of every Windows/macOS/mobile GUI terminal client.
Keep the explicit
LazyTunnel default for ordinary shell work instead of restarting a healthy
desktop or treating that message as proof that the app must be upgraded.

The Linux/macOS shell tools now include:

```sh
uu-shell --list
uu-shell lab                 # selected profile transport
uu-shell --lazy lab          # explicitly choose enrolled LazyTunnel SSH
uu-shell --check lab         # bounded, noninteractive SSH health check
uu-shell --native lab        # explicitly choose the vendor terminal
scp-lazy ./example.txt lazy-lab:example.txt
scp-lazy lazy-lab:example.txt ./returned-example.txt
```

Replace `lab` with the enrolled peer name. Run `uu-ssh check lab` as an equivalent
health check. No `.bashrc` reload is required when installed helpers are updated.
The health check now handles timeout and Ctrl+C without a traceback or abandoned
nested SSH proxies. It stops only its own process group; interactive shells,
carriers and desktops stay running. This corrects diagnostic cleanup, not the
underlying network or vendor compatibility gate. Tests cover a child ignoring
SIGTERM, an unrelated process that must survive, cancellation and SSH status 7.

Refresh only the shell tools from the reviewed bridge checkout:

```sh
python3 scripts/install-shell-tools.py
```

Private backups are under `~/.local/state/uu-shell-tools/backups/`. This installer
does not restart UU, alter accounts or input patches, or rewrite the accepted
desktop runtime's source fingerprint. Native vendor terminal and local Linux
adapter acceptance must still be tested separately.

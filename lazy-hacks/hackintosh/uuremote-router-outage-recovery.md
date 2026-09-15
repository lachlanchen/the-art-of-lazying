# UU Remote Recovery After a Router Outage

Verified on 2026-09-15: OptiPlex 3040 on Monterey, with a 7050 peer on Sequoia.
UU Remote on the 3040 was version 4.35.0. This is a network/service repair,
not an EFI, graphics, or macOS upgrade procedure.

## What Failed

The shared router answered ping but stopped serving DHCP and completing SSH
or web-management requests. A user power cycle restored DHCP and Internet.
Neither Mac needed a reboot: their uptimes were approximately 46 and 29 days.
The Ubuntu workstation stayed online through an independent Tao connection.

The 7050's UU service recovered. The 3040's did not:

1. The main UU app retained sockets bound to the previous LAN address and
   had no established server connection. Restarting only that app restored
   its own server connection.
2. The background `UURemoteService` / `UURemoteServer` still had no established
   TCP connection. The main CLI misleadingly reported connected, XPC running,
   and logged in, while the 7050's UU device list still marked 3040 offline.
3. With `uuyc-cli device status` reporting no active connections, restarting
   the existing vendor GUI agent restored the server's connection. The 7050's
   device list then marked the 3040 online. Its daemon and account were retained.

Use the signed vendor CLI and launchd services, not new authentication patches
or deleted account state. Never publish raw device lists, access codes, tokens,
or unredacted UU logs in a support note.

## Watchdog Defect and Fix

The old watchdog used `/dev/console` ownership as its only console-user test.
On the affected machine it returned `root`, while SystemConfiguration reported
the real logged-in primary user and that user's GUI launchd domain existed.
The watchdog log had consequently stayed at `waiting-for-aqua` since August 15.
The reason for the stale device-node ownership itself was not established.

The new [console helper](scripts/macos-console-user.js) calls Apple's
[SCDynamicStoreCopyConsoleUser](https://developer.apple.com/documentation/systemconfiguration/scdynamicstorecopyconsoleuser%28_%3A_%3A_%3A%29)
through the built-in JavaScript/Objective-C bridge. It does not scrape a nested
`scutil` dictionary or require Python, Node.js, or Xcode on the Mac. The API
describes the primary console, not another user switched into the background.

The helper rejects empty, root, loginwindow, setup-user, malformed, and failed
lookups. The root watchdog bounds the lookup to five seconds and verifies the
resolved user's GUI domain. Its installer and audit use the same helper.
No `/dev/console` ownership, auto-login setting, TCC grant, account token,
vendor plist, or OS security policy is changed by this fix.

The healthy state now also requires an established TCP connection in the
actual UU agent/server processes. A connected main app alone no longer counts
as a healthy controlled host. This reflects the observed 4.35 transport; future
vendor transport changes must be reviewed before assuming an idle host always
has a TCP control connection.

Existing repair protections remain: boot grace, consecutive failures, external
Internet validation, signed vendor binaries, and active-session protection.
This is best-effort recovery, not a guarantee of uninterrupted sessions. An
unknown CLI state and future protocol changes still require diagnosis, not
arbitrary process-killing loops.

## Install or Update

Keep these three companion files together, then run as the logged-in user:

```bash
bash scripts/install-macos-uuremote-unattended.sh audit
bash scripts/install-macos-uuremote-unattended.sh install UU-UNATTENDED-STARTUP
```

Companions are `install-macos-uuremote-unattended.sh`,
`macos-uuremote-unattended-watchdog.sh`, and `macos-console-user.js`.
The installer retains root-only backups under
`/var/backups/macos-uuremote-unattended-TIMESTAMP/`. The installed JS helper is
root-owned and read-only to other users. The existing launchd watchdog runs
every 30 seconds and survives reboot. The vendor app is not reinstalled.

## Targeted Recovery

Check the real console user and active connections before restarting anything:

```bash
osascript -l JavaScript /usr/local/libexec/macos-console-user.js
/Applications/UURemote.app/Contents/Helpers/uuyc-cli status
/Applications/UURemote.app/Contents/Helpers/uuyc-cli device status
lsof -nP -a -c UURemote -iTCP -sTCP:ESTABLISHED
```

If the current user's host agent is stuck, Internet works, and there is no
active session, restart only that user's existing vendor job:

```bash
launchctl kickstart -k "gui/$(id -u)/com.netease.uuremote.agent"
```

This interrupts UU for that session, so do not use it as an ordinary status
check. Do not restart WindowServer, log the user out, or reboot macOS to repair
a host-agent connection. Check online status from another trusted UU client;
local CLI success alone was insufficient in this incident.

## Acceptance

- Both Macs reached multiple HTTPS sites and answered key-only SSH and VNC.
- Both Macs could SSH back to Ubuntu without passwords.
- 3040's agent restart changed its peer-observed UU state from offline to online.
- The updated watchdog, running as root, reported the correct console user,
  connected CLI, one established host-agent connection, and zero failures.
- A later peer check still reported online after watchdog installation.
- Shell syntax passed on Linux and macOS. The Node-based development test
  `node scripts/test-macos-console-user.cjs` passed for normal users, no user,
  reserved users, malformed output, API failure, and watchdog health wiring.
  Node is only a development test dependency, not a Mac runtime dependency.
- No reboot or artificial outage was injected after installing the fix. A new
  mobile control session still needs operator verification; online status is
  not an end-to-end keyboard/mouse test.

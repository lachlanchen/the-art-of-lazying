# New Mac: LazyTunnel first, then the physical desktop

Validated on an Apple Silicon Mac with native macOS, September 2026. The key
lesson was to distinguish authentication, tunnel transport, power management,
desktop permission and viewer keyboard mapping instead of treating them as one
remote-access failure.

## SSH and fleet enrollment

An SSH agent with many identities can exhaust the server's authentication
attempts before it offers the correct key. Verify the Mac's host fingerprint,
install a dedicated public key, and scope `IdentitiesOnly yes` to that host.
Do not disable host verification or weaken the server's authentication limit.

Generate LazyTunnel's role keys on the new Mac. Give only the public enrollment
packet to the relay operator, activate the returned bundle, and install its
system LaunchDaemon with `lazytunnel boot`. Existing devices need `lazytunnel sync`
to receive the new alias and authorize its endpoint login key. Use the installed
`ssh-lazy-DEVICE` wrapper on Windows, not a replacement native SSH invocation:
the wrapper may deliberately use Git OpenSSH for nested ProxyCommand support.

A clean Mac's `/usr/bin/python3` can be only a developer-tools stub. Validate it
by executing `--version`. The LazyTunnel POSIX installer was fixed to retain its
actual working Python interpreter, with correct shell quoting. Python.org's
signed native installer works without downloading all of Xcode.

See the complete [LazyTunnel Mac enrollment guide](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/macos-new-device.md).

## The unexpected network failure was sleep

LAN SSH sometimes responded while Internet downloads and the reverse SSH tunnel
stalled. Changing interface preference, packet marking and MTU did not establish
the root cause. `pmset -g log` exposed repeated `Maintenance Sleep` and
`DarkWake from Deep Idle` cycles. An idle sleep timer of zero was not sufficient.
After a full wake, all seven existing fleet peers passed bidirectional SSH checks.

For this dedicated remote-access desktop, system sleep was explicitly disabled:

```sh
sudo pmset -c sleep 0
sudo pmset -a disablesleep 1
pmset -g
```

`SleepDisabled 1` should be visible. This prevents manual system sleep too; it
does not disable lock-screen authentication, reboot, shutdown or FileVault.
Display sleep remains enabled. Original MTUs and wired-first service order were
restored. Undo with `sudo pmset -a disablesleep 0`, then restore the original
idle timer. Do not blindly apply an always-on policy to battery-powered laptops.

LazyTunnel also gained an opt-in per-device `ip_qos` transport setting (`none` or
`cs0`). It changes no other peer's output and is not a substitute for resolving
sleep. Never silently replace a running carrier during configuration migration.

## Sharing the existing Mac desktop

### October 4: lower source resolution and adjustable viewer quality

The working Mac mini desktop was reduced from **1920×1080 to 1600×900 at
60 Hz**. This is a real framebuffer reduction, not browser zoom: there are
30.6% fewer pixels in a full frame. Actual traffic depends on encoding and
screen changes, so this is not a measured 30.6% bandwidth reduction. The
supported mode was enumerated first, the original mode recorded, and the
new pixel dimensions verified. macOS saved the setting; no logout, reboot,
Screen Sharing restart, or application closure was performed. The existing
Remmina viewer and SSH carrier remained running. Boot persistence was not
tested with a reboot.

This changes the physical/shared Mac display for all its viewers. Restore
1920×1080 in **System Settings → Displays** when full resolution is wanted.
The operator also retains a private, host-scoped restore helper. Do not add a
background resolution enforcer: respect later manual display choices.

LazyTunnel 0.3.3 additionally supplies **Data saver / Balanced / Sharper /
noVNC settings** presets in its optional noVNC data-saver bar. They negotiate
JPEG quality and compression on the existing socket, remember a browser's
selection, and preserve advanced settings. The default is Balanced (quality
5, compression 6); Data saver uses 2/7, and Sharper uses 8/2. The native Remmina
viewer does not acquire these browser controls; its source pixel reduction
above is independent of them.

The managed Mi10 noVNC web root was updated in place without restarting its
websockify process or phone desktop. An old browser tab needs one reload to
load the new controls. Hidden and idle pause remain available, with explicit
Resume; the viewer can always reconnect. Existing remote keyboard, mouse and
clipboard code was not modified.

Validation included a real noVNC client negotiating encoding requests against
a disposable RFB server, preference persistence, custom advanced settings,
idle/hidden socket closure, and a read-only live Mi10 connection that was
closed after verification. All eight client code updates and repeated
self-updates passed identity checks; the server code update preserved SSH
policy and its running daemon. No unrelated browser or desktop was closed.

See [LazyTunnel bandwidth guidance](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/bandwidth.md)
for encoding limits, source-resolution tradeoffs, installation and rollback.

Enable **System Settings > General > Sharing > Screen Sharing**, permitting only
the intended user. Current macOS requires that initial GUI consent for control;
starting a service through SSH is not equivalent. Keep the original console and
use Screen Sharing/VNC, not a new XRDP login session.

An Ubuntu loopback-only forward can use the existing fleet identity:

```sh
lazy-web start mac-mini-vnc lazy-mac-mini 5900 \
  --ssh-config "$HOME/.config/lazytunnel-fleet/ssh_config" --local-port 15908
```

Connect Remmina using VNC to `127.0.0.1:15908`. This is not an HTTP endpoint,
even though the generic forwarding helper prints an HTTP-shaped address.
Keep VNC authentication. A saved profile and listening forward do not prove
that Screen Sharing is enabled or that the desktop can be controlled.

When both computers are on the same LAN, avoid sending desktop traffic through
the Internet relay unnecessarily. Keep the fleet profile as an away-from-LAN
fallback, and add a direct SSH forward using the Mac's pinned mDNS SSH alias:

```sh
lazy-web start mac-mini-vnc-lan mac-mini 5900 \
  --ssh-config "$HOME/.ssh/config" --local-port 15909
```

Use a second Remmina VNC profile for `127.0.0.1:15909`. Both forwards remain
loopback-only and encrypted; neither requires public VNC. The local shortcut now
prefers this LAN profile. On September 27, the relay profile had long black or
stale-frame intervals despite successful authentication; the direct LAN profile
displayed and controlled the desktop promptly. This isolates a useful workaround,
not a proven underlying relay-network diagnosis. Do not reset the Mac's privacy
permissions, log out its console, or restart working UU just for that symptom.

## Modifier keys in Remmina

For Ubuntu viewing a Mac, configure `~/.config/remmina/remmina.keymap`:

```ini
[Mac Physical Keyboard]
Alt_L = Meta_L
Alt_R = Meta_R
```

In only the Mac VNC profiles, set `keymap=Mac Physical Keyboard` and
`keyboard_grab=1`. This targets Alt as Option, Super/Windows as Command, and
leaves Ctrl as Control. macOS application copy/paste generally uses Command,
not Control. Ctrl-C remains appropriate for terminal interrupts. F1-F12 are not
remapped. Physical Fn/media-key handling can still be intercepted locally.

**September 27 correction:** the original example additionally mapped
`Super_L = Alt_L` and `Super_R = Alt_R`. Remove those two lines. In
[Remmina 1.4.43's VNC key handler](https://gitlab.com/Remmina/Remmina/-/blob/v1.4.43/plugins/vnc/vnc_plugin.c),
the saved, already-mapped key value can be mapped a second time on release.
`Super -> Alt -> Meta` therefore risks releasing a different key from the one
pressed. The two-entry map above is idempotent and leaves Super's native Command
behavior intact. Avoid reciprocal maps that have the same double-mapping problem.

Remmina's default host key is Right Ctrl, which it reserves for its own commands.
This workstation uses **Pause** instead (`hostkey=65299` and
`shortcutkey_grab=65299` in `remmina.pref`). This changes all Remmina connections;
record the original values before changing them. Pause+Pause toggles grabbing;
the toolbar remains available on keyboards without Pause.

Keep the normal desktop backend by default. `GDK_BACKEND=x11` was useful for
injecting diagnostic test keys, but a later cold-start check on this Ubuntu
Wayland workstation left X11 connection windows unmapped before VNC even opened
a socket. Native Wayland promptly connected and displayed the Mac mini desktop.
The temporary X11 launcher/autostart overrides and XWayland grab allowlist entry
were therefore removed. The keymap and Pause host-key fixes remain. Do not make
an X11 workaround permanent without testing repeated cold launches. GTK warnings
alone do not prove the cause of a blank screen.

Back up profiles first. Reconnect to load profile changes; restart Remmina when
convenient if its keymap table was already loaded. Do not terminate an active
desktop connection merely to apply this preference. Verify shortcuts interactively
before claiming every modifier or function key works. The mapping mechanism is
documented by [Remmina](https://remmina.gitlab.io/remminadoc.gitlab.io/md__builds__remmina_remmina-ci__remmina_8wiki_vnc-key-mapping-configuration.html).

Acceptance on September 27 used the bounded
[modifier observer](../../../scripts/networking/macos-modifier-probe.py) over SSH
while a saved Remmina profile had focus under the diagnostic X11 backend.
Left/right Ctrl, left/right Alt,
left/right Super, and F5 each produced the expected macOS state and returned to
all-false on release on the Mac mini, 7050 and 3040. The observer records no typed
text and installs no background service. This does not test every application
shortcut or an upstream phone/UU client's hardware-key interception. The Mac mini
then also passed the same modifier/F5 check with native Wayland, using a bounded
Linux uinput test keyboard (python-evdev) rather than X11-only synthetic events.
The temporary test devices were closed, not installed as background services.
Repeat the physical-key test when changing GNOME shortcut-inhibition settings.

```sh
ssh YOUR-MAC /path/to/working/python3 - < scripts/networking/macos-modifier-probe.py
```

Focus a harmless window in the VNC desktop and press/release the test keys during
the 25-second observation. Do not test shortcuts against unsaved work. In Mac
applications, Windows/Super+C is Command+C; Ctrl+C is still Control+C.

## Native UU on Apple Silicon

The official NetEase Mac 4.42.0 package contains both arm64 and x86_64 code and
installed on this Mac without Wine, Rosetta or a binary patch. Obtain installers
only from [NetEase](https://uuyc.163.com/), not lookalike UU download sites.

```sh
pkgutil --check-signature /path/to/vendor-installer.pkg
codesign --verify --deep --strict /Applications/UURemote.app
/usr/local/bin/uuyc-cli status
```

The installer supplies the native app, launch agent, daemon and CLI. Login,
Accessibility and Screen Recording consent are still required. Never copy another
Mac's login database or edit TCC to bypass consent. A running XPC service and
`networkStatus=connected` prove app startup, not end-to-end screen/control success.

## Multi-interface hostname caveat

Multi-interface caveat: a `.local` name can resolve to a Wi-Fi address on a subnet
the viewer cannot reach, even while wired SSH works. This occurred later during
Mac mini setup. The LAN forward now uses `mac-mini-wired`, an explicit current-LAN
Ethernet alias with the same identity and strict host-key pin; port 15909 and the
Remmina profile did not change. Keep the hostname and relay aliases, but do not
claim an IP-based alias follows DHCP changes. Revalidate the address after a
router move. No default routes or Mac remote-access services were modified.

## Keep a development Mac's iCloud footprint restrained

Check **System Settings > Apple Account > iCloud > Drive > Optimize Mac Storage**
and, separately, **Photos > Settings > iCloud > Optimize Mac Storage**. Avoid
**Download Originals to this Mac** for a development-only workstation unless an
offline photo library is intentional. Both optimization settings were already
enabled on the new Mac; inspection did not require changing or deleting cloud data.

Later on September 27, the user explicitly chose to disable Photos on this Mac.
In **Photos > Settings > iCloud**, unchecked **iCloud Photos**, selected
**Remove from Mac**, and confirmed the removal of local low-resolution copies.
The confirmation explicitly said full-resolution versions remain in iCloud.
Also unchecked **Shared Albums** locally to stop that separate photo feed.
Both checkboxes were visually verified off. No cloud library was deleted, no
Apple Account was signed out, and Drive optimization and other iCloud services
were left unchanged. Existing local cache files may take time to be reclaimed;
do not delete the library manually or promise a zero-byte Photos footprint.

Optimization is not a strict disk quota or bandwidth cap. Apple can still retain
local content and download thumbnails, metadata and recently used items. A strict
no-photo-download policy requires turning off **Sync this Mac** for Photos on
this Mac only after confirming the user's preference. Do not use **Turn Off and
Delete from iCloud**. Do not sign out of the Apple Account or disable Passwords,
Find My, App Store or developer account access as a storage workaround.

Keep source checkouts, robot datasets, build products and virtual environments in
local folders such as `~/Projects` and `~/RobotData`, outside iCloud Drive and any
synced Desktop/Documents folders. Do not automatically move existing projects.
Use Finder's **Remove Download** for verified cloud-backed files rather than
deleting them; cloud deletion propagates. Do not kill cloud daemons or repeatedly
scan the whole iCloud tree while its initial metadata sync is in progress.

References: [Apple Photos optimization](https://support.apple.com/guide/photos/phta9b4673b4/mac),
[turn off Photos on one device](https://support.apple.com/en-ie/102179),
[iCloud Drive downloads](https://support.apple.com/guide/mac-help/mchl1a02d711/mac).

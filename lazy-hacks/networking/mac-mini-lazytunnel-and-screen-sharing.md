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

## Modifier keys in Remmina

For Ubuntu viewing a Mac, configure `~/.config/remmina/remmina.keymap`:

```ini
[Mac Physical Keyboard]
Alt_L = Meta_L
Alt_R = Meta_R
Super_L = Alt_L
Super_R = Alt_R
```

In only the Mac VNC profiles, set `keymap=Mac Physical Keyboard` and
`keyboard_grab=1`. This targets Alt as Option, Super/Windows as Command, and
leaves Ctrl as Control. macOS application copy/paste generally uses Command,
not Control. Ctrl-C remains appropriate for terminal interrupts. F1-F12 are not
remapped. Physical Fn/media-key handling can still be intercepted locally.

Back up profiles first. Reconnect to load profile changes; restart Remmina when
convenient if its keymap table was already loaded. Do not terminate an active
desktop connection merely to apply this preference. Verify shortcuts interactively
before claiming every modifier or function key works. The mapping mechanism is
documented by [Remmina](https://remmina.gitlab.io/remminadoc.gitlab.io/md__builds__remmina_remmina-ci__remmina_8wiki_vnc-key-mapping-configuration.html).

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

# Click-to-open private VNC for an XRDP desktop

## Outcome

This setup gives a Mac relay one application icon that opens VNC to an
already-running Ubuntu XRDP/Xorg desktop. It was verified on 2026-07-15 with:

- the Ubuntu desktop at a true `1620x1080` framebuffer
- `Ctrl` and `Shift` arriving correctly through VNC
- the Ubuntu XRDP-only XKB profile remaining
  `applealu_jis` + `jp` + variant `mac`
- no VNC listener exposed to the LAN or Internet
- RealVNC Viewer scaling the full desktop to the Mac window without changing
  the server resolution

The practical path is:

```text
MacBook keyboard
  -> remote-control software
  -> Mac relay
  -> clickable app
  -> SSH tunnel on localhost:5922
  -> x11vnc on Ubuntu localhost:5922
  -> existing XRDP Xorg display
```

This route was chosen because Windows App for macOS could not preserve every
kind of key through the nested remote-control chain:

- Unicode mode restored printable shifted symbols, but `Ctrl` shortcuts did
  not arrive reliably.
- Scancode mode was tested again after upgrading Windows App, but `Shift+7`
  still arrived as plain `7`.
- VNC preserved both ordinary modifiers in the real typing test.

Windows App can still be used briefly to create the XRDP/Xorg session after an
Ubuntu reboot. Daily interaction then moves to VNC.

## Security model

The Ubuntu helper starts `x11vnc` with all of these properties:

```text
-localhost -nopw -forever -shared
```

`-nopw` is acceptable only because `-localhost` binds the VNC server to
`127.0.0.1` and `::1`; it is not reachable directly from another machine. The
Mac reaches it through an authenticated SSH local-forward. Do not remove
`-localhost` unless VNC authentication and a firewall are added first.

The local TCP port is `5922`. RealVNC's command-line notation treats that as
display number `22`, so the Viewer target is:

```text
127.0.0.1:22
```

## Ubuntu-side helper

Install the small runtime packages:

```bash
sudo apt install x11vnc freerdp3-x11 xvfb libsecret-tools
```

Install the reusable helper:

```bash
install -Dm700 \
  scripts/xrdp-vnc-bridge.sh \
  "$HOME/scripts/xrdp-vnc-bridge.sh"
```

The helper is idempotent and supports:

```bash
~/scripts/xrdp-vnc-bridge.sh start
~/scripts/xrdp-vnc-bridge.sh status
~/scripts/xrdp-vnc-bridge.sh resize
~/scripts/xrdp-vnc-bridge.sh restart
~/scripts/xrdp-vnc-bridge.sh stop
```

Its defaults are:

```text
localhost VNC port: 5922
XRDP framebuffer:   1620x1080
```

They can be overridden without editing the script:

```bash
XRDP_VNC_GEOMETRY=1920x1080 ~/scripts/xrdp-vnc-bridge.sh start
XRDP_VNC_BRIDGE_PORT=5923 ~/scripts/xrdp-vnc-bridge.sh start
XRDP_VNC_AUTO_RESIZE=0 ~/scripts/xrdp-vnc-bridge.sh start
```

### Store the resize credential safely

`xorgxrdp` accepts screen-size changes from an RDP client, not from ordinary
`xrandr --fb` requests. The helper therefore makes a short local FreeRDP
reconnection, asks XRDP for the target size, then terminates that temporary
client. The existing desktop stays alive.

Store the XRDP account password in the user's GNOME login keyring. The value is
read silently, is not placed in shell history, and is never passed in the
FreeRDP argument list:

```bash
read -rsp 'XRDP password: ' XRDP_SECRET
printf '\n'
printf '%s' "$XRDP_SECRET" | secret-tool store \
  --label='XRDP VNC resolution bootstrap' \
  application xrdp-vnc-bridge \
  account "$USER"
unset XRDP_SECRET
```

The login keyring must be unlocked. A normal password-based graphical login
usually unlocks it. If it is locked, the helper deliberately keeps VNC running
at the current size and prints a warning instead of embedding the account
password in a file.

FreeRDP may replace the X keyboard map during its short reconnect. The helper
therefore reapplies `~/scripts/set-xrdp-japanese-mac-keyboard.sh` after every
resize and verifies the final framebuffer size.

Useful checks are:

```bash
~/scripts/xrdp-vnc-bridge.sh status
ss -ltnp | grep ':5922'
DISPLAY=:10 XAUTHORITY="$HOME/.Xauthority" xdpyinfo | grep dimensions
```

The listener should show only `127.0.0.1:5922` and `[::1]:5922`.

## Mac relay launcher

The reusable launcher is:

- [scripts/macos-ssh-tunneled-xrdp-vnc.sh](./scripts/macos-ssh-tunneled-xrdp-vnc.sh)

Install it on the Mac relay:

```bash
mkdir -p "$HOME/scripts"
install -m 700 macos-ssh-tunneled-xrdp-vnc.sh \
  "$HOME/scripts/ubuntu-vnc.sh"
```

Set its `remote` default to an SSH host alias, or export
`UBUNTU_VNC_SSH=user@ubuntu-host`. Key-based SSH must already work in batch
mode.

The launcher:

1. asks the Ubuntu helper to start or reuse the localhost VNC bridge
2. asks it to enforce the configured framebuffer size
3. starts or reuses the SSH local-forward
4. opens RealVNC Viewer, or activates the existing matching connection
5. uses `Scaling=FitAutoAspect` and keeps `DynamicResolution=0`

The last point is intentional: Ubuntu owns the true `1620x1080` framebuffer;
Viewer only fits that desktop cleanly into its Mac window.

The launcher also uses an atomic operation lock and matches Viewer processes by
the exact localhost display target. Rapid repeated clicks therefore serialize:
the first click opens the connection and later clicks activate it. If stale
duplicates are already present, it keeps one and closes only the duplicates.
The `stop` action closes matching Viewer processes before stopping the SSH
tunnel and localhost Ubuntu bridge. It does not touch XRDP or the desktop.

### Build clickable macOS apps

Create a start AppleScript:

```applescript
on run
    try
        do shell script "/Users/USER/scripts/ubuntu-vnc.sh start"
        display notification "The private SSH tunnel is ready." with title "Ubuntu VNC"
    on error errorMessage number errorNumber
        display dialog "Could not open Ubuntu VNC." & return & return & errorMessage buttons {"OK"} default button "OK" with icon stop
    end try
end run
```

Create a stop AppleScript by changing `start` to `stop`. Compile them with
Script Editor or `osacompile`, place both apps under `~/Applications`, and put a
symlink or alias to the start app on the Desktop.

On the verified relay, the resulting applications are:

```text
~/Applications/Lachlanserver VNC.app
~/Applications/Lachlanserver VNC Stop.app
~/Desktop/Lachlanserver VNC.app
```

The start application can also be pinned permanently to the macOS Dock. Back
up `~/Library/Preferences/com.apple.dock.plist`, add the application URL to the
Dock's `persistent-apps` array, and restart only the Dock process with
`killall Dock`. This does not log out, reboot, or interrupt the remote Ubuntu
desktop. The verified relay keeps this Dock entry:

```text
file:///Users/USER/Applications/Lachlanserver%20VNC.app/
```

The simpler manual equivalent is to open the app once, right-click its Dock
icon, and choose **Options -> Keep in Dock**.

## How to use it next time

1. After an Ubuntu reboot, make sure one XRDP/Xorg desktop exists. If none
   exists yet, log in once through XRDP and disconnect; do not use that route
   for normal typing.
2. On the Mac relay, click `Lachlanserver VNC` in the Dock, or double-click the
   Desktop app.
3. Work in the VNC window. `Ctrl`, `Shift`, and the configured Ubuntu keyboard
   map remain usable there.
4. Double-click `Lachlanserver VNC Stop.app` when the private tunnel is no
   longer needed.

No reboot, logout, public VNC port, or background monitoring loop is required.

### When RDP is the primary connection

Do not leave multiple VNC Viewer connections open while an RDP client is also
driving the same XRDP/Xorg display. On the verified workstation, two Viewer
processes plus one live RDP connection briefly made X11 queries time out and
drove GNOME Shell and Xorg CPU sharply upward. Closing both Viewer processes
and stopping only the VNC tunnel/bridge left RDP connected; the display then
answered X11 checks in approximately `4-8 ms` and became responsive again.

Use the Dock start app only when VNC is needed. When returning to RDP, run the
stop app. No permanent monitoring loop is used.

## Troubleshooting

### The launcher says no XRDP Xorg display exists

XRDP display numbers such as `:10` are allocated only after login. Create one
XRDP/Xorg session once, disconnect it without logging out, and click the VNC
launcher again.

### The VNC image is too small or blurry

Check the server framebuffer first:

```bash
~/scripts/xrdp-vnc-bridge.sh resize
~/scripts/xrdp-vnc-bridge.sh status
```

The status should include `resolution=1620x1080`. If it does, leave RealVNC
Viewer at `FitAutoAspect`; changing Viewer zoom does not increase the Ubuntu
desktop's real resolution.

### Resize reports a locked keyring

Unlock the GNOME login keyring once in the graphical session, or log in through
the normal password-authenticated desktop path. Do not replace the keyring with
a plaintext password file.

### VNC cannot connect

Check both ends without exposing the port:

```bash
# Ubuntu
~/scripts/xrdp-vnc-bridge.sh status

# Mac relay
~/scripts/ubuntu-vnc.sh status
nc -zv 127.0.0.1 5922
```

The Mac script uses SSH keepalives and refuses to overwrite an unrelated
process already listening on its chosen local port.

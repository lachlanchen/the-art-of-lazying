# Workstation Internet Route Switcher

This note documents a small workstation helper for switching the default internet route between wired Ethernet and Wi-Fi without manually editing routes.

The concrete workstation shape was:

```text
eno2       wired, 192.168.1.99/24, gateway 192.168.1.1
wlp0s20f3  Wi-Fi, 192.168.24.108/24, gateway 192.168.24.1
```

The goal is to keep both links connected while deciding which one carries ordinary internet traffic.

## CLI

The local helper lives at:

```text
~/scripts/netswitch
```

Usage:

```bash
netswitch status
netswitch wired
netswitch wifi
netswitch toggle
netswitch gui
```

Default behavior:

```text
netswitch wired -> prefer eno2 via 192.168.1.1
netswitch wifi  -> prefer wlp0s20f3 via 192.168.24.1
```

The script sets NetworkManager route metrics persistently and also updates the live kernel default route immediately.

Typical metrics:

```text
wired preferred:
  eno2 metric 100
  wlp0s20f3 metric 600

Wi-Fi preferred:
  eno2 metric 600
  wlp0s20f3 metric 100
```

Check current routing:

```bash
netswitch status
ip route show default
ip route get 1.1.1.1
nmcli -f DEVICE,TYPE,STATE,CONNECTION dev status
```

Route switching needs admin privileges because it edits live kernel routes and NetworkManager connection settings. From a terminal it uses `sudo`; from the GUI it uses `pkexec` when available.

## GUI Launcher

The GNOME launcher is installed as:

```text
~/.local/share/applications/internet-route-switch.desktop
/usr/local/share/applications/internet-route-switch.desktop
~/Desktop/Internet Route Switch.desktop
```

The app name is:

```text
Internet Route Switch
```

It can be launched with:

```bash
gtk-launch internet-route-switch
```

The desktop entry runs:

```text
/home/lachlan/scripts/netswitch gui
```

It can be pinned to the Ubuntu dock through GNOME favorites. The desktop ID
is:

```text
internet-route-switch.desktop
```

### Persistent dock pin after reboot

On this XRDP workstation, a plain `gsettings` command wrote the favorite into:

```text
~/.config/glib-2.0/settings/keyfile
```

GNOME Shell was actually reading its dock favorites from the user's persistent
dconf database. This produced a confusing state:

- `gsettings get org.gnome.shell favorite-apps` showed the launcher
- the Ubuntu dock did not show it after reboot
- `dconf read /org/gnome/shell/favorite-apps` revealed the real Shell list did
  not contain it

Pin the launcher to the store GNOME Shell actually uses:

```bash
favorites="$(dconf read /org/gnome/shell/favorite-apps)"

case "$favorites" in
  *"'internet-route-switch.desktop'"*) ;;
  "@as []"|"[]"|"") favorites="['internet-route-switch.desktop']" ;;
  *)
    favorites="${favorites%]}"
    favorites="$favorites, 'internet-route-switch.desktop']"
    ;;
esac

dconf write /org/gnome/shell/favorite-apps "$favorites"
```

Verify the persistent value:

```bash
dconf read /org/gnome/shell/favorite-apps
```

The result should contain:

```text
internet-route-switch.desktop
```

The dconf write updates the running GNOME Shell and persists in
`~/.config/dconf/user`, so no login-time loop or systemd service is needed.

If the icon still does not render, refresh and validate the application cache:

```bash
desktop-file-validate \
  ~/.local/share/applications/internet-route-switch.desktop
update-desktop-database ~/.local/share/applications
```

To verify that GLib can resolve the desktop ID without opening the app:

```bash
gjs -c "const Gio=imports.gi.Gio; const app=Gio.DesktopAppInfo.new('internet-route-switch.desktop'); if (!app) throw new Error('desktop ID not found'); print(app.get_name());"
```

Important distinction: this local launcher appears in GNOME Show Applications/search and the dock, not in Ubuntu App Center. App Center shows packaged software, not ad-hoc desktop entries.

## Desktop Entry

Minimal desktop entry:

```ini
[Desktop Entry]
Type=Application
Name=Internet Route Switch
GenericName=Network Route Switcher
Comment=Switch default internet route between wired and Wi-Fi
Exec=/home/lachlan/scripts/netswitch gui
Icon=network-workgroup
Terminal=false
Categories=Network;
Keywords=network;internet;route;wired;wifi;ethernet;netswitch;
StartupNotify=true
```

After adding or editing it:

```bash
chmod +x ~/.local/share/applications/internet-route-switch.desktop
desktop-file-validate ~/.local/share/applications/internet-route-switch.desktop
update-desktop-database ~/.local/share/applications
```

For a system-wide local entry:

```bash
sudo install -D -o root -g root -m 0644 \
  ~/.local/share/applications/internet-route-switch.desktop \
  /usr/local/share/applications/internet-route-switch.desktop

sudo update-desktop-database /usr/local/share/applications
```

## Why This Is Useful

Keeping both interfaces connected is useful when:

- wired Ethernet is usually faster or more stable
- Wi-Fi is needed as a fallback path
- a same-IP downstream device can be reached through different upstream paths
- remote desktop work should not require disabling an interface

The safest default for remote work is to prefer the route that currently carries the RDP/VNC/SSH path. Switch routes only when the alternate path is already connected and verified.

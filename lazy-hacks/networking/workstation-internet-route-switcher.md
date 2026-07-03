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

It also can be pinned to the Ubuntu dock through GNOME favorites:

```bash
gsettings get org.gnome.shell favorite-apps
```

The favorite app id is:

```text
internet-route-switch.desktop
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

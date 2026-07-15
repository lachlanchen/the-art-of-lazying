# GNOME System RDP Remote Login on Ubuntu 24.04

## Problem

GNOME Remote Desktop can be enabled but still reject RDP clients.

Common symptoms:

- nothing is listening on `3389`
- `gnome-remote-desktop.service` is inactive for the user
- the machine is sitting at the GDM login screen
- logs show `Credentials are not set, denying client`
- `grdctl rdp set-credentials ...` fails with `Cannot create an item in a locked collection`

The important distinction:

- normal GNOME RDP desktop sharing depends on the logged-in user's desktop session and keyring
- GNOME system RDP Remote Login runs from the system daemon and can present a login flow over RDP

For login-screen access, use the system daemon.

## Check The Current State

Find the machine IP:

```bash
hostname -I
```

Check whether anything is listening on RDP:

```bash
ss -tulpn | rg ':(3389|3390)\b' || true
```

Check GNOME Remote Desktop:

```bash
systemctl status gnome-remote-desktop.service --no-pager
systemctl --user status gnome-remote-desktop.service gnome-remote-desktop-headless.service --no-pager
grdctl status --show-credentials
```

If the user service is inactive or credentials are missing, desktop sharing will not accept RDP clients.

## Configure System Remote Login

Run this on the Ubuntu machine, replacing the username and password placeholders:

```bash
sudo bash -c 'set -e
install -d -o gnome-remote-desktop -g gnome-remote-desktop -m 0755 /etc/gnome-remote-desktop

if [ ! -f /etc/gnome-remote-desktop/rdp-tls.crt ] || [ ! -f /etc/gnome-remote-desktop/rdp-tls.key ]; then
  openssl req -x509 -newkey rsa:3072 -nodes \
    -keyout /etc/gnome-remote-desktop/rdp-tls.key \
    -out /etc/gnome-remote-desktop/rdp-tls.crt \
    -days 825 \
    -subj "/CN=$(hostname)"
fi

chown gnome-remote-desktop:gnome-remote-desktop \
  /etc/gnome-remote-desktop/rdp-tls.crt \
  /etc/gnome-remote-desktop/rdp-tls.key
chmod 0644 /etc/gnome-remote-desktop/rdp-tls.crt
chmod 0600 /etc/gnome-remote-desktop/rdp-tls.key

grdctl --system rdp set-tls-cert /etc/gnome-remote-desktop/rdp-tls.crt
grdctl --system rdp set-tls-key /etc/gnome-remote-desktop/rdp-tls.key
grdctl --system rdp set-port 3389
grdctl --system rdp enable-port-negotiation
grdctl --system rdp set-credentials "<rdp-user>" "<rdp-password>"
grdctl --system rdp disable-view-only
grdctl --system rdp enable

systemctl restart gnome-remote-desktop.service
'
```

The `Init TPM credentials failed ... using GKeyFile as fallback` message is not fatal on this workstation.

## Verify

Check the system daemon status:

```bash
sudo grdctl --system status --show-credentials
```

Confirm the listener:

```bash
ss -tulpn | rg ':(3389|3390)\b'
```

Confirm local TCP connectivity:

```bash
timeout 3 bash -c '</dev/tcp/127.0.0.1/3389' && echo local_tcp_ok || echo local_tcp_failed
timeout 3 bash -c '</dev/tcp/$(hostname -I | awk "{print \$1}")/3389' && echo lan_ip_tcp_ok || echo lan_ip_tcp_failed
```

If `ufw` is active, allow RDP:

```bash
sudo ufw allow 3389/tcp
sudo ufw status verbose
```

## Connect From Windows

From Windows App or Microsoft Remote Desktop:

```text
<ubuntu-ip>:3389
```

Use the RDP username and password configured with:

```bash
sudo grdctl --system rdp set-credentials "<rdp-user>" "<rdp-password>"
```

Accept the self-signed certificate warning if prompted.

## Why This Worked

The broken setup had GNOME's user RDP settings enabled, but no active user RDP listener and no usable user credentials. The normal credential write path also hit a locked GNOME keyring.

System Remote Login avoids that dependency:

- credentials are stored for the system daemon
- `gnome-remote-desktop.service` listens on `3389`
- the RDP client can connect before a local desktop session is already running

Use this path when the goal is "connect over RDP and log in", not just "share an already-open desktop".

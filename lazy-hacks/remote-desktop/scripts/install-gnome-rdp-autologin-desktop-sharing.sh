#!/usr/bin/env bash
set -euo pipefail

umask 077

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
target_user="$(id -un)"
rdp_user="$target_user"
rdp_port=3390

usage() {
  cat <<'EOF'
Usage: install-gnome-rdp-autologin-desktop-sharing.sh [options]

Configure native GNOME Desktop Sharing for an automatically logged-in user.

Options:
  --rdp-user USER  RDP authentication username (default: current user)
  --port PORT      Desktop Sharing port (default: 3390)
  -h, --help       Show this help
EOF
}

while (($#)); do
  case "$1" in
    --rdp-user)
      rdp_user="${2:?--rdp-user requires a value}"
      shift 2
      ;;
    --port)
      rdp_port="${2:?--port requires a value}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if ((EUID == 0)); then
  printf 'Run this installer as the desktop user, not as root.\n' >&2
  exit 1
fi

if [[ ! "$rdp_port" =~ ^[0-9]+$ ]] || \
   ((rdp_port < 1024 || rdp_port > 65535)); then
  printf 'Invalid unprivileged TCP port: %s\n' "$rdp_port" >&2
  exit 1
fi

for file in \
  "$script_dir/gnome-rdp-session-credential-loader.sh" \
  "$script_dir/gnome-rdp-session-credentials@.service"; do
  if [[ ! -r "$file" ]]; then
    printf 'Required companion file is missing: %s\n' "$file" >&2
    exit 1
  fi
done

sudo -v
sudo apt-get install -y \
  avahi-daemon \
  gnome-remote-desktop \
  libnss-mdns \
  libsecret-tools \
  openssl \
  python3-gi
sudo systemctl enable --now avahi-daemon.service

if ! /usr/bin/busctl --user --no-pager \
    status org.freedesktop.secrets >/dev/null 2>&1; then
  printf 'The desktop Secret Service is unavailable. Log into GNOME and retry.\n' >&2
  exit 1
fi

read -r -s -p "RDP password for $rdp_user: " rdp_password
printf '\n'
read -r -s -p 'Confirm RDP password: ' rdp_password_confirm
printf '\n'

if [[ -z "$rdp_password" ]]; then
  printf 'The RDP password must not be empty.\n' >&2
  exit 1
fi
if [[ "$rdp_password" != "$rdp_password_confirm" ]]; then
  printf 'The passwords do not match.\n' >&2
  exit 1
fi
unset rdp_password_confirm

serialize_credentials() {
  {
    printf '%s\0' "$rdp_user"
    printf '%s' "$rdp_password"
  } | /usr/bin/python3 -c '
import sys
from gi.repository import GLib

username, password = sys.stdin.buffer.read().split(b"\0", 1)
value = GLib.Variant("a{sv}", {
    "username": GLib.Variant("s", username.decode("utf-8")),
    "password": GLib.Variant("s", password.decode("utf-8")),
})
sys.stdout.write(value.print_(True))
'
}

host_short="$(hostname -s)"
host_mdns="$host_short.local"
host_ipv4="$(hostname -I | awk '{ for (i=1; i<=NF; i++) if ($i ~ /^[0-9.]+$/) { print $i; exit } }')"
cert_dir="$HOME/.local/share/gnome-remote-desktop/certificates"
cert_file="$cert_dir/$host_short-rdp.crt"
key_file="$cert_dir/$host_short-rdp.key"
subject_alt_name="DNS:$host_mdns,DNS:$host_short"

if [[ -n "$host_ipv4" ]]; then
  subject_alt_name+=",IP:$host_ipv4"
fi

install -d -m 0700 "$cert_dir"
openssl req -x509 -newkey rsa:3072 -sha256 -nodes -days 3650 \
  -keyout "$key_file" \
  -out "$cert_file" \
  -subj "/CN=$host_mdns/O=GNOME Remote Desktop" \
  -addext "subjectAltName=$subject_alt_name" \
  -addext 'keyUsage=critical,digitalSignature,keyEncipherment' \
  -addext 'extendedKeyUsage=serverAuth'
chmod 0600 "$cert_file" "$key_file"

grdctl rdp set-port "$rdp_port"
grdctl rdp disable-port-negotiation
grdctl rdp disable-view-only
grdctl rdp set-tls-cert "$cert_file"
grdctl rdp set-tls-key "$key_file"
grdctl rdp enable

serialize_credentials | secret-tool store \
  --collection=session \
  --label='GNOME Remote Desktop RDP credentials' \
  xdg:schema org.gnome.RemoteDesktop.RdpCredentials

sudo install -D -o root -g root -m 0755 \
  "$script_dir/gnome-rdp-session-credential-loader.sh" \
  /usr/local/libexec/gnome-rdp-session-credential-loader
sudo install -D -o root -g root -m 0644 \
  "$script_dir/gnome-rdp-session-credentials@.service" \
  /etc/systemd/system/gnome-rdp-session-credentials@.service

credential_dir=/etc/credstore.encrypted
credential_file="$credential_dir/gnome-rdp-$target_user"
credential_new="$credential_file.new"

sudo systemd-creds setup
sudo install -d -o root -g root -m 0700 "$credential_dir"
sudo rm -f "$credential_new"
serialize_credentials | sudo systemd-creds encrypt \
  --with-key=host \
  --name=rdp-credentials \
  - "$credential_new"
sudo chown root:root "$credential_new"
sudo chmod 0600 "$credential_new"
sudo mv "$credential_new" "$credential_file"

unset rdp_password

systemctl --user enable --now gnome-remote-desktop.service
systemctl --user restart gnome-remote-desktop.service
sudo systemctl daemon-reload
sudo systemctl enable --now \
  "gnome-rdp-session-credentials@$target_user.service"

printf '\nConfigured GNOME Desktop Sharing.\n'
printf 'Host: %s\n' "$host_mdns"
printf 'Port: %s\n' "$rdp_port"
printf 'RDP user: %s\n' "$rdp_user"
printf 'Status commands:\n'
printf '  grdctl status\n'
printf '  systemctl --user status gnome-remote-desktop.service\n'
printf '  sudo systemctl status gnome-rdp-session-credentials@%s.service\n' \
  "$target_user"

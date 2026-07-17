#!/usr/bin/env bash

set -Eeuo pipefail

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

if (( EUID != 0 )); then
  printf 'install.sh: run as root\n' >&2
  exit 1
fi

for command_name in dkms flock install systemctl; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    printf 'install.sh: missing command: %s\n' "$command_name" >&2
    exit 1
  fi
done

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

install -D -m 0755 \
  "$script_dir/aic8800dc-dkms-ensure" \
  /usr/local/sbin/aic8800dc-dkms-ensure
install -D -m 0755 \
  "$script_dir/aic8800dc-dkms-guard" \
  /usr/local/libexec/aic8800dc-dkms-guard
install -D -m 0755 \
  "$script_dir/verify.sh" \
  /usr/local/bin/aic8800dc-persistence-verify
install -D -m 0644 \
  "$script_dir/aic8800dc-dkms-ensure.service" \
  /etc/systemd/system/aic8800dc-dkms-ensure.service
install -D -m 0644 \
  "$script_dir/zz-aic8800dc-wifi.conf" \
  /etc/NetworkManager/conf.d/zz-aic8800dc-wifi.conf

ln -sfn /usr/local/libexec/aic8800dc-dkms-guard \
  /etc/kernel/postinst.d/aic8800dc-dkms-guard
ln -sfn /usr/local/libexec/aic8800dc-dkms-guard \
  /etc/kernel/header_postinst.d/aic8800dc-dkms-guard

systemctl daemon-reload
systemctl enable aic8800dc-dkms-ensure.service
systemctl restart aic8800dc-dkms-ensure.service

if command -v nmcli >/dev/null 2>&1; then
  nmcli general reload >/dev/null 2>&1 || true

  for net_path in /sys/class/net/*; do
    device_path="$(readlink -f "$net_path/device" 2>/dev/null || true)"
    [[ -r "$device_path/idVendor" && -r "$device_path/idProduct" ]] || continue
    [[ "$(<"$device_path/idVendor")" == "a69c" ]] || continue
    [[ "$(<"$device_path/idProduct")" == "88dc" ]] || continue

    interface_name="${net_path##*/}"
    connection_uuid="$(
      nmcli -g GENERAL.CON-UUID device show "$interface_name" 2>/dev/null || true
    )"
    if [[ "$connection_uuid" =~ ^[0-9A-Fa-f-]{36}$ ]]; then
      nmcli connection modify "$connection_uuid" 802-11-wireless.powersave 2
      nmcli device reapply "$interface_name" >/dev/null 2>&1 || true
    fi
  done
fi

printf 'Installed and started aic8800dc-dkms-ensure.service\n'

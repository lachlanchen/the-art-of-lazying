#!/usr/bin/env bash

set -Eeuo pipefail

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

if (( EUID != 0 )); then
  printf 'uninstall.sh: run as root\n' >&2
  exit 1
fi

systemctl disable --now aic8800dc-dkms-ensure.service 2>/dev/null || true

rm -f \
  /etc/kernel/postinst.d/aic8800dc-dkms-guard \
  /etc/kernel/header_postinst.d/aic8800dc-dkms-guard \
  /etc/NetworkManager/conf.d/zz-aic8800dc-wifi.conf \
  /etc/systemd/system/aic8800dc-dkms-ensure.service \
  /usr/local/libexec/aic8800dc-dkms-guard \
  /usr/local/bin/aic8800dc-persistence-verify \
  /usr/local/sbin/aic8800dc-dkms-ensure

systemctl daemon-reload
systemctl reset-failed aic8800dc-dkms-ensure.service 2>/dev/null || true
if command -v nmcli >/dev/null 2>&1; then
  nmcli general reload >/dev/null 2>&1 || true
fi

printf 'Removed the AIC8800DC persistence guard; the DKMS driver remains installed.\n'

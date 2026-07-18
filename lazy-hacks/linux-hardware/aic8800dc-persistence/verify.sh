#!/usr/bin/env bash

set -uo pipefail

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

failures=0
kernel_release="$(uname -r)"

pass() {
  printf 'PASS  %s\n' "$1"
}

fail() {
  printf 'FAIL  %s\n' "$1" >&2
  failures=$((failures + 1))
}

check() {
  local description="$1"
  shift

  if "$@" >/dev/null 2>&1; then
    pass "$description"
  else
    fail "$description"
  fi
}

check "current kernel headers are installed" \
  test -f "/lib/modules/$kernel_release/build/Makefile"
check "AIC8800DC DKMS source is registered" \
  dkms status -m aic8800dc

if dkms status -m aic8800dc 2>/dev/null \
  | grep -F ", $kernel_release," | grep -q ': installed$'; then
  pass "DKMS driver is installed for $kernel_release"
else
  fail "DKMS driver is installed for $kernel_release"
fi

check "aic_load_fw is available" modinfo -k "$kernel_release" aic_load_fw
check "aic8800_fdrv is available" modinfo -k "$kernel_release" aic8800_fdrv
check "aic_load_fw is loaded" grep -q '^aic_load_fw ' /proc/modules
check "aic8800_fdrv is loaded" grep -q '^aic8800_fdrv ' /proc/modules
check "boot recovery service is enabled" \
  systemctl is-enabled --quiet aic8800dc-dkms-ensure.service
check "boot recovery service completed" \
  systemctl is-active --quiet aic8800dc-dkms-ensure.service
check "kernel post-install guard is executable" \
  test -x /etc/kernel/postinst.d/aic8800dc-dkms-guard
check "header post-install guard is executable" \
  test -x /etc/kernel/header_postinst.d/aic8800dc-dkms-guard
check "USB Wi-Fi power-saving override is installed" \
  test -r /etc/NetworkManager/conf.d/zz-aic8800dc-wifi.conf

if command -v nmcli >/dev/null 2>&1; then
  while IFS= read -r interface_name; do
    device_path="$(readlink -f "/sys/class/net/$interface_name/device" 2>/dev/null || true)"
    [[ -r "$device_path/idVendor" && -r "$device_path/idProduct" ]] || continue
    [[ "$(<"$device_path/idVendor")" == "a69c" ]] || continue
    [[ "$(<"$device_path/idProduct")" == "88dc" ]] || continue

    connection_uuid="$(
      nmcli -g GENERAL.CON-UUID device show "$interface_name" 2>/dev/null || true
    )"
    if [[ ! "$connection_uuid" =~ ^[0-9A-Fa-f-]{36}$ ]]; then
      fail "active AIC8800DC profile disables Wi-Fi power saving"
      continue
    fi

    power_save="$(nmcli -g 802-11-wireless.powersave connection show \
      "$connection_uuid" 2>/dev/null || true)"
    case "$power_save" in
      2|disable|disabled)
        pass "active AIC8800DC profile disables Wi-Fi power saving"
        ;;
      *)
        fail "active AIC8800DC profile disables Wi-Fi power saving"
        ;;
    esac
  done < <(nmcli -t -f DEVICE,TYPE device status \
    | sed -n 's/:wifi$//p')
fi

if command -v lsusb >/dev/null 2>&1 && lsusb -d a69c:5721 | grep -q .; then
  fail "USB adapter has switched out of storage mode"
elif command -v lsusb >/dev/null 2>&1 && lsusb -d a69c:88dc | grep -q .; then
  pass "USB adapter is in Wi-Fi mode"
else
  printf 'SKIP  AIC8800DC USB adapter is not attached\n'
fi

if (( failures > 0 )); then
  printf '\n%d verification check(s) failed.\n' "$failures" >&2
  exit 1
fi

printf '\nAll persistence checks passed.\n'

#!/usr/bin/env bash
set -Eeuo pipefail

UPSTREAM_CONN="${UPSTREAM_CONN:-HKU}"
WAN_IF="${WAN_IF:-wlan0}"
LAN_IF="${LAN_IF:-eth0}"
LAN_ADDR="${LAN_ADDR:-192.168.2.1/24}"
LAN_PING_ADDR="${LAN_PING_ADDR:-192.168.2.1}"
DHCP_RANGE="${DHCP_RANGE:-192.168.2.2,192.168.2.254,12h}"
DNSMASQ_CONF="${DNSMASQ_CONF:-/etc/dnsmasq.d/bridge.conf}"
SYSCTL_CONF="${SYSCTL_CONF:-/etc/sysctl.d/99-wifi-lan-router.conf}"
TTL="${TTL:-65}"
BACKUP_DIR="${BACKUP_DIR:-/var/backups/pi-wifi-to-lan-router}"
RECONNECT_WIFI=0

usage() {
  cat <<EOF
Usage:
  sudo $0 apply [--reconnect-wifi]
  sudo $0 status

Defaults can be overridden with environment variables:
  UPSTREAM_CONN=$UPSTREAM_CONN
  WAN_IF=$WAN_IF
  LAN_IF=$LAN_IF
  LAN_ADDR=$LAN_ADDR
  LAN_PING_ADDR=$LAN_PING_ADDR
  DHCP_RANGE=$DHCP_RANGE
  DNSMASQ_CONF=$DNSMASQ_CONF
  SYSCTL_CONF=$SYSCTL_CONF
  TTL=$TTL

Notes:
  apply              sets a simple static Wi-Fi-to-LAN NAT router state.
  --reconnect-wifi   also restarts the upstream Wi-Fi connection. This briefly
                     interrupts internet for downstream LAN clients.

This script intentionally does not run a monitoring loop or periodic restart.
It is designed to be used as a boot-time oneshot service plus manual repair
command.
EOF
}

log() {
  printf '[%s] %s\n' "$(date '+%F %T')" "$*"
}

die() {
  log "ERROR: $*" >&2
  exit 1
}

as_root() {
  if [ "${EUID:-$(id -u)}" -ne 0 ]; then
    die "run as root, for example: sudo $0 apply"
  fi
}

find_cmd() {
  local name="$1"
  shift
  local candidate
  for candidate in "$name" "$@"; do
    if command -v "$candidate" >/dev/null 2>&1; then
      command -v "$candidate"
      return 0
    fi
    if [ -x "$candidate" ]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done
  return 1
}

backup_file() {
  local path="$1"
  if [ -e "$path" ]; then
    mkdir -p "$BACKUP_DIR"
    cp -a "$path" "$BACKUP_DIR/$(basename "$path").bak.$(date '+%Y%m%d-%H%M%S')"
  fi
}

cleanup_dnsmasq_active_backups() {
  local conf_dir
  conf_dir="$(dirname "$DNSMASQ_CONF")"
  [ -d "$conf_dir" ] || return 0

  mkdir -p "$BACKUP_DIR/dnsmasq.d"
  find "$conf_dir" -maxdepth 1 -type f -name '*.bak.*' -exec mv -t "$BACKUP_DIR/dnsmasq.d" {} + 2>/dev/null || true
}

iptables_delete_all() {
  local table="$1"
  shift
  while "$IPTABLES" ${table:+-t "$table"} -C "$@" >/dev/null 2>&1; do
    "$IPTABLES" ${table:+-t "$table"} -D "$@"
  done
}

iptables_ensure_one() {
  local table="$1"
  shift
  iptables_delete_all "$table" "$@"
  "$IPTABLES" ${table:+-t "$table"} -A "$@"
}

configure_wifi_powersave() {
  log "Disabling Wi-Fi powersave for NetworkManager connection: $UPSTREAM_CONN"
  "$NMCLI" connection modify "$UPSTREAM_CONN" 802-11-wireless.powersave 2
  disable_interface_powersave
}

disable_interface_powersave() {
  log "Disabling runtime and driver Wi-Fi powersave for interface: $WAN_IF"

  if [ -w "/sys/class/net/$WAN_IF/power/control" ]; then
    printf 'on\n' > "/sys/class/net/$WAN_IF/power/control" || true
  fi

  if [ -n "${IW:-}" ]; then
    "$IW" dev "$WAN_IF" set power_save off || log "WARN: failed to disable iw powersave on $WAN_IF"
  fi

  if [ -n "${IWCONFIG:-}" ]; then
    "$IWCONFIG" "$WAN_IF" power off >/dev/null 2>&1 || true
  fi
}

configure_sysctl() {
  log "Enabling IPv4 forwarding and default TTL $TTL"
  backup_file "$SYSCTL_CONF"
  mkdir -p "$(dirname "$SYSCTL_CONF")"
  {
    printf 'net.ipv4.ip_forward=1\n'
    if [ -n "$TTL" ]; then
      printf 'net.ipv4.ip_default_ttl=%s\n' "$TTL"
    fi
  } > "$SYSCTL_CONF"

  "$SYSCTL" -w net.ipv4.ip_forward=1 >/dev/null
  if [ -n "$TTL" ]; then
    "$SYSCTL" -w "net.ipv4.ip_default_ttl=$TTL" >/dev/null
  fi
}

configure_lan_interface() {
  log "Ensuring $LAN_IF has $LAN_ADDR and is up"
  "$IP" link set "$LAN_IF" up
  "$IP" addr replace "$LAN_ADDR" dev "$LAN_IF"
}

configure_dnsmasq() {
  log "Writing dnsmasq LAN DHCP config: $DNSMASQ_CONF"
  cleanup_dnsmasq_active_backups
  backup_file "$DNSMASQ_CONF"
  mkdir -p "$(dirname "$DNSMASQ_CONF")"
  cat > "$DNSMASQ_CONF" <<EOF
interface=$LAN_IF
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=$DHCP_RANGE
EOF
  "$SYSTEMCTL" enable dnsmasq >/dev/null
  "$SYSTEMCTL" restart dnsmasq
}

configure_rules() {
  log "Cleaning duplicate firewall rules and ensuring one known-good rule set"
  iptables_ensure_one "" FORWARD -i "$LAN_IF" -o "$WAN_IF" -j ACCEPT
  iptables_ensure_one "" FORWARD -i "$WAN_IF" -o "$LAN_IF" -m state --state RELATED,ESTABLISHED -j ACCEPT
  iptables_ensure_one nat POSTROUTING -o "$WAN_IF" -j MASQUERADE

  if [ -n "$TTL" ]; then
    iptables_delete_all mangle POSTROUTING -j TTL --ttl-set "$TTL"
    iptables_ensure_one mangle POSTROUTING -o "$WAN_IF" -j TTL --ttl-set "$TTL"
  fi

  if [ -n "${NETFILTER_PERSISTENT:-}" ]; then
    log "Saving netfilter rules"
    "$NETFILTER_PERSISTENT" save
  else
    log "WARN: netfilter-persistent not found; live iptables rules were fixed but may not survive reboot"
  fi
}

maybe_reconnect_wifi() {
  if [ "$RECONNECT_WIFI" -eq 0 ]; then
    log "Skipping Wi-Fi reconnect. New powersave setting will fully apply on the next reconnect/reboot."
    return 0
  fi

  log "Reconnecting Wi-Fi connection $UPSTREAM_CONN; LAN internet will pause briefly"
  "$NMCLI" connection down "$UPSTREAM_CONN" || true
  sleep 2
  "$NMCLI" connection up "$UPSTREAM_CONN"
  disable_interface_powersave
}

show_status() {
  log "Status"
  printf 'hostname: '; hostname
  printf 'uptime: '; uptime
  printf 'ip_forward: '; cat /proc/sys/net/ipv4/ip_forward
  printf 'default_ttl: '; cat /proc/sys/net/ipv4/ip_default_ttl
  printf 'wifi powersave setting: '
  "$NMCLI" -g 802-11-wireless.powersave connection show "$UPSTREAM_CONN" || true
  printf 'runtime power control: '
  cat "/sys/class/net/$WAN_IF/power/control" 2>/dev/null || true
  if [ -n "${IW:-}" ]; then
    printf 'driver Wi-Fi power save: '
    "$IW" dev "$WAN_IF" get power_save 2>/dev/null || true
  fi
  printf '\ninterfaces:\n'
  "$IP" -brief addr show "$LAN_IF" || true
  "$IP" -brief addr show "$WAN_IF" || true
  printf '\nroutes:\n'
  "$IP" route || true
  printf '\ndnsmasq:\n'
  "$SYSTEMCTL" --no-pager --full status dnsmasq | sed -n '1,20p' || true
  printf '\nFORWARD rules:\n'
  "$IPTABLES" -S FORWARD || true
  printf '\nNAT POSTROUTING rules:\n'
  "$IPTABLES" -t nat -S POSTROUTING || true
  printf '\nMANGLE POSTROUTING rules:\n'
  "$IPTABLES" -t mangle -S POSTROUTING || true
  printf '\nquick ping checks:\n'
  ping -c 2 -W 2 "$LAN_PING_ADDR" || true
  ping -c 2 -W 2 8.8.8.8 || true
}

apply_fix() {
  configure_wifi_powersave
  configure_sysctl
  configure_lan_interface
  configure_dnsmasq
  configure_rules
  maybe_reconnect_wifi
  show_status
  log "Done"
}

main() {
  local action="${1:-}"
  shift || true

  while [ "$#" -gt 0 ]; do
    case "$1" in
      --reconnect-wifi)
        RECONNECT_WIFI=1
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "unknown argument: $1"
        ;;
    esac
    shift
  done

  NMCLI="$(find_cmd nmcli /usr/bin/nmcli)" || die "nmcli not found"
  IP="$(find_cmd ip /usr/sbin/ip /sbin/ip)" || die "ip not found"
  IPTABLES="$(find_cmd iptables /usr/sbin/iptables /sbin/iptables)" || die "iptables not found"
  SYSCTL="$(find_cmd sysctl /usr/sbin/sysctl /sbin/sysctl)" || die "sysctl not found"
  SYSTEMCTL="$(find_cmd systemctl /usr/bin/systemctl /bin/systemctl)" || die "systemctl not found"
  NETFILTER_PERSISTENT="$(find_cmd netfilter-persistent /usr/sbin/netfilter-persistent /sbin/netfilter-persistent || true)"
  IW="$(find_cmd iw /usr/sbin/iw /sbin/iw || true)"
  IWCONFIG="$(find_cmd iwconfig /usr/sbin/iwconfig /sbin/iwconfig || true)"

  case "$action" in
    apply)
      as_root
      apply_fix
      ;;
    status)
      show_status
      ;;
    -h|--help|"")
      usage
      ;;
    *)
      usage >&2
      exit 2
      ;;
  esac
}

main "$@"

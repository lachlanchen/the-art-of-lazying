#!/bin/bash
set -euo pipefail

# On-demand, SSH-tunneled VNC connection from a Mac relay to the active XRDP
# Xorg desktop on an Ubuntu host. Nothing is exposed outside localhost.

action="${1:-start}"
remote="${UBUNTU_VNC_SSH:-user@ubuntu-host}"
local_port="${UBUNTU_VNC_LOCAL_PORT:-5922}"
remote_port="${UBUNTU_VNC_REMOTE_PORT:-5922}"
remote_helper="${UBUNTU_VNC_REMOTE_HELPER:-~/scripts/xrdp-vnc-bridge.sh}"
viewer="/Applications/VNC Viewer.app"
state_dir="$HOME/Library/Caches/ubuntu-vnc"
pid_file="$state_dir/tunnel.pid"
log_file="$state_dir/tunnel.log"

mkdir -p "$state_dir"

read_pid() {
  if [ -r "$pid_file" ]; then
    tr -cd '0-9' <"$pid_file"
  fi
}

tunnel_command_matches() {
  local pid="$1"
  local command

  [ -n "$pid" ] || return 1
  command="$(ps -p "$pid" -o command= 2>/dev/null || true)"
  [[ "$command" == *"ssh"* \
    && "$command" == *"127.0.0.1:$local_port:127.0.0.1:$remote_port"* \
    && "$command" == *"$remote"* ]]
}

find_listener_pid() {
  /usr/sbin/lsof -tiTCP@127.0.0.1:"$local_port" -sTCP:LISTEN 2>/dev/null | head -n 1
}

adopt_existing_tunnel() {
  local pid=""

  pid="$(read_pid || true)"
  if tunnel_command_matches "$pid"; then
    printf '%s\n' "$pid"
    return 0
  fi

  pid="$(find_listener_pid || true)"
  if tunnel_command_matches "$pid"; then
    printf '%s\n' "$pid" >"$pid_file"
    printf '%s\n' "$pid"
    return 0
  fi

  return 1
}

start_tunnel() {
  local pid=""
  local attempt
  local listener_pid=""

  /usr/bin/ssh \
    -o BatchMode=yes \
    -o ConnectTimeout=8 \
    "$remote" \
    "$remote_helper" start

  pid="$(adopt_existing_tunnel || true)"
  if [ -n "$pid" ] && /usr/bin/nc -z 127.0.0.1 "$local_port" 2>/dev/null; then
    printf 'Reusing SSH tunnel pid=%s localhost:%s\n' "$pid" "$local_port"
    return 0
  fi

  listener_pid="$(find_listener_pid || true)"
  if [ -n "$listener_pid" ]; then
    printf 'Local port %s is occupied by process %s; refusing to replace it.\n' \
      "$local_port" "$listener_pid" >&2
    return 1
  fi

  nohup /usr/bin/ssh \
    -N \
    -o BatchMode=yes \
    -o ExitOnForwardFailure=yes \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3 \
    -L "127.0.0.1:$local_port:127.0.0.1:$remote_port" \
    "$remote" \
    >"$log_file" 2>&1 &
  pid=$!
  printf '%s\n' "$pid" >"$pid_file"

  for attempt in $(seq 1 40); do
    if tunnel_command_matches "$pid" \
      && /usr/bin/nc -z 127.0.0.1 "$local_port" 2>/dev/null; then
      printf 'Started SSH tunnel pid=%s localhost:%s\n' "$pid" "$local_port"
      return 0
    fi
    sleep 0.1
  done

  printf 'SSH tunnel failed; inspect %s.\n' "$log_file" >&2
  return 1
}

open_viewer() {
  local display_number

  [ -d "$viewer" ] || {
    printf 'VNC Viewer is not installed at %s.\n' "$viewer" >&2
    return 1
  }

  display_number=$((local_port - 5900))
  /usr/bin/open -na "$viewer" --args \
    -Scaling=FitAutoAspect \
    -DynamicResolution=0 \
    "127.0.0.1:$display_number"
  printf 'Opened VNC Viewer at 127.0.0.1:%s (TCP port %s).\n' \
    "$display_number" "$local_port"
}

stop_tunnel() {
  local pid=""

  pid="$(adopt_existing_tunnel || true)"
  if [ -n "$pid" ]; then
    kill "$pid" 2>/dev/null || true
    rm -f "$pid_file"
    printf 'Stopped SSH tunnel pid=%s.\n' "$pid"
  else
    rm -f "$pid_file"
    printf 'SSH tunnel is already stopped.\n'
  fi

  /usr/bin/ssh \
    -o BatchMode=yes \
    -o ConnectTimeout=8 \
    "$remote" \
    "$remote_helper" stop \
    || true
}

show_status() {
  local pid=""

  pid="$(adopt_existing_tunnel || true)"
  if [ -n "$pid" ] && /usr/bin/nc -z 127.0.0.1 "$local_port" 2>/dev/null; then
    printf 'running tunnel_pid=%s localhost_port=%s remote=%s\n' \
      "$pid" "$local_port" "$remote"
    return 0
  fi

  printf 'stopped localhost_port=%s remote=%s\n' "$local_port" "$remote"
  return 1
}

case "$action" in
  start)
    start_tunnel
    open_viewer
    ;;
  stop)
    stop_tunnel
    ;;
  restart)
    stop_tunnel
    start_tunnel
    open_viewer
    ;;
  status)
    show_status
    ;;
  *)
    printf 'Usage: %s {start|stop|restart|status}\n' "$0" >&2
    exit 64
    ;;
esac

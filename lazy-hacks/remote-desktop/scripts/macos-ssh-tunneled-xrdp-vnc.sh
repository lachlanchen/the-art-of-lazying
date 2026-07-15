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
lock_dir="$state_dir/operation.lock"
viewer_display=$((local_port - 5900))
viewer_target="127.0.0.1:$viewer_display"

mkdir -p "$state_dir"

release_operation_lock() {
  rm -f "$lock_dir/pid"
  rmdir "$lock_dir" 2>/dev/null || true
}

acquire_operation_lock() {
  local attempt
  local owner=""

  for attempt in $(seq 1 150); do
    if mkdir "$lock_dir" 2>/dev/null; then
      printf '%s\n' "$$" >"$lock_dir/pid"
      trap release_operation_lock EXIT
      return 0
    fi

    owner="$(cat "$lock_dir/pid" 2>/dev/null || true)"
    if [ -z "$owner" ] || ! kill -0 "$owner" 2>/dev/null; then
      rm -f "$lock_dir/pid"
      rmdir "$lock_dir" 2>/dev/null || true
      continue
    fi
    sleep 0.1
  done

  printf 'Another VNC launcher operation is still running.\n' >&2
  return 1
}

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

viewer_pids() {
  /usr/bin/pgrep -f \
    "/Applications/VNC Viewer\\.app/Contents/MacOS/vncviewer.*127\\.0\\.0\\.1:${viewer_display}([[:space:]]|$)" \
    2>/dev/null \
    || true
}

activate_viewer() {
  /usr/bin/osascript \
    -e 'tell application "VNC Viewer" to activate' \
    >/dev/null 2>&1 \
    || true
}

deduplicate_viewers() {
  local pids=""
  local keep=""
  local pid
  local attempt
  local removed=0

  pids="$(viewer_pids)"
  [ -n "$pids" ] || return 1
  keep="$(printf '%s\n' "$pids" | head -n 1)"

  while read -r pid; do
    [ -n "$pid" ] || continue
    if [ "$pid" != "$keep" ]; then
      kill -TERM "$pid" 2>/dev/null || true
      removed=$((removed + 1))
    fi
  done <<EOF
$pids
EOF

  if [ "$removed" -gt 0 ]; then
    for attempt in $(seq 1 30); do
      [ "$(viewer_pids | wc -l | tr -d ' ')" -le 1 ] && break
      sleep 0.1
    done
    printf 'Closed %s duplicate VNC Viewer connection(s); kept pid=%s.\n' \
      "$removed" "$keep"
  fi
  printf '%s\n' "$keep"
}

close_viewers() {
  local pids=""
  local pid
  local attempt
  local count=0

  pids="$(viewer_pids)"
  if [ -z "$pids" ]; then
    printf 'No matching VNC Viewer connection is open.\n'
    return 0
  fi

  while read -r pid; do
    [ -n "$pid" ] || continue
    kill -TERM "$pid" 2>/dev/null || true
    count=$((count + 1))
  done <<EOF
$pids
EOF

  for attempt in $(seq 1 30); do
    [ -z "$(viewer_pids)" ] && break
    sleep 0.1
  done
  printf 'Closed %s matching VNC Viewer connection(s).\n' "$count"
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
  if [ -n "$pid" ] && [ "$(find_listener_pid || true)" = "$pid" ]; then
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
      && [ "$(find_listener_pid || true)" = "$pid" ]; then
      printf 'Started SSH tunnel pid=%s localhost:%s\n' "$pid" "$local_port"
      return 0
    fi
    sleep 0.1
  done

  printf 'SSH tunnel failed; inspect %s.\n' "$log_file" >&2
  return 1
}

open_viewer() {
  local attempt

  [ -d "$viewer" ] || {
    printf 'VNC Viewer is not installed at %s.\n' "$viewer" >&2
    return 1
  }

  deduplicate_viewers >/dev/null || true
  if [ -n "$(viewer_pids)" ]; then
    activate_viewer
    printf 'Reusing VNC Viewer at %s (TCP port %s).\n' \
      "$viewer_target" "$local_port"
    return 0
  fi

  /usr/bin/open -na "$viewer" --args \
    -Scaling=FitAutoAspect \
    -DynamicResolution=0 \
    "$viewer_target"

  for attempt in $(seq 1 40); do
    if [ -n "$(viewer_pids)" ]; then
      deduplicate_viewers >/dev/null || true
      printf 'Opened VNC Viewer at %s (TCP port %s).\n' \
        "$viewer_target" "$local_port"
      return 0
    fi
    sleep 0.1
  done

  printf 'VNC Viewer did not open for %s.\n' "$viewer_target" >&2
  return 1
}

stop_tunnel() {
  local pid=""

  close_viewers
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
  local viewer_count

  pid="$(adopt_existing_tunnel || true)"
  viewer_count="$(viewer_pids | wc -l | tr -d ' ')"
  if [ -n "$pid" ] && [ "$(find_listener_pid || true)" = "$pid" ]; then
    printf 'running tunnel_pid=%s viewer_count=%s localhost_port=%s remote=%s\n' \
      "$pid" "$viewer_count" "$local_port" "$remote"
    return 0
  fi

  printf 'stopped viewer_count=%s localhost_port=%s remote=%s\n' \
    "$viewer_count" "$local_port" "$remote"
  return 1
}

case "$action" in
  start)
    acquire_operation_lock
    start_tunnel
    open_viewer
    ;;
  stop)
    acquire_operation_lock
    stop_tunnel
    ;;
  restart)
    acquire_operation_lock
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

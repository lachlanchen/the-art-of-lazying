#!/bin/sh
set -eu

uid="$(/usr/bin/id -u)"
runtime_dir="/run/user/$uid"
credential="${CREDENTIALS_DIRECTORY:?}/rdp-credentials"
poll_seconds="${GNOME_RDP_CREDENTIAL_POLL_SECONDS:-5}"
last_service_id=""

while :; do
    bus="$runtime_dir/bus"

    if [ -S "$bus" ]; then
        export XDG_RUNTIME_DIR="$runtime_dir"
        export DBUS_SESSION_BUS_ADDRESS="unix:path=$bus"

        bus_id="$(/usr/bin/stat -Lc '%d:%i' "$bus" 2>/dev/null || true)"
        secret_pid="$({
            /usr/bin/busctl --user --no-pager \
                status org.freedesktop.secrets 2>/dev/null || true
        } | /usr/bin/sed -n 's/^PID=//p')"
        service_id="$bus_id:$secret_pid"

        if [ -n "$bus_id" ] && \
           [ -n "$secret_pid" ] && \
           [ "$service_id" != "$last_service_id" ]; then
            if /usr/bin/secret-tool store \
                --collection=session \
                --label='GNOME Remote Desktop RDP credentials' \
                xdg:schema org.gnome.RemoteDesktop.RdpCredentials \
                < "$credential"; then
                /usr/bin/systemctl --user restart \
                    gnome-remote-desktop.service || true
                last_service_id="$service_id"
                printf 'Loaded GNOME RDP credentials for UID %s into Secret Service PID %s.\n' \
                    "$uid" "$secret_pid"
            fi
        fi
    else
        last_service_id=""
    fi

    /usr/bin/sleep "$poll_seconds"
done

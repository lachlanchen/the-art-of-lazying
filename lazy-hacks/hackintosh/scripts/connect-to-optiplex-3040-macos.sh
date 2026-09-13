#!/bin/sh

set -eu

MAC_HOST=optiplex-3040-macos
MAC_ADDRESS=OptiPlex-3040-macOS.local

resolve_profile() {
    python3 - "$MAC_ADDRESS" <<'PY'
import configparser
import pathlib
import sys

matches = []
for path in sorted((pathlib.Path.home() / '.local/share/remmina').glob('*.remmina')):
    profile = configparser.ConfigParser(interpolation=None)
    try:
        profile.read(path)
        section = profile['remmina']
        if (section.get('protocol') == 'VNC'
                and section.get('server', '').casefold() in
                (sys.argv[1].casefold(), sys.argv[1].casefold() + ':5900')):
            matches.append(path)
    except (OSError, configparser.Error, KeyError):
        continue
if len(matches) != 1:
    print('Expected exactly one saved VNC profile for the 3040 Mac; found %d.' % len(matches), file=sys.stderr)
    sys.exit(1 if not matches else 2)
print(matches[0])
PY
}

ready() {
    nc -z -w 3 "$1" "$2" >/dev/null 2>&1
}

state() {
    if ready "$1" "$2"; then
        printf 'Ready'
    else
        printf 'Unavailable'
    fi
}

if [ "${1:-}" = "--profile" ]; then
    resolve_profile
    exit 0
fi

if [ "${1:-}" = "--test" ]; then
    printf 'SSH=%s\n' "$(state "$MAC_ADDRESS" 22)"
    printf 'VNC=%s\n' "$(state "$MAC_ADDRESS" 5900)"
    exit 0
fi

case ${1:---vnc} in
--vnc) choice='Screen Sharing (VNC)' ;;
--ssh) choice='Terminal (SSH)' ;;
--menu) choice=$(
    zenity --list \
        --title="Connect to OptiPlex 3040" \
        --text="Choose a connection" \
        --column="Connection" \
        --hide-header \
        --width=440 \
        --height=300 \
        "Screen Sharing (VNC)" \
        "Terminal (SSH)" \
        "Connection Test" 2>/dev/null
) || exit 0 ;;
*) printf 'Usage: %s [--vnc|--ssh|--test|--menu]\n' "$0" >&2; exit 2 ;;
esac

case $choice in
    "Screen Sharing (VNC)")
        if ! REMMINA_PROFILE=$(resolve_profile); then
            zenity --error --title="Screen Sharing profile missing" \
                --text="Cannot identify one saved 3040 Mac VNC profile. Check the profiles in Remmina."
            exit 1
        fi
        if ! ready "$MAC_ADDRESS" 5900; then
            zenity --error \
                --title="Screen Sharing unavailable" \
                --text="The OptiPlex 3040 did not answer on port 5900."
            exit 1
        fi
        exec remmina -c "$REMMINA_PROFILE"
        ;;
    "Terminal (SSH)")
        if ! ready "$MAC_ADDRESS" 22; then
            zenity --error \
                --title="SSH unavailable" \
                --text="The OptiPlex 3040 did not answer on port 22."
            exit 1
        fi
        exec gnome-terminal -- ssh "$MAC_HOST"
        ;;
    "Connection Test")
        ssh_state=$(state "$MAC_ADDRESS" 22)
        vnc_state=$(state "$MAC_ADDRESS" 5900)
        zenity --info \
            --title="OptiPlex 3040 connection test" \
            --text="SSH: $ssh_state\nVNC: $vnc_state"
        ;;
esac

#!/bin/bash
# Run as the login user after installing Apple's Xcode app, not as root.
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "$0")" && pwd)

mode=${1:---check}
case "$mode" in
    --check|--install) ;;
    *) printf 'Usage: %s [--check|--install]\n' "$0" >&2; exit 2 ;;
esac
if [ "$(/usr/bin/uname -s)" != Darwin ]; then
    printf 'This script requires macOS.\n' >&2
    exit 1
fi
if [ "$(/usr/bin/id -u)" = 0 ]; then
    printf 'Run as the login user; privileged steps use sudo.\n' >&2
    exit 1
fi

app=${XCODE_APP:-/Applications/Xcode.app}
export DEVELOPER_DIR="$app/Contents/Developer"
if [ ! -x "$DEVELOPER_DIR/usr/bin/xcodebuild" ]; then
    printf 'Install Xcode from the Mac App Store first: %s\n' "$app" >&2
    exit 1
fi

if [ "$mode" = --install ]; then
    # Use full Xcode, not the standalone Command Line Tools directory.
    /usr/bin/sudo /usr/bin/xcode-select --switch "$DEVELOPER_DIR"
    /usr/bin/sudo /usr/bin/xcodebuild -license accept
    /usr/bin/sudo /usr/bin/xcodebuild -runFirstLaunch
    /usr/bin/sudo /usr/sbin/DevToolsSecurity -enable

    # Apple handles existing downloads; retries are bounded, not a watchdog.
    download() {
        local attempt
        for attempt in 1 2 3; do
            if /usr/bin/xcrun python3 "$script_dir/xcode-component-download.py" "$@"; then
                return 0
            fi
            if [ "$attempt" -lt 3 ]; then
                printf 'Download failed; retry %s/3 in 20 seconds.\n' "$((attempt + 1))" >&2
                /bin/sleep 20
            fi
        done
        return 1
    }
    # Explicit SDK versions avoid ambiguous catalog matching after a partial download.
    # Leave architecture selection to Xcode's native host detection.
    download -downloadPlatform iOS -buildVersion "$(/usr/bin/xcrun --sdk iphoneos --show-sdk-version)"
    download -downloadPlatform watchOS -buildVersion "$(/usr/bin/xcrun --sdk watchos --show-sdk-version)"
    download -downloadComponent metalToolchain
fi

/usr/bin/xcodebuild -version
/usr/bin/xcodebuild -checkFirstLaunchStatus
/usr/bin/xcodebuild -showsdks
/usr/bin/xcrun swift --version
/usr/bin/xcrun clang --version
/usr/bin/xcrun git --version
/usr/sbin/DevToolsSecurity -status
/usr/bin/xcrun simctl list runtimes
/usr/bin/xcrun simctl list devices available
/usr/bin/xcrun simctl list pairs
printf '\nmacOS SDK: '
/usr/bin/xcrun --sdk macosx --show-sdk-path
/usr/bin/xcrun metal --version
/usr/bin/xcrun simctl list runtimes -j | /usr/bin/xcrun python3 -c '
import json, sys
runtimes = json.load(sys.stdin)["runtimes"]
missing = []
for platform, version in zip(("iOS", "watchOS"), sys.argv[1:]):
    prefix = "com.apple.CoreSimulator.SimRuntime." + platform + "-"
    if not any(r.get("isAvailable") and r.get("version") == version
               and r.get("identifier", "").startswith(prefix) for r in runtimes):
        missing.append(platform + " " + version)
if missing:
    raise SystemExit("Missing available runtime(s): " + ", ".join(missing))
print("Required iOS and watchOS runtimes are available.")
' "$(/usr/bin/xcrun --sdk iphoneos --show-sdk-version)" "$(/usr/bin/xcrun --sdk watchos --show-sdk-version)"
printf '\nNo OS upgrade, account sign-in, simulator boot or project migration was performed.\n'

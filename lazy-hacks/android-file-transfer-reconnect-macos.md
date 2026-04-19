# Android File Transfer Reconnect on macOS

## Problem
After disconnecting an Android or eink device incorrectly, Android File Transfer may fail to reconnect and show:

```text
Could not connect to device
Try reconnecting or restarting your device.
```

This happened with a Bigme device on macOS.

## What worked
Restart the Mac-side Android File Transfer processes:

```bash
pkill -f 'Android File Transfer' || true
/Users/lachlanchen/Library/Android/sdk/platform-tools/adb kill-server || true
sleep 2
open -a '/Applications/Android File Transfer.app'
```

## What to check next
If the popup still appears:

```bash
ps -ax -o pid,command | grep -i 'Android File Transfer\|adb' | grep -v grep
```

Expected after restart:
- `Android File Transfer`
- `Android File Transfer Agent`

## Notes
- This restarts the app-side pieces only.
- A direct restart of macOS `usbd` may be blocked:

```bash
launchctl kickstart -k system/com.apple.usbd
```

- On a normal user session this can fail with `Operation not permitted`.
- If the app restart is not enough, unplug/replug USB, unlock the device, switch back to file transfer mode, or reboot the device.

# Nutstore Inotify Limit Fix on Ubuntu

This note documents the fix for Nutstore repeatedly asking for sudo permission to "auto-fix" the synced-folder limit on Ubuntu, then showing the same prompt again later.

## Symptom

Nutstore shows a popup like:

```text
The number of synced folders exceeds the system limit and cannot be synced.
Allow Nutstore to auto-fix the issue?
```

Entering the sudo password may appear to work, but the prompt returns. The root cause is not always the watch count alone.

## Root Cause

The useful log line was:

```text
java.io.IOException: User limit of inotify instances reached or too many open files
```

On this workstation, the old Nutstore helper only set:

```text
fs.inotify.max_user_watches=524288
```

It also appended the same line to `/etc/sysctl.conf` every time it ran. That created duplicate config lines and did not raise `fs.inotify.max_user_instances`, which was the actual limit being hit.

## Check Current State

Inspect kernel limits:

```bash
sysctl fs.inotify.max_user_watches \
  fs.inotify.max_user_instances \
  fs.inotify.max_queued_events
```

Find duplicate inotify sysctl lines:

```bash
grep -RIn 'fs\.inotify' /etc/sysctl.conf /etc/sysctl.d 2>/dev/null
```

Check Nutstore logs:

```bash
grep -RInE 'inotify|Failed to create a watch service|too many open files|User limit' \
  ~/.nutstore/logs 2>/dev/null | tail -80
```

Count inotify instances:

```bash
find /proc/[0-9]*/fd -lname anon_inode:inotify 2>/dev/null | wc -l
```

Optional per-process check:

```bash
python3 - <<'PY'
from pathlib import Path
from collections import Counter

counts = Counter()
for fd in Path('/proc').glob('[0-9]*/fd/*'):
    try:
        if fd.resolve().as_posix() == 'anon_inode:inotify':
            pid = fd.parts[2]
            name = Path('/proc', pid, 'comm').read_text().strip()
            counts[(pid, name)] += 1
    except Exception:
        pass

for (pid, name), count in counts.most_common(20):
    print(f'{count:4d} {pid:>8s} {name}')
PY
```

## Persistent Fix

Use a dedicated sysctl file that sorts after `/etc/sysctl.d/99-sysctl.conf`:

```bash
sudo tee /etc/sysctl.d/99zz-nutstore-inotify.conf >/dev/null <<'EOF'
# Nutstore can hit the inotify instance limit before the watch limit,
# especially on a workstation with many Codex/Node/desktop watcher processes.
# Keep this filename lexically after /etc/sysctl.d/99-sysctl.conf.
fs.inotify.max_user_watches = 2097152
fs.inotify.max_user_instances = 4096
fs.inotify.max_queued_events = 65536
EOF

sudo sysctl -p /etc/sysctl.d/99zz-nutstore-inotify.conf
```

Clean old duplicated lines from `/etc/sysctl.conf`:

```bash
sudo cp -a /etc/sysctl.conf \
  "/etc/sysctl.conf.bak.nutstore-inotify.$(date +%Y%m%d-%H%M%S)"

sudo sed -i '/^fs\.inotify\./d' /etc/sysctl.conf
```

Verify only the dedicated file owns these values:

```bash
grep -RIn 'fs\.inotify' /etc/sysctl.conf /etc/sysctl.d 2>/dev/null
```

## Patch Nutstore's Helper

Nutstore's helper may live at:

```text
~/.nutstore/dist/bin/increase_inotify_limit.sh
```

Replace it with an idempotent version:

```bash
#!/bin/bash
set -euo pipefail

CONF=/etc/sysctl.d/99zz-nutstore-inotify.conf

cat > "$CONF" <<'EOF'
# Nutstore can hit the inotify instance limit before the watch limit,
# especially on a workstation with many Codex/Node/desktop watcher processes.
# Keep this filename lexically after /etc/sysctl.d/99-sysctl.conf.
fs.inotify.max_user_watches = 2097152
fs.inotify.max_user_instances = 4096
fs.inotify.max_queued_events = 65536
EOF

sysctl -p "$CONF"
```

Then make it executable:

```bash
chmod +x ~/.nutstore/dist/bin/increase_inotify_limit.sh
```

This prevents the helper from appending duplicate lines to `/etc/sysctl.conf`.

## Restart Nutstore

The simplest safe method is to exit Nutstore from the desktop tray and start it again from the application launcher.

From a terminal, a direct restart is:

```bash
pkill -f 'nutstore-pydaemon.py|/.nutstore/dist/.*nutstore' || true
nohup ~/.nutstore/dist/bin/nutstore-pydaemon.py >/tmp/nutstore-pydaemon.log 2>&1 &
```

If using GNOME RDP/XRDP, starting from the application launcher is often cleaner because it inherits the correct desktop session environment.

## Verify

Check live kernel values:

```bash
sysctl fs.inotify.max_user_watches \
  fs.inotify.max_user_instances \
  fs.inotify.max_queued_events
```

Expected values:

```text
fs.inotify.max_user_watches = 2097152
fs.inotify.max_user_instances = 4096
fs.inotify.max_queued_events = 65536
```

Check Nutstore processes:

```bash
ps -ef | grep -Ei '[n]utstore'
```

Check that fresh logs no longer show inotify failures:

```bash
grep -RInE 'inotify|Failed to create a watch service|too many open files|User limit' \
  ~/.nutstore/logs 2>/dev/null | tail -80
```

## Notes

- Raising these limits increases the allowed maximum; it does not immediately allocate that much memory.
- Nutstore updates may overwrite `~/.nutstore/dist/bin/increase_inotify_limit.sh`, but the persistent sysctl file remains.
- If the popup comes back after an update, inspect the log first. Do not assume `max_user_watches` is the only problem.

# Service-Order Fix For Busy Home Submounts

This note explains a general pattern for reducing shutdown unmount errors when long-running services keep mounted home subpaths busy.

## Problem

Shutdown repeatedly showed errors like:

```text
Failed unmounting /home/lachlan/ProjectsLFS
Failed unmounting /home/lachlan/DiskMech
```

In this pattern, the main cause is often not `fstab` flags. It is service ordering:

- tmux sessions were still alive inside mounted paths
- a separate `pre-shutdown-tmux.service` started too late
- unmount had already begun by the time that shutdown hook fired

## What Usually Does Not Work Well

A dedicated shutdown-triggered service such as `pre-shutdown-tmux.service` is often not reliable enough by itself.

Why:

- it can fire during shutdown, but still too late for the actual busy mount
- command-path mistakes such as a wrong `runuser` path can also make it silently useless

## What Works Better

The more robust approach is to move cleanup into the services that actually create or own the long-running tmux sessions or processes:

- `create-tmux-session.service`
- `lazyedit.service`
- `autopub-monitor.service`

The pattern is:

- start the service only after its required mounts exist
- keep `RemainAfterExit=yes`
- add `ExecStop=...` so systemd stops it before those mounts are unmounted

Because shutdown order is the reverse of startup order, this gives the stop action a better chance to run early enough.

## General Rule

If a service depends on a mounted path:

- start it only after the mount exists
- express that dependency with `After=` and `RequiresMountsFor=`
- keep the service active enough for systemd to stop it later
- put the cleanup in `ExecStop=` on the owning service

This is usually better than adding a separate late shutdown hook.

## Recommended Pattern

### 1. Back Up The Current Unit

```bash
sudo cp /etc/systemd/system/create-tmux-session.service /etc/systemd/system/create-tmux-session.service.bak-$(date +%F-%H%M%S)
sudo cp /etc/systemd/system/lazyedit.service /etc/systemd/system/lazyedit.service.bak-$(date +%F-%H%M%S)
sudo cp /etc/systemd/system/autopub-monitor.service /etc/systemd/system/autopub-monitor.service.bak-$(date +%F-%H%M%S)
```

### 2. Edit The Units

```bash
sudo vim /etc/systemd/system/create-tmux-session.service
sudo vim /etc/systemd/system/lazyedit.service
sudo vim /etc/systemd/system/autopub-monitor.service
```

### 3. Use Mount-Aware Units

`create-tmux-session.service`

```ini
[Unit]
Description=Create TMUX sessions at boot
After=network.target home-lachlan.mount home-lachlan-ProjectsLFS.mount
RequiresMountsFor=/home/lachlan /home/lachlan/ProjectsLFS

[Service]
Type=oneshot
User=lachlan
ExecStart=/bin/bash -c '/home/lachlan/scripts/create_tmux_session.sh'
ExecStop=-/usr/bin/tmux kill-server
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

`lazyedit.service`

```ini
[Unit]
Description=LazyEdit Video Processing
After=network.target home-lachlan.mount home-lachlan-DiskMech.mount
RequiresMountsFor=/home/lachlan /home/lachlan/DiskMech

[Service]
Type=oneshot
RemainAfterExit=yes
User=lachlan
WorkingDirectory=/home/lachlan/DiskMech/Projects/lazyedit
ExecStart=/bin/bash -lc '/home/lachlan/DiskMech/Projects/lazyedit/start_lazyedit.sh'
ExecStop=/bin/bash -lc '/home/lachlan/DiskMech/Projects/lazyedit/stop_lazyedit.sh'

[Install]
WantedBy=multi-user.target
```

`autopub-monitor.service`

```ini
[Unit]
Description=AutoPublish Monitoring and Queue Processing
Wants=network-online.target
After=network-online.target home-lachlan.mount home-lachlan-DiskMech.mount home-lachlan-AutoPublishDATA.mount
RequiresMountsFor=/home/lachlan /home/lachlan/DiskMech /home/lachlan/AutoPublishDATA

[Service]
User=lachlan
Type=forking
ExecStart=/home/lachlan/DiskMech/Projects/autopub-monitor/autopub_monitor/autopub_monitor_tmux_session.sh start
ExecStop=/home/lachlan/DiskMech/Projects/autopub-monitor/autopub_monitor/autopub_monitor_tmux_session.sh stop
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

### 4. Reload And Reenable

```bash
sudo systemctl daemon-reload
sudo systemctl reenable create-tmux-session.service
sudo systemctl reenable lazyedit.service autopub-monitor.service
sudo systemctl restart create-tmux-session.service
sudo systemctl restart lazyedit.service autopub-monitor.service
```

### 5. Disable The Old Late Shutdown Hook

```bash
sudo systemctl disable --now pre-shutdown-tmux.service
```

## How To Verify

Check the installed units:

```bash
systemctl cat create-tmux-session.service
systemctl cat lazyedit.service
systemctl cat autopub-monitor.service
systemd-analyze verify /etc/systemd/system/create-tmux-session.service
systemd-analyze verify /etc/systemd/system/lazyedit.service
systemd-analyze verify /etc/systemd/system/autopub-monitor.service
```

After a reboot, inspect the previous shutdown:

```bash
journalctl -b -1 --no-pager | grep -E 'create-tmux-session|lazyedit|autopub-monitor|Failed unmounting|ProjectsLFS|DiskMech|home-lachlan.mount|umount:'
```

## Example Result On One Machine

After switching to the service-order approach on one workstation:

- `create-tmux-session.service` stopped cleanly
- `lazyedit.service` stopped cleanly
- `autopub-monitor.service` stopped cleanly
- `/home/lachlan/ProjectsLFS` unmounted cleanly
- `/home/lachlan/DiskMech` unmounted cleanly

The remaining failure was only:

- `/home/lachlan` still busy

So this fix solved the service-owned submount unmount problem, but not every possible busy-process issue in the parent home directory.

## Remaining Limitation

Even with correct service ordering, `/home/lachlan` can still fail to unmount if non-service processes are using it, for example:

- desktop session processes
- terminals whose current directory is under the home directory
- file manager windows
- background sync or indexing processes

So this fix is best understood as:

- a good fix for service-owned busy submounts
- not a universal fix for every user-session process under `/home/lachlan`

## Adaptation Notes

To reuse this pattern on another machine:

- replace the mount names in `After=` with your actual systemd mount units
- replace the paths in `RequiresMountsFor=` with your real mountpoints
- replace the start and stop commands with the service's real process owner
- verify the generated unit with `systemd-analyze verify`

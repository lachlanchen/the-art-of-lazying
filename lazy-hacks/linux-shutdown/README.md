# Linux Shutdown Hacks

Practical notes for reducing ugly shutdown and reboot behavior on a workstation with many mounted paths and tmux-managed services.

## Files
- [service-order-fix-for-busy-home-submounts.md](./service-order-fix-for-busy-home-submounts.md)
  - Move tmux cleanup into the real owning services instead of a late shutdown hook
  - Add mount-aware ordering for `create-tmux-session.service`, `lazyedit.service`, and `autopub-monitor.service`
  - Records the result: `/home/lachlan/ProjectsLFS` and `/home/lachlan/DiskMech` unmounted cleanly after the change

## Scope
- Ubuntu with `systemd`
- mounted home subpaths such as `ProjectsLFS` and `DiskMech`
- long-running tmux services that keep mountpoints busy at shutdown

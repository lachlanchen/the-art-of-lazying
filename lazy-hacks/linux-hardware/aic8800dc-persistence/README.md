# AIC8800DC DKMS Persistence Guard

This bundle adds recovery around Ubuntu's normal DKMS integration for the
out-of-tree AIC8800DC USB Wi-Fi driver. It is intended for a machine where the
driver source is already registered under `/usr/src/aic8800dc-VERSION`.

## Install

Keep the correct kernel image and header meta-packages installed, then run:

```bash
sudo ./install.sh
aic8800dc-persistence-verify
```

The installer provides:

| File | Purpose |
| --- | --- |
| `aic8800dc-dkms-ensure` | Idempotently prepare and load the driver for a kernel |
| `aic8800dc-dkms-guard` | Run the ensure command from kernel/header package hooks |
| `aic8800dc-dkms-ensure.service` | Repair a missed current-kernel build during boot |
| `zz-aic8800dc-wifi.conf` | Disable power saving for USB Wi-Fi remote access |
| `verify.sh` | Install the `aic8800dc-persistence-verify` health check |
| `uninstall.sh` | Remove this guard without removing the Wi-Fi driver |

The ensure command discovers the newest registered or staged AIC8800DC source
version. Add and test a reviewed upstream version through DKMS first; the guard
will then use it when a future kernel needs a build.

The NetworkManager override matches `wlx*`, the predictable interface prefix
normally used by USB Wi-Fi adapters. This is suitable for an always-on desktop;
on a battery-powered system it trades some power use for connection stability.

## Failure Behavior

Package hooks warn but return success, so an incompatible out-of-tree driver
does not leave `dpkg` half-configured. The boot service fails visibly in
`systemctl` and `journalctl` if it still cannot build the current kernel. Boot
the previous working kernel and update the pinned driver source in that case.

This guard cannot automatically adapt driver source code to arbitrary future
kernel API changes. It makes missing and interrupted DKMS builds recoverable;
it does not replace compatibility testing.

See the complete installation, Secure Boot, and recovery playbook in
[`../aic8800dc-usb-wifi-ubuntu-24-04.md`](../aic8800dc-usb-wifi-ubuntu-24-04.md).

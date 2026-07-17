# Linux Hardware Notes

Operational notes for workstation hardware that needs small Linux-side fixes.

## Files

- [aic8800dc-usb-wifi-ubuntu-24-04.md](./aic8800dc-usb-wifi-ubuntu-24-04.md)
  - switch the AICsemi dongle from its Windows-driver disk to Wi-Fi mode
  - install a pinned DKMS driver for Ubuntu 24.04 and kernel 6.11
  - verify scans, kernel-update persistence, and rollback
- [usb-camera-rdp-without-logout.md](./usb-camera-rdp-without-logout.md)
  - detect a USB webcam
  - grant immediate RDP-session access without logout/reboot
  - preview the camera with `ffplay`

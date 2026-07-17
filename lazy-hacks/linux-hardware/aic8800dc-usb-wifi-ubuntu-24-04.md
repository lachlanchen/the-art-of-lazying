# AIC8800DC USB Wi-Fi on Ubuntu 24.04

This note records the verified installation for an AICsemi AIC8800DC USB Wi-Fi
adapter on the `OptiPlex-3040`.

## Validated Result

| Item | Value |
| --- | --- |
| Host | Dell OptiPlex 3040 |
| OS | Ubuntu 24.04.4 LTS, x86-64 |
| Kernels | `6.11.0-17-generic` and `7.0.0-28-generic` |
| Storage-mode USB ID | `a69c:5721` (`aicsemi Aic MSC`) |
| Wi-Fi-mode USB ID | `a69c:88dc` (`AICSemi AIC8800DC`) |
| Driver | `aic8800dc/6.4.3.0-patched.5` through DKMS |
| Pinned source | `Kiborgik/aic8800dc-linux-patched` commit `de3c580` |
| Secure Boot | Disabled on the validated host |

After installation:

- `aic8800_fdrv` owned the USB interface
- NetworkManager exposed a normal Wi-Fi device
- the adapter was not soft-blocked or hard-blocked
- an active scan found 15 nearby networks
- the driver's test script passed all 11 checks
- DKMS registered an automatic rebuild for future kernel packages
- kernel and header hooks retry a missed DKMS build
- a boot service repairs the running kernel before NetworkManager starts
- a controlled reboot into kernel 7.0 restored Wi-Fi and internet automatically
- removing the inactive 6.11 kernel's complete DKMS build state was repaired
  automatically from the registered source

No Wi-Fi credential is stored in this playbook.

## Why It Initially Looks Like a Disk

The dongle first exposes a small Windows-driver disk:

```text
ID a69c:5721 aicsemi Aic MSC
```

In that state, `lsusb -t` reports `Driver=usb-storage` and no wireless
interface appears. Ejecting or mode-switching the virtual disk makes the real
device enumerate as:

```text
ID a69c:88dc AICSemi AIC8800DC
```

The installed udev rule automatically runs `eject` when the storage-mode device
is inserted. For a manual first switch:

```bash
sudo usb_modeswitch -v a69c -p 5721 -KQ
sleep 3
lsusb
```

If the virtual disk has a block device, ejecting that device also works:

```bash
lsblk -o NAME,TRAN,VENDOR,MODEL,SIZE,MOUNTPOINTS
sudo eject /dev/sdX
```

Replace `/dev/sdX` only after identifying the small AIC USB disk. Never guess a
disk name on a machine with important storage.

## Preflight

Identify the adapter and running kernel before installing a driver:

```bash
lsusb
lsusb -t
uname -r
lsb_release -ds
mokutil --sb-state
test -d "/lib/modules/$(uname -r)/build" && echo headers-present
```

This is an out-of-tree community driver. Review and pin the source revision.
Do not run an unreviewed moving branch as root.

## Install the Pinned Driver

Install the build and mode-switch dependencies:

```bash
sudo apt-get update
sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y \
  dkms build-essential git linux-headers-"$(uname -r)" eject usb-modeswitch
```

Clone the reviewed source and detach at the validated commit:

```bash
mkdir -p ~/Projects
git clone https://github.com/Kiborgik/aic8800dc-linux-patched.git \
  ~/Projects/aic8800dc-linux-patched
cd ~/Projects/aic8800dc-linux-patched
git checkout --detach de3c5802f9457ce565c27ede10a77da955d39e3e
git rev-parse HEAD
git status --short --branch
```

The repository's shell files are not executable in this revision, so invoke the
audited installer through Bash:

```bash
sudo bash ./install.sh
```

The installer copies the AIC8800DC firmware, installs the storage-mode udev
rule, registers and builds two DKMS modules, creates a boot module list, and
loads the driver immediately:

```text
aic_load_fw
aic8800_fdrv
```

## Complete Secure Boot Enrollment

Skip this section when `mokutil --sb-state` reports that Secure Boot is
disabled. With Secure Boot enabled, Ubuntu's DKMS setup generates a local
signing key and the installer asks for a temporary enrollment password. That
password must contain 8 through 16 characters and must not be stored in a
script, repository, or shell argument.

The modules are installed but the kernel rejects them until the new Machine
Owner Key is enrolled. Confirm the expected pending state before reboot:

```bash
dkms status -m aic8800dc
modinfo -F signer aic8800_fdrv
mokutil --test-key /var/lib/shim-signed/mok/MOK.der || true
find /sys/firmware/efi/efivars -maxdepth 1 \
  -type f -name 'MokNew-*' -print
```

The 7090 preinstallation on kernel `6.17.0-35-generic` produced:

```text
aic8800dc/6.4.3.0-patched.5, 6.17.0-35-generic, x86_64: installed
signer: OptiPlex-7090 Secure Boot Module Signature key
MokNew: present
```

Do not reboot a remote-only computer unexpectedly. UU, RDP, and SSH cannot
control the pre-boot MOK manager. At the machine with a physical display and
keyboard:

1. Reboot and press a key when the blue MOK management prompt appears.
2. Select `Enroll MOK`.
3. Select `Continue`, then confirm with `Yes`.
4. Enter the temporary enrollment password created during installation.
5. Select `Reboot`.

After Ubuntu starts, verify trust and load the modules:

```bash
mokutil --test-key /var/lib/shim-signed/mok/MOK.der
sudo modprobe aic_load_fw
sudo modprobe aic8800_fdrv
lsmod | grep -E '^aic'
```

If the key is not enrolled, do not disable signature enforcement or copy an
unsigned module into the kernel tree. Queue the signed certificate again and
repeat the physical enrollment:

```bash
sudo mokutil --import /var/lib/shim-signed/mok/MOK.der
```

Use a new temporary 8-to-16-character password when prompted.

## Verify

Run the repository checks without root; every line should pass:

```bash
cd ~/Projects/aic8800dc-linux-patched
bash ./test.sh
```

Verify the live device and kernel binding:

```bash
lsusb
lsusb -t
dkms status -m aic8800dc
lsmod | grep -E '^aic|cfg80211'
modinfo -F filename aic_load_fw
modinfo -F filename aic8800_fdrv
ip -br link
nmcli -f DEVICE,TYPE,STATE,CONNECTION device status
rfkill list
```

Expected high-signal results include:

```text
ID a69c:88dc AICSemi AIC8800DC
Driver=aic8800_fdrv
aic8800dc/6.4.3.0-patched.5, <kernel>, x86_64: installed
```

An SSH session may not have NetworkManager permission to request a scan as the
desktop user. Trigger only the scan with `sudo`, then display results normally:

```bash
iface="$(nmcli -t -f DEVICE,TYPE device status | sed -n 's/:wifi$//p' | head -n 1)"
sudo nmcli device wifi rescan ifname "$iface"
nmcli device wifi list ifname "$iface"
```

## Connect Without Leaking the Password

Use NetworkManager's interactive prompt so the Wi-Fi password does not enter
shell history or a process argument:

```bash
iface="$(nmcli -t -f DEVICE,TYPE device status | sed -n 's/:wifi$//p' | head -n 1)"
nmcli --ask device wifi connect "YOUR_SSID" ifname "$iface"
```

Keep the wired connection active during the first Wi-Fi test so remote SSH and
RDP access are not lost.

## Kernel Updates and Reboots

The installed DKMS state should look like:

```bash
dkms status -m aic8800dc
```

`AUTOINSTALL=yes` and Ubuntu's DKMS kernel hook rebuild the modules when a new
kernel is installed. Before rebooting into a new kernel, verify its entry:

```bash
dkms status -m aic8800dc
```

After reboot, repeat `lsusb -t`, `dkms status`, `nmcli device status`, and a
scan. The udev rule should switch `a69c:5721` to `a69c:88dc` automatically.

### Install the Persistence Guard

Ubuntu's normal DKMS hooks remain the primary update mechanism. Install this
repository's additional guard to cover kernels that were installed before the
driver, interrupted package configuration, and missing module files at boot:

```bash
cd ~/Projects/the-art-of-lazying/lazy-hacks/linux-hardware/aic8800dc-persistence
sudo ./install.sh
aic8800dc-persistence-verify
```

The installer adds three idempotent recovery paths:

- `/etc/kernel/postinst.d/aic8800dc-dkms-guard` runs after a kernel package
- `/etc/kernel/header_postinst.d/aic8800dc-dkms-guard` retries when its headers
  become available
- `aic8800dc-dkms-ensure.service` verifies or repairs the running kernel before
  NetworkManager starts on every boot
- `zz-aic8800dc-wifi.conf` disables power saving for USB Wi-Fi and the installer
  also persists that setting on the currently active AIC8800DC profile

The shared `aic8800dc-dkms-ensure` command locks concurrent invocations,
discovers the highest registered or staged driver version, builds only when the
current kernel lacks the modules, runs `depmod`, and loads both modules for the
running kernel. This version discovery means a deliberately reviewed driver
update does not require editing the recovery script.

Check the installed mechanism and its last boot log:

```bash
aic8800dc-persistence-verify
systemctl status aic8800dc-dkms-ensure.service --no-pager
journalctl -b -u aic8800dc-dkms-ensure.service --no-pager
```

Remove only the extra guard, leaving the driver and firmware installed:

```bash
sudo ./uninstall.sh
```

The HWE image and header meta-packages must remain installed so future kernels
arrive with matching build headers:

```bash
dpkg-query -W linux-generic-hwe-24.04 linux-headers-generic-hwe-24.04
```

This automation cannot make an incompatible driver compile against every
future kernel API. When a build fails, the package hook emits a warning without
leaving `dpkg` broken, the boot service records a visible failure, and GRUB's
previous working kernel remains the recovery path. Review and pin a compatible
upstream driver revision before replacing the validated source.

### Validated Recovery Test

The 3040 was rebooted after installing the guard. On that clean boot, the
service completed before NetworkManager, the adapter switched to `a69c:88dc`,
the saved Wi-Fi profile connected, and traffic reached both the router and the
internet through the Wi-Fi interface.

The full DKMS state for the inactive 6.11 kernel was then removed and recovered
to exercise the same path as a newly installed kernel:

```bash
sudo dkms remove -m aic8800dc -v 6.4.3.0-patched.5 \
  -k 6.11.0-17-generic
sudo aic8800dc-dkms-ensure 6.11.0-17-generic
```

The guard compiled, signed, installed, and indexed both modules. `modinfo -k`
and `dkms status` confirmed the restored installation. Only use this test with
an inactive kernel while a separate working network path is available; do not
remove the running kernel's sole remote-access driver.

## Wi-Fi Missing After Booting a Different Kernel

This happened once on the 3040 and was not a MOK or mode-switch failure. The
adapter had already changed to `a69c:88dc`, but the computer booted
`7.0.0-28-generic` while DKMS contained modules only for the previously running
`6.11.0-17-generic` kernel. `lsusb -t` therefore showed `Driver=[none]` and
`modinfo aic8800_fdrv` could not find a current-kernel module.

Confirm the mismatch:

```bash
uname -r
lsusb
lsusb -t
dkms status -m aic8800dc
modinfo -F filename aic8800_fdrv
```

Build and load the driver for the kernel that is running:

```bash
version=6.4.3.0-patched.5
kernel="$(uname -r)"
sudo dkms build -m aic8800dc -v "$version" -k "$kernel"
sudo dkms install -m aic8800dc -v "$version" -k "$kernel"
sudo modprobe aic_load_fw
sudo modprobe aic8800_fdrv
```

Then verify:

```bash
dkms status -m aic8800dc
lsusb -t
nmcli device status
```

The current kernel must have its own `installed` DKMS line. The 3040 then
completed a controlled reboot test: the udev rule switched the adapter within
one second, both modules loaded, NetworkManager autoconnected the saved profile,
Wi-Fi obtained an address, and traffic reached the internet through that
interface.

This one-time mismatch can occur when another kernel was already installed
before the driver was first registered with DKMS. Ubuntu's existing
`/etc/kernel/postinst.d/dkms` hook handles later kernel package installations;
the persistence guard above also repairs this case during boot.

## Update Deliberately

Do not blindly install the newest branch as root. Review changes, record the new
commit, and test it against the currently running and next installed kernels:

```bash
cd ~/Projects/aic8800dc-linux-patched
git fetch origin
git log --oneline --decorate de3c580..origin/main
git diff --stat de3c580..origin/main
```

After selecting and reviewing a replacement commit:

```bash
git checkout --detach COMMIT_SHA
sudo bash ./install.sh
bash ./test.sh
```

## Remove or Roll Back

The bundled uninstaller removes the modules, every `aic8800dc` DKMS
registration, copied firmware, udev rule, and boot module list:

```bash
cd ~/Projects/aic8800dc-linux-patched
sudo bash ./uninstall.sh
```

Then verify:

```bash
dkms status -m aic8800dc
lsmod | grep -E '^aic' || true
```

## Security and Support Boundary

The driver is not part of Ubuntu's mainline kernel and loading it taints the
kernel as an out-of-tree module. The validated host has Secure Boot disabled.
With Secure Boot enabled, the DKMS modules must be signed by an enrolled Machine
Owner Key before the kernel will load them.

Primary source used for this deployment:

- [Kiborgik/aic8800dc-linux-patched](https://github.com/Kiborgik/aic8800dc-linux-patched)

Keep the pinned checkout and the bundled uninstaller until the adapter has been
tested after at least one kernel update.

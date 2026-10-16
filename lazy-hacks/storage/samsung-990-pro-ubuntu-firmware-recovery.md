---
id: 3911
title: "Recovering a Samsung 990 PRO on Ubuntu: Firmware, Backup, and ext4 Repair"
slug: "samsung-990-pro-ubuntu-firmware-recovery"
status: "publish"
source_language: "en"
categories:
  - Storage & Disk
tags:
  - Ubuntu
  - NVMe
  - Samsung 990 PRO
  - LVM
  - ext4
  - Data Recovery
excerpt: "A Samsung 990 PRO disappeared under Linux and left an LVM project volume unreadable. This case follows the firmware update, a 2.455 TB recovery copy, and the separate ext4 repair needed to restore access."
---

A shell startup script failed with `Input/output error`. Project directories still appeared in file listings, but opening their files failed. The underlying Samsung 990 PRO 4 TB had stopped responding: Linux reported a dead NVMe controller and a capacity of zero bytes.

The recovery on 6 September 2026 involved more than installing new firmware. The SSD first had to become visible again. Both 990 PRO drives were then updated with Samsung's official package, and the new firmware was verified after reboot. A recovery copy saved 2.455 TB of files. Finally, offline ext4 repair resolved the filesystem inconsistencies left behind, and 64 files that had failed during the copy were recovered and checked against their backup copies.

Normal project access returned that day. The evidence supports that result; it does not establish which component caused the original controller failure or prove that the SSD can never fail again.

This tutorial explains the decisions and commands behind the recovery. Device names, mount paths, serial numbers, and UUIDs in the examples must be replaced with the values from the machine being repaired. The incident's firmware version is a historical reference, not a recommendation to install that version on every Samsung drive.

## What failed

The first useful distinction was between a missing file and an unavailable storage device. An incorrect path normally produces `No such file or directory`. This incident produced `Input/output error` across unrelated projects on the same filesystem.

The kernel records showed the failure progressing through several layers:

| Layer | Observation | Consequence |
| --- | --- | --- |
| PCIe / NVMe | Requests timed out; a controller reset failed with `-19`; PCIe AER reported uncorrectable non-fatal events | Linux could no longer communicate reliably with the SSD |
| Block device | Controller state became `dead`; capacity was reported as `0B` | Reads and writes to partitions on that SSD failed |
| LVM | The project LV depended on seven partitions of the same SSD | All seven segments shared the same physical failure |
| ext4 | Inode, journal, and superblock I/O failed | File access failed, and interrupted writes could leave inconsistent metadata |

The seven LVM physical volumes were seven partitions, not seven independent disks. They formed one linear logical volume of about 3.2 TiB. The most recently added partition increased capacity on the same SSD; removing it would not remove the dependency on the failed controller.

Directory names could still be visible from cached metadata. That made the situation look less severe than it was. Successful file reads, rather than a successful `ls`, were needed to establish whether a backup could run.

## Identify the drive before trying to repair anything

Start with a short inventory and the kernel log:

```bash
lsblk -e 7 -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,MODEL,SERIAL
findmnt -o TARGET,SOURCE,FSTYPE,OPTIONS
sudo journalctl -k -b --no-pager |
  grep -Ei 'nvme|pcie|aer|I/O error|EXT4-fs|JBD2'
```

After a reboot, use `journalctl -k -b -1` for the previous boot if persistent logs are available. Save the relevant interval on a different physical disk. Logs written to the failing project volume may themselves be lost or unreadable.

Controller identity and state are also available through sysfs:

```bash
for ctrl in /sys/class/nvme/nvme*; do
  [ -r "$ctrl/model" ] || continue
  printf '\n%s\n' "${ctrl##*/}"
  for field in model serial firmware_rev state; do
    printf '%s: ' "$field"
    cat "$ctrl/$field"
  done
done
```

Record the serial number, model, firmware revision, and PCI address. Device numbering is temporary: in this recovery the affected SSD changed NVMe number after reboot. A command aimed at yesterday's `/dev/nvme0` could therefore reach a different drive today. Sysfs identity strings may also contain trailing spaces; scripts comparing them should trim those spaces.

When the controller is live, `nvme-cli` provides more detail:

```bash
# Replace this with the controller verified by model and serial above.
CTRL=/dev/nvmeX

sudo timeout 20 nvme id-ctrl "$CTRL"
sudo timeout 20 nvme smart-log "$CTRL"
sudo timeout 20 nvme fw-log "$CTRL"
sudo timeout 20 nvme error-log "$CTRL" --log-entries=8
```

The time bounds keep ordinary failed queries from running indefinitely; they cannot guarantee that a process blocked in kernel I/O will exit promptly. If the controller is absent or dead, repeated scans and resets are unlikely to help preserve data. A firmware utility cannot update a device that the OS cannot reach.

The recovered drive later reported zero SMART critical warnings and zero media/data-integrity errors. Those readings did not invalidate the earlier kernel evidence. SMART counters and a PCIe/controller failure describe different parts of the storage path.

## Keep the failure from blocking the next boot

In this workstation, the operating system and home directory were on separate physical SSDs. That allowed the project filesystem to remain offline while the machine was still accessible remotely.

The affected project's `/etc/fstab` entry was backed up and temporarily commented out, then systemd was reloaded:

```bash
sudo cp -a /etc/fstab /etc/fstab.before-storage-recovery
sudoedit /etc/fstab
sudo systemctl daemon-reload
```

Only the affected entry was changed. This prevents the normal boot mount; it does not remove the partition, disable NVMe discovery, or erase LVM metadata. It also does not unmount an already-mounted filesystem.

Applications that normally write beneath that mount point should stay stopped. Otherwise they may create files in the empty underlying directory on the root or home filesystem, producing a second set of files that becomes hidden when the real volume is mounted again.

Before rebooting a remotely managed machine, check the boot disk and keep a working SSH or console route. Unsaved editor buffers need to be saved to healthy storage. A reboot may restore a controller, but it also removes volatile caches and closes applications.

## Preserve the storage layout as well as the files

The recovery records included partition-table dumps, `/etc/fstab`, and LVM's existing backup/archive files. They explained how the volume was assembled even while its files could not be read.

For a responsive disk, these are examples of metadata capture:

```bash
# EVIDENCE must be a directory on a different, healthy physical disk.
EVIDENCE=/path/on/healthy-storage/recovery-record
DISK=/dev/nvmeXn1

mkdir -p "$EVIDENCE"
sudo sfdisk --dump "$DISK" > "$EVIDENCE/partition-table.sfdisk"
sudo cp -a /etc/fstab "$EVIDENCE/"
sudo cp -a /etc/lvm/backup /etc/lvm/archive "$EVIDENCE/"
```

While the controller was dead, the available in-memory device-mapper mapping and existing LVM records were used instead of repeatedly scanning the unavailable device. Once it returned, the mapping could be checked with `lvs --segments -o lv_name,vg_name,segtype,devices`.

These small metadata copies are not backups of project contents. Restoring an older partition table or LVM configuration without checking the filesystem's current size can make a recently expanded volume inaccessible. No partition deletion, LV shrink, `vgreduce --removemissing`, or format was part of this repair.

## Why firmware was a reasonable lead

The SSD reappeared after a later restart, before it was flashed. It again reported its full capacity and the original running firmware, `0B2QJXG7`. That return of visibility cannot be attributed to a firmware update that had not happened yet.

Samsung's [990 PRO firmware download page](https://semiconductor.samsung.com/consumer-storage/support/tools/) lists two relevant changes: `7B2QJXD7` addressed intermittent non-recognition, and `8B2QJXD7` improved read-operation stability. These notes made the official update worth investigating. They did not distinguish firmware from a power, controller, motherboard, or PCIe fault in this particular machine.

Both installed Samsung 990 PRO 4 TB drives were accepted by the official updater. The two Predator GM7000 drives were left unchanged because no matching update had been verified. A similar product name or a newer-looking revision string is not enough reason to force a firmware image onto a drive.

### Back up first when the device is readable

Samsung's [firmware utility manual](https://semiconductor.samsung.com/resources/user-manual/Firmware_Update_Utility_UserManual.pdf) calls for a backup before updating. Stable power and uninterrupted access to the target are also essential.

In this incident, the firmware update took place before the full file backup. That was a recovery risk, not a step to copy as standard practice. The metadata snapshots saved beforehand would not have recovered project data if flashing had failed. When a failing drive is readable, prioritize irreplaceable files or a recovery image on independent storage. If reads repeatedly fail or the device drops offline again, consider controlled imaging or professional recovery before attempting a long file walk.

## The official firmware package and the Linux method used

The package used was:

```text
Samsung_SSD_990_PRO_8B2QJXD7.iso
Size: 52,428,800 bytes
SHA-256: f05508f3228960fc1501fe5a27d3a826377332afc8c021aac44487c8fd1c93d5
```

That SHA-256 is the locally recorded digest of the HTTPS download, not a separately published Samsung checksum. The [download page](https://semiconductor.samsung.com/consumer-storage/support/tools/) should remain the starting point for choosing a package.

Samsung documents a bootable update environment. The incident used an advanced alternative: extracting the official Linux utility from that environment and running it directly on Ubuntu. This avoided rebooting into the updater, but still required a later reboot to activate the new firmware. It is an observed method for this package and workstation, not a promise of vendor support for arbitrary host distributions.

The ISO contained a gzip-compressed `initrd`; its archive contained `root/fumagician/fumagician` with the matching `8B2QJXD7.enc` and `DSRD.enc` files. The following commands show how to inspect that exact package without executing it. They require `7z`, `gzip`, and `cpio`, and should run as an ordinary user in a new directory on healthy storage:

```bash
ISO=/path/to/Samsung_SSD_990_PRO_8B2QJXD7.iso
WORK=/path/on/healthy-storage/samsung-update-inspection

mkdir -p "$WORK"
sha256sum "$ISO"
7z l "$ISO"
7z e "$ISO" initrd -o"$WORK"
file "$WORK/initrd"
gzip -dc "$WORK/initrd" > "$WORK/initrd.cpio"
cpio -it < "$WORK/initrd.cpio" | grep fumagician
```

If the listing matches those paths, the utility files can be extracted into a fresh subdirectory:

```bash
mkdir "$WORK/extracted"
(
  cd "$WORK/extracted" || exit
  cpio -id --no-absolute-filenames 'root/fumagician/*' < "$WORK/initrd.cpio"
)
file "$WORK/extracted/root/fumagician/fumagician"
sed -n '1,100p' "$WORK/extracted/root/fumagician/fumagician.sh"
```

Inspecting the wrapper mattered. In this package, `fumagician.sh` invokes the updater and normally follows it with a forced reboot. Running that wrapper inside a working remote desktop would have been an avoidable disruption.

Before execution, every filesystem and swap device backed by either target Samsung SSD was checked. The project volumes were already unmounted; a separate Trash filesystem on the other Samsung was unmounted normally. Busy mounts were not forced or lazily detached. Root and home remained available on the other drives.

Only after those checks, the binary was launched interactively from the directory containing its matching payload files:

```bash
# Firmware-writing step: only after backup, target-identity checks,
# and confirming no filesystem or swap on either target is in use.
cd "$WORK/extracted/root/fumagician" || exit
sudo ./fumagician
```

The updater enumerated the Samsung devices and displayed their identities. Each serial was checked before its confirmation. It reported completion for both drives and exited successfully. No automatic “yes,” raw `nvme fw-download`, cross-model payload, or forced reboot was used. The original partition tables compared byte-for-byte equal afterward.

## Verify activation, not just a successful flash

Immediately after flashing, the two kinds of firmware evidence disagreed in a useful way:

| Check | Immediately after flashing | After the planned reboot |
| --- | --- | --- |
| `nvme id-ctrl` running revision | `0B2QJXG7` | `8B2QJXD7` |
| `nvme fw-log` slot 1 | `8B2QJXD7` | `8B2QJXD7` |
| Active Firmware Info in the saved record | `17` (`0x11`), with activation pending | `1`, with slot 1 active |

The payload had been written before the running firmware changed. Both drives reported the new running revision after the reboot. Reflashing merely because `id-ctrl` still showed the old version before activation would have repeated an already completed operation.

After any required restart, identify the drives by serial again, repeat the health and firmware queries, and inspect the new boot's kernel log. In this case, all four NVMe controllers were live, both Samsungs ran the new firmware, and no new matching controller resets appeared in the checked interval.

## Make a recovery copy without silently replacing the old backup

The project LV was first mounted at a separate recovery path:

```bash
SOURCE_LV=/dev/mapper/vg_projects-lv_projects
sudo mkdir -p /mnt/projects-recovery
sudo mount -t ext4 -o ro,noload,nosuid,nodev,noexec \
  "$SOURCE_LV" /mnt/projects-recovery
findmnt --mountpoint /mnt/projects-recovery
```

For ext4, `ro` alone can still allow journal replay. `ro,noload` prevents that replay, preserving the recovery view without those writes. The tradeoff is that pending journal transactions have not been applied, so the visible filesystem can remain inconsistent. The [kernel's ext4 documentation](https://docs.kernel.org/admin-guide/ext4.html) explains both behaviors. This is a rescue view, not a normal operating mount.

An 8 TB portable SSD already held an older backup. The recovery copy retained everything there and added only missing paths. The source and destination mount identities were checked before copying, and the destination had enough free space for a conservative estimate of the transfer.

The command below captures that policy. `BACKUP_ROOT` must already be the verified mounted portable disk, not merely an empty directory left behind after an unplug:

```bash
BACKUP_ROOT=/mnt/backup-disk
mountpoint -q "$BACKUP_ROOT" || exit 1
findmnt --mountpoint "$BACKUP_ROOT"
df -h "$BACKUP_ROOT"

sudo rsync -aHAXxS --numeric-ids --ignore-existing \
  --partial-dir=.rsync-partial \
  --bwlimit=200M --info=progress2,stats2 \
  /mnt/projects-recovery/ "$BACKUP_ROOT/BackupProjects/"
```

`--ignore-existing` leaves files already present at the destination alone. It also skips an older or damaged destination file if that file already occupies the same path. Archive mode can still update directory metadata. The result is a collection that retains the backup's existing file versions, not an exact snapshot of the current source. This distinction follows the [rsync manual](https://download.samba.org/pub/rsync/rsync.1).

For this Linux-to-ext4 copy, the other options retained hardlinks, ACLs, extended attributes, numeric ownership, and sparse regions; `-x` kept the walk within the source filesystem. Partial transfers used a separate directory. There was no `--delete`, `--inplace`, or source removal.

The actual job ran once in a transient systemd service, with an exclusive lock, low priority, a bandwidth limit, logs, and no automatic restart. That let the copy survive a terminal disconnect without creating a recurring background job.

The large pass transferred **2.455 TB**, then ended with rsync exit **23** and **64 unreadable paths**. Those failures were retained in the report. A finished process and a large byte count were not sufficient to call the backup complete.

## Why filesystem repair was still necessary

The new firmware did not clear the filesystem's pending journal or inconsistent bookkeeping. In the rescue view, ext4 reported inode checksum errors, and rsync could not stat the 64 paths. The superblock still recorded errors and `needs_recovery`.

Before any filesystem changes, the rescue mount was normally unmounted. The original 1 GiB journal and filesystem records were saved on healthy storage. Each repair stage used a separate undo file. An e2fsck undo file saves overwritten blocks; it is not a full backup and cannot undo a power or system crash.

This was the initial offline repair command, shown as a historical execution example:

```bash
# SOURCE_LV must be unmounted. HEALTHY_RECORD must be on another disk.
# This command writes filesystem repairs; it is not a diagnostic-only scan.
sudo e2fsck -f -p -v -C 1 \
  -E fixes_only,nodiscard \
  -z "$HEALTHY_RECORD/metadata.e2undo" "$SOURCE_LV"
```

The `-p` pass repaired what it could handle automatically and stopped with exit **4** on a corrupted orphan-inode list. An offline `-n` check then assessed the remaining issues without accepting repairs. The three orphan-list inodes were individually inspected: all had zero hard links, and their metadata and contents were saved before the reviewed repair continued.

A final preen pass completed all five passes and exited **1**, meaning errors were corrected. The superblock was clean, the journal was empty, and `needs_recovery` had cleared. The [e2fsck manual](https://man7.org/linux/man-pages/man8/e2fsck.8.html) documents the options and exit codes; a nonzero result must be interpreted rather than treated uniformly as success or failure.

One operational mistake is worth retaining: an interactive check launched through a logging wrapper inherited closed heredoc input. It accepted an initial default at EOF and later stalled. That exact process was interrupted gracefully. Interactive recovery tools need a real terminal for stdin; EOF is not a reviewed answer. A blanket `-y` was not used to bypass the questions.

All 64 earlier failed paths became readable after journal replay and repair. Their contents totalled **3,813,592 bytes**. A targeted copy transferred those exact missing files, returned exit 0, and SHA-256 comparisons matched every destination file.

That resolved the recorded failures. It did not retroactively turn the original rsync exit 23 into exit 0 or verify every same-path file retained from the older backup. The reported `0 bad blocks` from e2fsck also did not represent a new hardware surface scan; no such scan was performed.

## Restore normal access only after those checks

The clean filesystem was mounted at its normal project path. Previously unreadable files opened again. A small temporary file tested create, write, `fsync`, and read as the ordinary user, then only that test file was removed.

The restored boot-mount configuration used the filesystem UUID, with options chosen for a nonessential project volume. An equivalent example is:

```fstab
UUID=REPLACE_WITH_PROJECTS_FILESYSTEM_UUID /srv/projects ext4 nosuid,nodev,nofail,errors=remount-ro,x-systemd.device-timeout=10s 0 2
```

Here `nofail` allows boot to continue without this data mount; the device timeout limits waiting for an absent device; and `errors=remount-ro` requests a read-only fallback if ext4 detects errors. These options do not fix hardware or guarantee successful mounting. Projects that require the volume should check it is actually mounted before writing.

After reviewing the entry and its mount point:

```bash
sudo findmnt --verify
sudo systemctl daemon-reload
findmnt --mountpoint /srv/projects
```

The workstation's project mount was restored without another desktop restart. No partition or LVM capacity had to be removed. The independent backup remained available.

## What this recovery established

By the end of the work, both Samsung drives were running `8B2QJXD7`, the project filesystem had passed its final repair, the 64 recorded copy failures had been recovered and hash-checked, and normal read/write access worked again. The checked recovery intervals showed no new matching NVMe reset or storage I/O errors.

The original controller disappearance remained unexplained at the component level. Firmware was a relevant intervention, but the drive had also been through power/boot transitions, and the filesystem needed its own repair. Retaining the backup and a migration option was more defensible than treating a clean SMART report as a permanent cure.

If the controller disappears again, save the new kernel error interval and the drive's identity before restarting. Compare those records with the earlier PCIe and NVMe failures. A recurrence after verified firmware activation would warrant renewed investigation of the SSD, its slot, power, and cooling, rather than another blind flash of the same package.

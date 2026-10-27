# Grow a mounted Projects volume onto a second NVMe SSD

A full Projects filesystem was expanded from about 3.2 TiB to 4.5 TiB without
unmounting it. Available space rose from 2.4 GiB to about 1.3 TiB and usage fell
from 100% to 70%. The operation added roughly 1.37 TiB from the unallocated
tail of a second 4 TB SSD. Existing partition boundaries, Home, boot filesystems
and fstab were preserved.

This differs from the earlier [same-disk expansion](online-lvm-expansion-and-capacity-audit.md).
A linear LV spanning two disks has no redundancy: both disks are now required.
The expansion adds capacity; it does not migrate data away from the original
SSD or turn the volume into a mirror.

## Check identity and health before choosing capacity

Use model and serial identity, partition boundaries, filesystem signatures and
LVM mappings together. An unmounted filesystem can still hold a complete OS
or user data. An apparently spare 2 TB drive in this case contained the current
root, EFI and boot filesystems, so it was preserved.

Both Samsung 990 PROs had already received the official 8B2QJXD7 firmware.
They reported zero critical warnings and media errors. The new source completed
a short NVMe self-test successfully, and bounded read-only samples of its free
tail succeeded. Corrected PCIe receiver errors still appeared on its upstream
link; there were no fatal/uncorrectable link counts or storage I/O errors in
the checked evidence. Those corrected errors remain a reason to monitor the
connection and retain backups. A successful firmware update and self-test do
not prove permanent hardware reliability.

The [firmware recovery case](samsung-990-pro-ubuntu-firmware-recovery.md) covers
the earlier failure and the separate filesystem repair it required.

## Perform the smallest allocation change

1. Record the mounted filesystem UUID, existing LV segment map and all device
   identities. Verify the filesystem is writable and has no recorded live
   errors.
2. Save GPT and LVM metadata on a separate disk. Save fstab and before/after
   reports as well. These records do not replace a project-data backup.
3. Create one aligned partition entirely within the verified unallocated tail.
   Compare every older partition record with the snapshot before proceeding.
4. If the kernel has not discovered it, add only the new partition with
   `partx --add --nr <number> <disk>`. Do not force a full partition-table
   reread or unmount busy filesystems.
5. Check the new partition for signatures and holders. Stop on unexpected
   contents instead of using force options. Initialize only that partition
   with `pvcreate`, then add it to the intended VG.
6. Obtain its exact free extent count. Test `lvextend`, then extend the intended
   LV with that count and an explicit new-PV argument. This prevents consuming
   unrelated VG free space.
7. Grow the mounted ext4 filesystem with `resize2fs`, then verify the resulting
   block count, mount UUID, old segment mapping and owner-level file access.

The [LVM lvextend manual](https://man7.org/linux/man-pages/man8/lvextend.8.html)
documents allocation from specified PVs. The
[kernel ext4 guide](https://docs.kernel.org/admin-guide/ext4.html)
describes online growth with resize2fs. Neither command makes an unsafe source
disk reliable, and filesystem checks must not be run against an actively
mounted writable ext4 filesystem.

## Verify the actual result

The recorded operation preserved all seven old LV segments and appended one
segment on the new PV. It retained the filesystem UUID, fstab and all other
LVs. A temporary file was written, fsynced, read back and removed as the normal
user. Live ext4 error counters and both drives' media-error counters stayed
zero. The kernel logged only the expected resize operations during the change.

The resulting VG has eight PV partitions across two physical SSDs. Two other
roughly 465 GiB partitions and about 431 GiB of separate SATA free space were
left untouched. Root, Home and alternate OS partitions were not repurposed.

Keep the new metadata snapshot as the current structural record. Restoring
pre-expansion partition or VG metadata would truncate the mapping of a larger
filesystem. Removing a disk later requires a separate migration with enough
destination capacity; it is not an inverse `vgextend` operation.

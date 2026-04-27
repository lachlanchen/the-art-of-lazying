# USB Camera in Ubuntu RDP Without Logout

This note records the practical fix for using a USB webcam from an already-running Ubuntu RDP/XRDP desktop session.

## Observed Device

On this workstation, the camera was detected as:

```text
Logitech C922 Pro Stream Webcam
USB ID: 046d:085c
```

Linux exposed:

```text
/dev/video0
/dev/video1
/dev/media0
```

`/dev/video0` was the capture device that could list formats through `ffmpeg`.

## Problem

The user was already inside an RDP session and did not want to log out or reboot.

The normal permanent fix is:

```bash
sudo usermod -aG video lachlan
```

But Linux group membership is applied when a login session starts. Existing desktop apps may still fail with:

```text
Permission denied
```

## Immediate No-Logout Fix

Grant the current user direct ACL access to the current video device nodes:

```bash
sudo setfacl -m u:lachlan:rw /dev/video0 /dev/video1 /dev/media0
```

Verify:

```bash
getfacl /dev/video0 /dev/video1 /dev/media0
```

Expected entries include:

```text
user:lachlan:rw-
```

Then test the device:

```bash
ffmpeg -hide_banner -f v4l2 -list_formats all -i /dev/video0
```

For a temporary live preview:

```bash
ffplay -hide_banner -f v4l2 -input_format mjpeg -video_size 1280x720 -framerate 30 /dev/video0
```

## Important Detail

The ACL fix is attached to the current `/dev/video*` and `/dev/media*` nodes.

If the camera is unplugged/replugged, or the device nodes are recreated, the ACL can disappear. In that case, rerun:

```bash
sudo setfacl -m u:lachlan:rw /dev/video0 /dev/video1 /dev/media0
```

The permanent `video` group membership will apply after a fresh login or reboot.

## Useful Checks

List USB devices:

```bash
lsusb
```

List camera device nodes:

```bash
ls -l /dev/video* /dev/media*
```

List V4L2 names:

```bash
for f in /sys/class/video4linux/video*/name; do
  echo "$f: $(cat "$f")"
done
```

Check current group membership:

```bash
id
groups
```


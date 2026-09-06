# Share the physical Ubuntu desktop through RDP, RealVNC and UU

When the physical desktop contains the desired workspace, all remote
transports should view it directly. There is no need to log out or move
windows between sessions. This setup was verified with GDM X11, XRDP
0.9.24, RealVNC Service Mode and the
[UU Remote Ubuntu bridge](https://github.com/lachlanchen/uu-remote-ubuntu-bridge).

## Why the desktop split

XRDP's standard Xorg/Xvnc entries use `port=-1`, asking sesman to create
or resume a separate desktop. RealVNC Service Mode normally shows the
physical console. UU may follow either, especially after an RDP login
changes DISPLAY in the systemd user manager's environment.

An older helper that displays XRDP *inside* the console belongs to the
opposite arrangement. Disable that helper when choosing the console as the
common workspace, while keeping the actual RealVNC Service Mode server.

## Arrangement

```text
One existing physical GNOME X11 desktop
  ├── RealVNC Service Mode → RealVNC clients
  └── independent x11vnc on 127.0.0.1:5922
       ├── authenticated XRDP VNC proxy → RDP clients
       └── UU's viewer and existing input patches → UU clients
```

The independent VNC backend survives UU restarts and client disconnects.
UU opts in through these settings:

```ini
UURB_DESKTOP_TARGET=physical
UURB_DESKTOP_RELAY=vnc
UURB_DESKTOP_VNC_PORT=5922
```

The bridge verifies physical GDM/seat identity instead of assuming the user
manager's current DISPLAY is physical. Its shared-backend helper creates
no additional X server or desktop. Existing auto/XRDP modes remain available
for computers where a virtual desktop is the intended workspace.

## Authentication and persistence

Use an XRDP `libvnc.so` connection to the existing loopback server and make
it the autorun default. Require PAM authentication with the physical desktop
owner's supplied Ubuntu password. The tested settings were
`pamusername=same`, `pampassword=same`, and `pamsessionmng=::1`, with the
actual sesman listener on `[::1]:3350`.

The backend is loopback-only and does not itself ask for a VNC password.
**Never expose an unauthenticated RDP-to-VNC proxy.** Confirm that a wrong
password fails before desktop access and the supplied account password
succeeds. Saved client credentials can connect without a second password
prompt. No Ubuntu password belongs in a public config or repository.

See the [complete installation and configuration guide](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/shared-physical-desktop.md)
for the optional helper, service, PAM-authenticated XRDP section and rollback
considerations. The service is enabled explicitly and does not change other
computers' defaults. The installer preserves the shared-port setting.

## Preserve the workspace

- Record the physical window IDs and session identities before changing routes.
- Keep already-open separate XRDP sessions alive; do not log them out.
- Close/reconnect the RDP client to use its new default. Existing connections
  do not switch desktops mid-session.
- Keep the working UU Wine prefix, account state and input/audio patches.
- Disable ExtendedDesktopSize for this proxy if RDP must not resize the
  physical monitor; fit the view with client-side scaling.
- Keep existing GDM unattended login if access is needed after reboot.
  This backend discovers a logged-in session; it does not create one.

A VNC proxy is not a managed XRDP session and does not automatically provide
all audio, drive or advanced clipboard channels. The repair verified shared
framebuffer access and authentication; it did not certify every redirection
feature or all remote keyboard/IME combinations.

## Verification on 2026-09-06

The wrong-password RDP test failed at PAM. The correct-password test showed
the existing console, browser windows, dock and top bar. Physical Xorg,
GNOME, xrdp, sesman and RealVNC service processes stayed alive, and all
original physical application window IDs remained present. UU reported
physical-target selection, external relay reuse, native X11 input and its
terminal helper. Temporary test clients and Xvfb were stopped afterward.

Configuration is persistent; no reboot was performed during this repair.
Private account data, screenshots and raw logs are not included here.

For the opposite use case, where the long-lived **XRDP desktop** is the
workspace to preserve, use [the existing-XRDP guide](uu-remote-same-xrdp-desktop.md).

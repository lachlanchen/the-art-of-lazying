# Copy text across noVNC, Ubuntu, RDP and mobile clients

A shared desktop does not imply a shared clipboard. A nested connection can
have four boundaries: the VM clipboard, the noVNC page, Ubuntu's clipboard,
and the outer remote client's clipboard. Diagnose each boundary separately.

## noVNC inside an Ubuntu browser

Stock noVNC has a Clipboard panel; received text appears in its text box.
That is not an automatic write to the browser device's system clipboard.
Copy the text from the panel, or use an explicit local Copy control if the
application provides one. Paste client text into the panel to send it to
the remote clipboard; use the target app's Paste action afterward.

The LabCanvas Tiny11 `/wechat` and `/wecom` browser views now provide:

- **Copy to this device** — Windows text shown in the dialog → browser device.
- **Paste from this device** — client text → dialog for review.
- **Send to Windows clipboard** — reviewed dialog text → Windows clipboard.
- **Reload Windows clipboard** — explicitly refresh the text from Windows.

Choose **Take control → Clipboard** first. Opening the dialog does not
overwrite the local clipboard. Failed sends and control reconnects preserve
the draft. No button types, presses Enter or submits a message. If the
browser is running in Ubuntu, “this device” means Ubuntu, even when the
screen is viewed from a phone through another remote desktop.

On phones, clipboard APIs can require HTTPS/localhost, browser permission
and a fresh user gesture. The explicit Copy button runs after the network
read. If access is unavailable, use the dialog's manual selection/long-press
Copy or Paste instructions. Do not weaken authentication or expose an
unauthenticated noVNC server to make the Clipboard API available.

See [the viewer implementation and fixture](https://github.com/lachlanchen/AgInTi-LabCanvas/blob/master/references/tiny11-novnc-clipboard.md).

## RDP into the physical Ubuntu desktop

XRDP's managed Xorg/Xvnc desktops normally have a channel server. A static
`libvnc.so` connection sharing the physical desktop may not. On Ubuntu's
XRDP 0.9.24, the fallback VNC clipboard is Latin-1 only. An intentionally
receive-only VNC backend adds another reason that Ubuntu-to-client Copy fails.

Attach a separate packaged `xrdp-chansrv` to the **same existing physical
X11 display**, then set `chansrvport=DISPLAY(0)` and enable only `cliprdr` in
that XRDP connection. Verify the actual display; do not copy `0` blindly.
Retain PAM authentication. The optional helper verifies the physical GDM
authority instead of trusting a systemd environment that an RDP login can
overwrite. It never starts a replacement desktop.

Full commands, the user service, rollback and known limitations are in the
[UU bridge physical-desktop guide](https://github.com/lachlanchen/uu-remote-ubuntu-bridge/blob/main/docs/shared-physical-desktop.md#enable-the-native-rdp-text-clipboard-separately).

Reconnect the RDP **client**, with clipboard sharing enabled, to acquire the
channel. Do not log out Ubuntu. Existing windows stay on the same desktop.
Enabling a service for later logins is not proof of a reboot test.

An isolated test with VNC clipboard fully disabled proved native-channel
transfer of ASCII symbols, Chinese, Japanese, accents and multiline text
both ways. LF/CRLF conversion was checked explicitly. Emoji outside the BMP
still fail in the packaged 0.9.24 implementation; this is the known
[upstream UTF-16 bug](https://github.com/neutrinolabs/xrdp/issues/2603).
Do not describe that result as complete Unicode support or a successful
test of every Windows App/iOS/Android client.

## Keep UU dictation separate

UU's semantic text broker uses clipboard ownership internally to deliver
CJK, symbols and dictation revisions. The private Wine/VNC relay deliberately
blocks reverse clipboard feedback (`ServerCutText=0`, `-seldir recv`). Removing
those protections can turn typing into stale pastes or erase earlier input.

The native RDP clipboard channel bypasses that VNC fallback. It does not
require changing the proven UU broker, keyboard layout, dictation route,
audio, or RealVNC configuration. The direct UU reverse clipboard is **not**
certified by this change. Use the verified RDP/text-panel route and assess a
separate explicit UU copy mechanism before enabling a global clipboard echo.

RealVNC's own clipboard behavior remains independent. A client toggle can
still disable it. File transfer, rich HTML, images and multiple simultaneous
RDP clipboard clients are outside this plain-text acceptance.

## Evidence and operating practice

- Keep user text out of logs and tests. Use isolated displays or a mocked VM.
- Verify both directions, multiline content, permission refusal and reconnects.
- Confirm original desktop processes and windows remain alive.
- Stop disposable test browsers, VNC servers and X displays after capture.
- Retain configuration backups and exact rollback instructions.

References: [noVNC API](https://novnc.com/noVNC/docs/API.html),
[Clipboard API restrictions](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard_API),
[XRDP 0.9.24 VNC clipboard](https://github.com/neutrinolabs/xrdp/blob/v0.9.24/vnc/vnc_clip.c).

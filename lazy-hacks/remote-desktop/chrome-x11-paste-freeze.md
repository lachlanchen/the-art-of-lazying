# Chrome paste freezes on X11: a missing selection reply

## Diagnosis, 2026-10-05

Chrome 149.0.7827.114 on a shared Ubuntu X11 desktop intermittently froze a
tab/composer on Ctrl+V. Restarting Chrome had helped previously, but the
failure returned. A fresh profile of the **same installed binary**, isolated
in Xvfb/noVNC and controlled through CDP, established a reproducible failure:

1. A normal external X11 selection owner served text promptly; twelve baseline
   pastes completed in 4–8 ms.
2. A synthetic owner deliberately withheld a selection reply. Chrome's paste
   request then stayed blocked. Replacing that owner with a healthy one did
   not clear Chrome's pending request.
3. Sending an ICCCM failure notification (`SelectionNotify`, `property=None`)
   for the pending selection/target unblocked the existing browser.
4. The next paste succeeded in that same process. Restarting the browser,
   logging out, or replacing the user's profile was unnecessary.

Chromium's X11 `SelectionRequester` queues conversions and only advances when
the current conversion completes. The inspected implementation has no timeout
for an unanswered conversion. See the primary source for
[149.0.7827.114](https://chromium.googlesource.com/chromium/src/+/149.0.7827.114/ui/base/x/selection_requester.cc)
and the also-inspected
[154.0.8037.57](https://chromium.googlesource.com/chromium/src/+/154.0.8037.57/ui/base/x/selection_requester.cc).
Do not promise that upgrading to the latter removes this failure mode.

On the working desktop, a targeted failure notification was sent to the
identified everyday Chrome clipboard window. Chrome and its windows were
preserved. The user subsequently reported paste working after accepting
Chrome's paste permission prompt. Website clipboard permission and a stalled
X11 conversion are separate layers; both can affect the visible experience.

**What is proven:** the missing-reply failure is reproducible, and cancellation
restores the blocked browser. **What is not proven:** which application or
remote clipboard provider originally lost a reply on the working desktop.
The current external clipboard owner answered promptly during inspection.
Do not infer that Firefox, UU Remote, XRDP, VNC, or a particular website caused
the original loss just because it participates in the desktop.

## Minimal local protection

[chrome-clipboard-guard.py](scripts/chrome-clipboard-guard.py) watches only X11
`SelectionRequest` and `SelectionNotify` metadata using XRecord. For a request
to a verified Chrome/Chromium clipboard window, it allows eight seconds for
an initial reply. If none arrives, it sends a failure notification for that
specific request so Chromium can advance its queue.

- XRes identifies the actual local process; a window title alone is insufficient.
  The process must belong to the current user and run a Chrome/Chromium executable.
- Successful replies cancel the deadline. Normal clipboard transfers are untouched.
- The guard never owns CLIPBOARD/PRIMARY, writes text, coerces files to text,
  deletes selection properties, presses keys, or clears browser profiles.
- It does not capture clipboard payloads, keyboard events, mouse events, or history.
  Logs contain startup/failure metadata only.
- Lost/overflowed observation stops the guard rather than guessing what to cancel.
- It uses an event queue with a timed wait, not a clipboard polling/copy loop.

This is a **local workaround for a missing browser timeout**, not a replacement
Chromium build or a claim to fix every possible paste freeze. The default wait
is per conversion; Chromium can request several fallback formats. A completely
unresponsive provider can therefore take longer than eight seconds to finish
failing. Recopy from a healthy source and retry after the queue clears.

### Boundaries

- A legitimate provider slower than eight seconds may have its request rejected.
  Increase `--timeout` if that is an observed requirement.
- The guard covers a **missing initial SelectionNotify**, not an incremental
  (`INCR`) transfer that stalls after the initial reply. Chunked transfers are
  not rewritten or proxied. A browser-side timeout is the broader upstream fix.
- Requests already stuck before the guard starts are not observable retroactively.
  The live repair was a separate targeted action. Do not blanket-send synthetic
  failures to every app or every format as a routine startup action.
- This service targets the existing shared X11 desktop. It does not apply to
  native Wayland clipboard protocols or unrelated noVNC displays.
- A website may require clipboard permission or reject a file type. Remote
  clipboard bridges may also support text only. These are distinct from the
  reproduced browser queue failure.

## Install and manage

Dependencies: Python 3 with `python3-xlib`; the X server must expose RECORD and
X-Resource. No root service, browser extension, or browser profile edit is needed.
The existing workstation already had these dependencies.

From the repository root:

```bash
mkdir -p "$HOME/scripts" "$HOME/.config/systemd/user"
install -m 0755 lazy-hacks/remote-desktop/scripts/chrome-clipboard-guard.py \
  "$HOME/scripts/chrome-clipboard-guard.py"
install -m 0644 lazy-hacks/remote-desktop/scripts/chrome-clipboard-guard.service \
  "$HOME/.config/systemd/user/chrome-clipboard-guard.service"
systemd-analyze --user verify "$HOME/.config/systemd/user/chrome-clipboard-guard.service"
systemctl --user daemon-reload
systemctl --user enable --now chrome-clipboard-guard.service
```

The supplied unit uses `:0` and `%t/gdm/Xauthority`, the verified shared physical
GDM desktop on this workstation. On another machine, set **both** for its actual
X11 desktop; do not inherit a temporary RDP/noVNC display accidentally.
Restart only this helper after changing its code or configuration:

```bash
systemctl --user restart chrome-clipboard-guard.service
systemctl --user status chrome-clipboard-guard.service
journalctl --user -u chrome-clipboard-guard.service -n 30 --no-pager
```

The service is enabled with `graphical-session.target`, stops with that desktop,
and restarts on failure. Startup was tested in the current desktop. Boot-time
enablement is configured; **a reboot was not performed for this repair**.
Keep one guard per display. Ordinary healthy pastes produce no log entries.

Rollback is immediate and does not close browser windows:

```bash
systemctl --user disable --now chrome-clipboard-guard.service
```

## Acceptance evidence

Testing used one disposable noVNC/Xvfb browser profile with synthetic data.
The guard's test deadline was two seconds; production uses eight seconds.

| Case | Observed result |
|---|---|
| Missing first TARGETS reply | Paste recovered in 2.011 s; all 37 text characters arrived |
| Missing UTF8_STRING reply | Failed read completed in 2.010 s; next healthy paste succeeded |
| Missing HTML reply in rich editor | Recovered in 2.014 s using the browser's plain-text fallback |
| Next healthy rich paste | Original HTML `<pre>` formatting preserved; 0.013 s |
| Healthy CJK/multiline text | Exact text; normal small pastes 8–13 ms |
| 37,000-character text | Exact content; 0.198 s |
| Slow but responding source | 250 ms per reply accepted, no cancellation |
| 1,040,000-byte multilingual clipboard payload | Exact payload in paste event; 0.199 s |
| External HTML | Bold markup preserved; 0.008 s |
| External PNG | `Files`, `image/png`, correct 99-byte test image; 0.007 s |
| External local file URI | `Files`, correct filename and 36-byte size; 0.008 s |
| Python window impersonating the Chrome window title | Ignored; no cancellation and ownership unchanged |
| Guard stop while its disposable X server closes | Clean exit; no broken-pipe traceback |

The large-payload test initially rendered the entire payload into the diagnostic
page's status log, causing a renderer/layout stall. Bounding that diagnostic
display and inspecting the paste payload separately removed the stall. That
test-page issue is **not evidence of another clipboard protocol defect**.

The PNG/file tests verify the browser delivers actual files rather than replacing
them with a textual path. They do not prove that every remote transport or WeChat
web endpoint accepts those files. No test uploaded a file or submitted a message.

Private runtime evidence remains outside Git: source snapshots, diagnostic
scripts, protocol metadata, screenshots and synthetic results. Stop the exact
test stack after capture; keep the small guard, not a resident diagnostic desktop.
The original Chrome, other browser profiles, open windows, UU bridge and XRDP
services were preserved.

For the separate remote clipboard boundaries, see
[clipboard across noVNC, RDP and UU](clipboard-across-novnc-rdp-and-uu.md).

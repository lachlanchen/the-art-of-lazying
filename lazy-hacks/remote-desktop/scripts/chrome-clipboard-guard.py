#!/usr/bin/python3
"""Bound missing X11 clipboard replies for Chrome, without owning the clipboard.

Requires python3-xlib, XRecord and XRes. Only SelectionRequest/SelectionNotify
metadata is observed: no keys, mouse events, clipboard data, or browser history.
This covers a missing initial response, not a stalled INCR chunk after a reply.
"""

import argparse
import logging
import os
from pathlib import Path
import queue
import signal
import threading
import time

from Xlib import X, Xatom, display, error, protocol
from Xlib.ext import record, res


LOG = logging.getLogger("chrome-clipboard-guard")
CHROME_EXECUTABLES = {"chrome", "chromium", "chromium-browser"}


class Guard:
    def __init__(self, display_name, timeout):
        self.control = display.Display(display_name)
        self.recorder = display.Display(display_name)
        if not all(self.control.has_extension(name) for name in ("RECORD", "X-Resource")):
            raise RuntimeError("X11 RECORD and X-Resource extensions are required")
        self.timeout = timeout
        self.events = queue.Queue(maxsize=4096)
        self.failed = threading.Event()
        self.stopping = threading.Event()
        self.pending = {}
        self.accepted = {}
        self.selections = {self.control.intern_atom("CLIPBOARD"), Xatom.PRIMARY}
        self.property = self.control.intern_atom("CHROME_SELECTION")
        self.context = self.recorder.record_create_context(
            0, [record.AllClients], [{
                "core_requests": (0, 0), "core_replies": (0, 0),
                "ext_requests": (0, 0, 0, 0), "ext_replies": (0, 0, 0, 0),
                "delivered_events": (X.SelectionRequest, X.SelectionNotify),
                "device_events": (0, 0), "errors": (0, 0),
                "client_started": False, "client_died": False,
            }],
        )

    def chrome_pid(self, window_id):
        """XRes identifies the actual local connection, unlike spoofable _NET_WM_PID."""
        try:
            window = self.control.create_resource_object("window", window_id)
            if window.get_wm_name() != "Chromium clipboard":
                return None
            ids = self.control.res_query_client_ids([
                {"client": window_id, "mask": res.LocalClientPIDMask}
            ]).ids
            for item in ids:
                if item.spec.mask & res.LocalClientPIDMask and item.value:
                    pid = int(item.value[0])
                    proc = Path("/proc") / str(pid)
                    if proc.stat().st_uid != os.getuid():
                        continue
                    exe = (proc / "exe").resolve(strict=True).name
                    if exe in CHROME_EXECUTABLES:
                        return pid
        except (error.XError, OSError):
            pass
        return None

    def recorded(self, reply):
        if reply.category != record.FromServer or reply.client_swapped:
            return
        data = reply.data
        while data:
            event, data = protocol.rq.EventField(None).parse_binary_value(
                data, self.recorder.display, None, None
            )
            if event.type not in (X.SelectionRequest, X.SelectionNotify):
                continue
            try:
                # Store metadata only. This range cannot contain clipboard contents.
                self.events.put_nowait((time.monotonic(), event))
            except queue.Full:
                # Lost event ordering means it is unsafe to cancel anything.
                self.failed.set()
                return

    def record_loop(self):
        try:
            self.recorder.record_enable_context(self.context, self.recorded)
        except Exception:
            if not self.stopping.is_set():
                LOG.exception("Selection event stream failed; no further cancellation")
        finally:
            if not self.stopping.is_set():
                self.failed.set()

    def handle(self, received, event):
        wid = getattr(event.requestor, "id", event.requestor)
        if event.selection not in self.selections:
            return
        if event.type == X.SelectionRequest:
            if event.property != self.property:
                return
            identity = self.accepted.get(wid)
            if not identity or received - identity[1] > 60:
                pid = self.chrome_pid(wid)
                if not pid:
                    self.accepted.pop(wid, None)
                    return
                identity = self.accepted[wid] = (pid, received)
            self.pending[wid] = (received, event, identity[0])
        else:
            pending = self.pending.get(wid)
            if pending:
                old = pending[1]
                if (old.selection == event.selection and old.target == event.target
                        and event.property in (old.property, X.NONE)
                        and (not event.time or not old.time or event.time == old.time)):
                    self.pending.pop(wid, None)

    def expire(self):
        now = time.monotonic()
        for wid, (received, event, pid) in list(self.pending.items()):
            if now - received < self.timeout:
                continue
            self.pending.pop(wid, None)
            if self.chrome_pid(wid) != pid:
                self.accepted.pop(wid, None)
                continue
            try:
                window = self.control.create_resource_object("window", wid)
                # ICCCM failure reply, not clipboard replacement or property deletion.
                window.send_event(protocol.event.SelectionNotify(
                    time=event.time, requestor=window, selection=event.selection,
                    target=event.target, property=X.NONE,
                ), propagate=False)
                self.control.sync()
                LOG.warning("Cancelled unanswered clipboard request pid=%s window=%#x "
                            "selection=%s target=%s after %.1fs", pid, wid,
                            self.control.get_atom_name(event.selection),
                            self.control.get_atom_name(event.target), now - received)
            except error.XError:
                self.accepted.pop(wid, None)

    def run(self):
        worker = threading.Thread(target=self.record_loop, daemon=True)
        worker.start()
        LOG.info("Watching Chrome X11 selection replies on %s; timeout %.1fs; metadata only",
                 self.control.get_display_name(), self.timeout)
        try:
            while not self.stopping.is_set():
                if self.failed.is_set():
                    raise RuntimeError("Selection event stream lost; stopping safely")
                wait = min((max(0, t + self.timeout - time.monotonic())
                            for t, _, _ in self.pending.values()), default=1.0)
                try:
                    self.handle(*self.events.get(timeout=min(wait, 1.0)))
                    # Drain responses already delivered before checking deadlines.
                    while True:
                        self.handle(*self.events.get_nowait())
                except queue.Empty:
                    pass
                if self.failed.is_set():
                    raise RuntimeError("Selection event stream lost; stopping safely")
                self.expire()
        finally:
            self.stopping.set()
            self.control.record_disable_context(self.context)
            self.control.flush()
            worker.join(timeout=2)
            self.control.close()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--display", default=os.environ.get("DISPLAY"))
    parser.add_argument("--xauthority", help="Explicit authority for the shared X11 desktop")
    parser.add_argument("--timeout", type=float, default=8.0,
                        help="Seconds allowed for an initial reply (default: 8)")
    args = parser.parse_args()
    if not args.display or args.timeout < 1:
        parser.error("a display and timeout of at least one second are required")
    if args.xauthority:
        os.environ["XAUTHORITY"] = args.xauthority
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
    guard = Guard(args.display, args.timeout)
    for sig in (signal.SIGTERM, signal.SIGINT):
        signal.signal(sig, lambda *_: guard.stopping.set())
    guard.run()


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Observe modifier flags and F5 for 25 seconds without recording typed text.

Run on the destination Mac, then press/release keys in its VNC viewer. This
read-only diagnostic neither injects keys nor installs a monitor or event tap.
"""

import ctypes
import json
import sys
import time


def main():
    if sys.platform != "darwin":
        raise SystemExit("Run this observer on the destination Mac, not the viewer.")
    cg = ctypes.CDLL(
        "/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics"
    )
    cg.CGEventSourceFlagsState.argtypes = [ctypes.c_int]
    cg.CGEventSourceFlagsState.restype = ctypes.c_uint64
    cg.CGEventSourceKeyState.argtypes = [ctypes.c_int, ctypes.c_uint16]
    cg.CGEventSourceKeyState.restype = ctypes.c_bool
    previous = None
    until = time.monotonic() + 25
    while time.monotonic() < until:
        flags = cg.CGEventSourceFlagsState(0)
        current = {
            "control": bool(flags & (1 << 18)),
            "option": bool(flags & (1 << 19)),
            "command": bool(flags & (1 << 20)),
            "f5": bool(cg.CGEventSourceKeyState(0, 96)),
        }
        if current != previous:
            print(json.dumps(current), flush=True)
            previous = current
        time.sleep(0.02)


if __name__ == "__main__":
    main()

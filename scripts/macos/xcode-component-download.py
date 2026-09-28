#!/usr/bin/env python3
"""Bound the Xcode downloader's lifetime and keep progress spam in a private log."""
import os
from pathlib import Path
import subprocess
import sys
import tempfile


def main():
    args = sys.argv[1:]
    if not args or args[0] not in ("-downloadPlatform", "-downloadComponent"):
        raise SystemExit("Expected -downloadPlatform or -downloadComponent arguments")
    timeout = int(os.environ.get("XCODE_DOWNLOAD_TIMEOUT", "3600"))
    if timeout <= 0:
        raise SystemExit("XCODE_DOWNLOAD_TIMEOUT must be positive")
    folder = Path.home() / "Library/Logs/DeveloperSetup"
    folder.mkdir(parents=True, exist_ok=True, mode=0o700)
    fd, name = tempfile.mkstemp(prefix="component-", suffix=".log", dir=folder)
    print(f"Running {' '.join(args)}; timeout {timeout}s; log {name}", flush=True)
    code = 1
    with os.fdopen(fd, "w+b") as log:
        try:
            result = subprocess.run(["/usr/bin/xcodebuild", *args], stdout=log,
                                    stderr=subprocess.STDOUT, timeout=timeout)
            code = result.returncode
        except subprocess.TimeoutExpired:
            print("Downloader timed out; its process was stopped.", flush=True)
            code = 124
        except KeyboardInterrupt:
            code = 130
        finally:
            end = log.seek(0, os.SEEK_END)
            log.seek(max(0, end - 4096))
            lines = log.read().decode("utf-8", errors="replace").splitlines()
            # Retain distinct messages, not hundreds of repeated progress frames.
            print("\n".join(dict.fromkeys(lines[-20:])), flush=True)
    return code


if __name__ == "__main__":
    sys.exit(main())

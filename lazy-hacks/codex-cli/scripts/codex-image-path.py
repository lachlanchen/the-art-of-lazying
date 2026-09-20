#!/usr/bin/python3
"""Copy a local image reference as text, without Codex's implicit attachment.

Linux X11/XWayland helper. No upload, keystroke injection, or Codex modification.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shlex
import subprocess
import sys
from urllib.parse import unquote, urlsplit


def local_path(value):
    """Accept an existing local file, never a remote URI or shell expression."""
    value = value.strip()
    if value.startswith('file:'):
        uri = urlsplit(value)
        if uri.netloc not in ('', 'localhost') or uri.query or uri.fragment:
            raise ValueError('Only local file:// URIs are supported')
        value = unquote(uri.path)
    elif '://' in value:
        raise ValueError('Remote URLs are not local file paths')
    p = Path(value).expanduser().absolute()
    if not p.is_file():
        raise ValueError('Not an existing local file: ' + str(p))
    return p


def xread(target):
    result = subprocess.run(
        ['xclip', '-selection', 'clipboard', '-out', '-target', target],
        capture_output=True, timeout=5,
    )
    if result.returncode:
        raise ValueError('Clipboard format unavailable: ' + target)
    return result.stdout


def clipboard_paths():
    targets = xread('TARGETS').decode(errors='replace').splitlines()
    # File-manager copies carry the real filename. Prefer that over pixels.
    for target in ('text/uri-list', 'x-special/gnome-copied-files'):
        if target not in targets:
            continue
        lines = xread(target).decode('utf-8').splitlines()
        if target == 'x-special/gnome-copied-files':
            lines = lines[1:]
        values = [v for v in lines if v and not v.startswith('#')]
        if values:
            return [local_path(v) for v in values]
    for target in ('UTF8_STRING', 'text/plain;charset=utf-8', 'text/plain'):
        if target not in targets:
            continue
        text = xread(target).decode('utf-8').strip()
        try:
            return [local_path(text)]
        except ValueError:
            # Accept a quoted/shell-escaped single path without executing it.
            try:
                parts = shlex.split(text)
                if len(parts) == 1:
                    return [local_path(parts[0])]
            except ValueError:
                pass
    if 'image/png' not in targets:
        raise ValueError('Copy a local file/path or an image offering PNG first')
    data = xread('image/png')
    if not data.startswith(b'\x89PNG\r\n\x1a\n') or len(data) > 100 * 1024 * 1024:
        raise ValueError('Clipboard PNG is invalid or exceeds 100 MiB')
    root = Path(os.environ.get('XDG_CACHE_HOME', str(Path.home() / '.cache')))
    folder = root / 'codex-image-path'
    folder.mkdir(parents=True, exist_ok=True, mode=0o700)
    folder.chmod(0o700)
    path = folder / (hashlib.sha256(data).hexdigest() + '.png')
    # No original filename exists for a bitmap-only clipboard. Save once.
    if path.exists():
        if path.is_symlink() or path.read_bytes() != data:
            raise ValueError('Existing clipboard-cache file does not match')
    else:
        with path.open('xb') as stream:
            stream.write(data)
        path.chmod(0o600)
    return [path.absolute()]


def reference_text(paths):
    # Codex 0.155.1 auto-attaches a paste only when the entire paste is a single
    # image path. The label makes this normal, editable prompt text.
    return '\n'.join('Image file path: ' + json.dumps(str(p), ensure_ascii=False)
                     for p in paths)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('files', nargs='*', help='existing files; otherwise read clipboard')
    parser.add_argument('--print', action='store_true', help='print without changing clipboard')
    args = parser.parse_args()
    try:
        selected = os.environ.get('NAUTILUS_SCRIPT_SELECTED_URIS', '').splitlines()
        paths = ([local_path(v) for v in args.files] if args.files else
                 [local_path(v) for v in selected if v] if selected else clipboard_paths())
        text = reference_text(paths)
        if not args.print:
            subprocess.run(
                ['xclip', '-selection', 'clipboard', '-in', '-target', 'UTF8_STRING'],
                input=text.encode('utf-8'), stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL, check=True, timeout=5,
            )
            print('Copied path text. Paste into Codex with Ctrl+Shift+V.', file=sys.stderr)
        print(text)
        return 0
    except (OSError, ValueError, UnicodeError, subprocess.SubprocessError) as exc:
        print('codex-image-path: ' + str(exc), file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())

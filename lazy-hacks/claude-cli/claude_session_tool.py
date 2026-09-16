#!/usr/bin/env python3
"""Session helper for the claude / clauder / claudemv wrappers.

Claude Code stores each conversation as
  <CLAUDE_CONFIG_DIR>/projects/<encoded-cwd>/<session-id>.jsonl
where <encoded-cwd> is the working directory with every character outside
[A-Za-z0-9] replaced by "-".  Every record inside the file repeats the
absolute "cwd".  This tool lists, picks and migrates those sessions.

Subcommands:
  list   emit matching sessions as JSON
  pick   interactive numbered picker; writes "id\\0cwd\\0path\\0" to --output
  move   rewrite the cwd of every session under --old to --new (with journal)
  rollback JOURNAL   undo a previous move
"""

from __future__ import annotations

import argparse
import datetime as dt
import json
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Sequence

HEAD_BYTES = 256 * 1024
TAIL_BYTES = 64 * 1024
SKIP_PROMPT_PREFIXES = (
    "<", "Caveat:", "[Request interrupted", "This session is being continued",
)


def encode_project_path(path: str) -> str:
    return re.sub(r"[^a-zA-Z0-9]", "-", path)


def normalize_path(value: str) -> str:
    return os.path.realpath(os.path.expanduser(value))


def config_root(value: str | None) -> Path:
    if value:
        return Path(value).expanduser()
    env = os.environ.get("CLAUDE_CONFIG_DIR")
    if env:
        return Path(env).expanduser()
    return Path.home() / ".claude"


@dataclass
class Session:
    id: str
    cwd: str
    path: str
    project_dir: str
    mtime: float
    prompt: str
    title: str

    def to_dict(self) -> dict[str, object]:
        return {
            "id": self.id,
            "cwd": self.cwd,
            "path": self.path,
            "project_dir": self.project_dir,
            "mtime": self.mtime,
            "prompt": self.prompt,
            "title": self.title,
        }


def _text_of(message: object) -> str:
    if not isinstance(message, dict):
        return ""
    content = message.get("content")
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        parts = []
        for item in content:
            if isinstance(item, dict) and item.get("type") == "text":
                parts.append(str(item.get("text", "")))
        return " ".join(parts)
    return ""


def _scan_lines(raw: bytes) -> Iterable[dict]:
    for line in raw.split(b"\n"):
        line = line.strip()
        if not line:
            continue
        try:
            item = json.loads(line)
        except Exception:
            continue
        if isinstance(item, dict):
            yield item


def read_session(path: Path, project_dir: Path) -> Session | None:
    try:
        size = path.stat().st_size
        with path.open("rb") as handle:
            head = handle.read(HEAD_BYTES)
            tail = b""
            if size > HEAD_BYTES:
                handle.seek(max(HEAD_BYTES, size - TAIL_BYTES))
                tail = handle.read()
    except OSError:
        return None

    cwd = ""
    prompt = ""
    title = ""
    for item in _scan_lines(head):
        if not cwd and isinstance(item.get("cwd"), str):
            cwd = item["cwd"]
        if not title and isinstance(item.get("customTitle"), str):
            title = item["customTitle"]
        if not prompt and item.get("type") == "user":
            text = _text_of(item.get("message")).strip()
            if text and not text.startswith(SKIP_PROMPT_PREFIXES):
                prompt = " ".join(text.split())[:200]
        if cwd and prompt and title:
            break
    if tail:
        for item in _scan_lines(tail):
            if isinstance(item.get("customTitle"), str):
                title = item["customTitle"]
    if not cwd:
        return None
    return Session(
        id=path.stem,
        cwd=cwd,
        path=str(path),
        project_dir=str(project_dir),
        mtime=path.stat().st_mtime,
        prompt=prompt,
        title=title,
    )


def iter_sessions(root: Path) -> Iterable[Session]:
    projects = root / "projects"
    if not projects.is_dir():
        return
    for project_dir in sorted(projects.iterdir()):
        if not project_dir.is_dir():
            continue
        for path in project_dir.glob("*.jsonl"):
            session = read_session(path, project_dir)
            if session is not None:
                yield session


def matches(session: Session, scope: str, cwd: str, query: str) -> bool:
    if scope == "exact":
        return session.cwd == cwd
    if scope == "partial":
        needle = (query or cwd).lower()
        return needle in session.cwd.lower() or needle in session.prompt.lower() or needle in session.title.lower()
    return True


def query_sessions(root: Path, scope: str, cwd: str, query: str, limit: int) -> list[Session]:
    found = [s for s in iter_sessions(root) if matches(s, scope, cwd, query)]
    found.sort(key=lambda s: s.mtime, reverse=True)
    return found[:limit] if limit > 0 else found


def format_time(mtime: float) -> str:
    return dt.datetime.fromtimestamp(mtime).strftime("%Y-%m-%d %H:%M")


def scope_label(scope: str, cwd: str, query: str) -> str:
    if scope == "exact":
        return f"exact cwd: {cwd}"
    if scope == "partial":
        return f"partial match: {query or cwd}"
    return "all folders"


def row_text(session: Session, show_cwd: bool) -> str:
    label = session.title or session.prompt or "(no prompt yet)"
    text = f"{format_time(session.mtime)}  {label}"
    if show_cwd:
        text += f"  [{session.cwd}]"
    return text


def numbered_picker(sessions: Sequence[Session], label: str, show_cwd: bool, select_index: int | None) -> Session | None:
    if select_index is not None:
        if 1 <= select_index <= len(sessions):
            return sessions[select_index - 1]
        print(f"claude picker: --select-index {select_index} out of range", file=sys.stderr)
        return None
    print(f"Claude sessions ({label}):")
    width = len(str(len(sessions)))
    for index, session in enumerate(sessions, start=1):
        print(f"{index:>{width}}. {row_text(session, show_cwd)}")
    while True:
        try:
            answer = input(f"Select 1-{len(sessions)} (Enter = 1, q = quit): ").strip()
        except (EOFError, KeyboardInterrupt):
            print()
            return None
        if answer == "":
            return sessions[0]
        if answer.lower() in {"q", "quit"}:
            return None
        if answer.isdigit() and 1 <= int(answer) <= len(sessions):
            return sessions[int(answer) - 1]
        print("Enter a number from the list.")


def write_selection(path: Path, session: Session) -> None:
    with path.open("w", encoding="utf-8") as handle:
        handle.write("\0".join((session.id, session.cwd, session.path)) + "\0")


def run_pick(args: argparse.Namespace) -> int:
    root = config_root(args.root)
    cwd = normalize_path(args.cwd)
    sessions = query_sessions(root, args.scope, cwd, args.query, args.limit)
    if not sessions:
        print(f"No Claude sessions found for {scope_label(args.scope, cwd, args.query)} in {root}", file=sys.stderr)
        if args.scope == "exact":
            print("Try: clauder --all   or   clauder --non-strict <text>", file=sys.stderr)
        return 3
    session = numbered_picker(
        sessions,
        scope_label(args.scope, cwd, args.query),
        show_cwd=args.scope != "exact",
        select_index=args.select_index,
    )
    if session is None:
        return 130
    write_selection(Path(args.output), session)
    return 0


def run_list(args: argparse.Namespace) -> int:
    root = config_root(args.root)
    cwd = normalize_path(args.cwd)
    sessions = query_sessions(root, args.scope, cwd, args.query, args.limit)
    json.dump([s.to_dict() for s in sessions], sys.stdout, indent=2)
    sys.stdout.write("\n")
    return 0


# --- move -----------------------------------------------------------------

def _map_path(value: str, old_root: str, new_root: str) -> str | None:
    if value == old_root:
        return new_root
    if value.startswith(old_root + os.sep):
        return new_root + value[len(old_root):]
    return None


def live_sessions_under(root: Path, old_root: str) -> list[dict]:
    live = []
    sessions_dir = root / "sessions"
    if not sessions_dir.is_dir():
        return live
    for path in sessions_dir.glob("*.json"):
        try:
            info = json.loads(path.read_text())
        except Exception:
            continue
        cwd = info.get("cwd")
        pid = info.get("pid")
        if not isinstance(cwd, str) or _map_path(cwd, old_root, "x") is None:
            continue
        if isinstance(pid, int):
            try:
                os.kill(pid, 0)
            except OSError:
                continue
        live.append(info)
    return live


def rewrite_jsonl(path: Path, old_root: str, new_root: str) -> int:
    """Rewrite cwd fields in place; returns number of changed lines."""
    changed = 0
    out_lines: list[bytes] = []
    with path.open("rb") as handle:
        for raw in handle:
            stripped = raw.rstrip(b"\r\n")
            if b'"cwd"' in stripped:
                try:
                    item = json.loads(stripped)
                except Exception:
                    item = None
                if isinstance(item, dict) and isinstance(item.get("cwd"), str):
                    mapped = _map_path(item["cwd"], old_root, new_root)
                    if mapped is not None:
                        item["cwd"] = mapped
                        stripped = json.dumps(item, ensure_ascii=False, separators=(",", ":")).encode("utf-8")
                        changed += 1
            out_lines.append(stripped + b"\n" if raw.endswith(b"\n") else stripped)
    if changed:
        temporary = path.with_name(path.name + ".claudemv-tmp")
        with temporary.open("wb") as handle:
            handle.writelines(out_lines)
        os.chmod(temporary, path.stat().st_mode & 0o777)
        os.replace(temporary, path)
    return changed


def rewrite_history(root: Path, old_root: str, new_root: str) -> int:
    path = root / "history.jsonl"
    if not path.is_file():
        return 0
    changed = 0
    out_lines: list[bytes] = []
    with path.open("rb") as handle:
        for raw in handle:
            stripped = raw.rstrip(b"\r\n")
            if b'"project"' in stripped:
                try:
                    item = json.loads(stripped)
                except Exception:
                    item = None
                if isinstance(item, dict) and isinstance(item.get("project"), str):
                    mapped = _map_path(item["project"], old_root, new_root)
                    if mapped is not None:
                        item["project"] = mapped
                        stripped = json.dumps(item, ensure_ascii=False, separators=(",", ":")).encode("utf-8")
                        changed += 1
            out_lines.append(stripped + b"\n" if raw.endswith(b"\n") else stripped)
    if changed:
        temporary = path.with_name(path.name + ".claudemv-tmp")
        with temporary.open("wb") as handle:
            handle.writelines(out_lines)
        os.chmod(temporary, path.stat().st_mode & 0o777)
        os.replace(temporary, path)
    return changed


def atomic_json(path: Path, payload: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True, mode=0o700)
    temporary = path.with_name(path.name + ".tmp")
    temporary.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n")
    os.chmod(temporary, 0o600)
    os.replace(temporary, path)


def write_move_result(path: Path, values: Iterable[str]) -> None:
    with path.open("w", encoding="utf-8") as handle:
        handle.write("\0".join(values) + "\0")


def migrate(root: Path, old_root: str, new_root: str, *, force: bool, journal_name: str, output: str | None) -> int:
    if old_root == os.sep:
        print("claudemv refuses to migrate the filesystem root.", file=sys.stderr)
        return 2
    if old_root == new_root:
        print("claudemv: old and new paths are identical; nothing changed.", file=sys.stderr)
        return 2

    projects = root / "projects"
    if not projects.is_dir():
        print(f"claudemv: no projects directory at {projects}", file=sys.stderr)
        return 3

    # Group sessions by project directory and map each directory to its cwd.
    plan: dict[Path, dict[str, object]] = {}
    for session in iter_sessions(root):
        mapped = _map_path(session.cwd, old_root, new_root)
        if mapped is None:
            continue
        project_dir = Path(session.project_dir)
        entry = plan.setdefault(project_dir, {"sessions": [], "cwd": session.cwd})
        entry["sessions"].append(session)
        if encode_project_path(session.cwd) == project_dir.name:
            entry["cwd"] = session.cwd
    if not plan:
        print(f"claudemv: no sessions found under old path: {old_root}", file=sys.stderr)
        return 3

    live = live_sessions_under(root, old_root)
    if live and not force:
        print("claudemv: refusing to move while these Claude sessions are still running:", file=sys.stderr)
        for info in live:
            print(f"  pid {info.get('pid')}  session {info.get('sessionId')}  cwd {info.get('cwd')}", file=sys.stderr)
        print("Close them first, or re-run with --force.", file=sys.stderr)
        return 4

    stamp = dt.datetime.now().strftime("%Y%m%d-%H%M%S-%f")
    journal_path = root / "backups" / "claudemv" / f"{journal_name}-{stamp}.json"
    dir_moves: list[dict[str, str]] = []
    file_moves: list[dict[str, str]] = []
    session_changes: list[dict[str, str]] = []

    for project_dir, entry in sorted(plan.items()):
        old_cwd = str(entry["cwd"])
        new_cwd = _map_path(old_cwd, old_root, new_root) or new_root
        target = projects / encode_project_path(new_cwd)
        dir_moves.append({"old_dir": str(project_dir), "new_dir": str(target), "old_cwd": old_cwd, "new_cwd": new_cwd})
        for session in entry["sessions"]:
            session_changes.append({
                "id": session.id,
                "old_cwd": session.cwd,
                "new_cwd": _map_path(session.cwd, old_root, new_root) or new_root,
                "old_path": session.path,
                "new_path": str(target / (session.id + ".jsonl")),
            })

    atomic_json(journal_path, {
        "created_at": dt.datetime.now(dt.timezone.utc).isoformat(),
        "config_dir": str(root),
        "old_root": old_root,
        "new_root": new_root,
        "dirs": dir_moves,
        "sessions": session_changes,
    })

    # Move directories (or merge their contents when the target already exists).
    for move in dir_moves:
        source = Path(move["old_dir"])
        target = Path(move["new_dir"])
        if source == target:
            continue
        if not target.exists():
            os.rename(source, target)
            file_moves.append({"from": str(source), "to": str(target)})
            continue
        for child in sorted(source.iterdir()):
            destination = target / child.name
            if destination.exists():
                print(f"claudemv: {destination} already exists; leaving {child} in place", file=sys.stderr)
                continue
            os.rename(child, destination)
            file_moves.append({"from": str(child), "to": str(destination)})
        try:
            source.rmdir()
        except OSError:
            pass

    # Rewrite the cwd inside every moved session file.
    rewritten = 0
    for change in session_changes:
        target_path = Path(change["new_path"])
        if not target_path.is_file():
            target_path = Path(change["old_path"])
        if target_path.is_file():
            rewritten += rewrite_jsonl(target_path, old_root, new_root)
    history_changed = rewrite_history(root, old_root, new_root)

    payload = json.loads(journal_path.read_text())
    payload["file_moves"] = file_moves
    payload["rewritten_lines"] = rewritten
    payload["history_lines"] = history_changed
    atomic_json(journal_path, payload)

    latest = max(session_changes, key=lambda item: Path(item["new_path"]).stat().st_mtime if Path(item["new_path"]).exists() else 0)
    print(f"claudemv: migrated {len(session_changes)} session(s) in {len(dir_moves)} folder(s)")
    print(f"  old: {old_root}")
    print(f"  new: {new_root}")
    print(f"  rollback journal: {journal_path}")
    print(f"  undo with: python3 {Path(__file__).resolve()} rollback {journal_path}")
    if output:
        write_move_result(Path(output), (str(len(session_changes)), latest["id"], new_root, str(journal_path)))
    return 0


def run_move(args: argparse.Namespace) -> int:
    root = config_root(args.root)
    return migrate(
        root,
        normalize_path(args.old),
        normalize_path(args.new),
        force=args.force,
        journal_name="move",
        output=args.output,
    )


def run_rollback(args: argparse.Namespace) -> int:
    journal = json.loads(Path(args.journal).read_text())
    root = Path(journal["config_dir"])
    return migrate(
        root,
        journal["new_root"],
        journal["old_root"],
        force=args.force,
        journal_name="rollback",
        output=None,
    )


def add_query_arguments(parser: argparse.ArgumentParser) -> None:
    parser.add_argument("--root", help="Claude config dir (default: $CLAUDE_CONFIG_DIR or ~/.claude)")
    parser.add_argument("--scope", choices=("exact", "partial", "all"), default="exact")
    parser.add_argument("--cwd", default=os.getcwd())
    parser.add_argument("--query", default="")
    parser.add_argument("--limit", type=int, default=500)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    subparsers = parser.add_subparsers(dest="command", required=True)

    pick_parser = subparsers.add_parser("pick", help="interactively select a session")
    add_query_arguments(pick_parser)
    pick_parser.add_argument("--output", required=True)
    pick_parser.add_argument("--select-index", type=int, help=argparse.SUPPRESS)
    pick_parser.set_defaults(func=run_pick)

    list_parser = subparsers.add_parser("list", help="emit matching sessions as JSON")
    add_query_arguments(list_parser)
    list_parser.set_defaults(func=run_list)

    move_parser = subparsers.add_parser("move", help="rewrite stored cwd prefixes")
    move_parser.add_argument("--root")
    move_parser.add_argument("--old", required=True)
    move_parser.add_argument("--new", required=True)
    move_parser.add_argument("--output")
    move_parser.add_argument("--force", action="store_true", help="move even if a live session uses the old path")
    move_parser.set_defaults(func=run_move)

    rollback_parser = subparsers.add_parser("rollback", help="undo a move using its journal")
    rollback_parser.add_argument("journal")
    rollback_parser.add_argument("--force", action="store_true")
    rollback_parser.set_defaults(func=run_rollback)
    return parser


def main() -> int:
    args = build_parser().parse_args()
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())

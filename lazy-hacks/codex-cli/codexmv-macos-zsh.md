# `codexmv` on macOS `zsh`

## Goal
When a project folder moves or gets renamed on macOS, Codex session resume may stop showing the old sessions because the stored cwd no longer matches.

This `zsh` version of `codexmv` rewrites the stored cwd prefix in `~/.codex/state_5.sqlite`, then opens `codex resume` in the new folder.

## Command

```zsh
codexmv [--latest|-l] <oldpath> [newpath]
```

- `oldpath`: required
- `newpath`: optional, defaults to `.`
- default mode: migrate, then open the normal resume picker in the new/current folder
- `-l` / `--latest`: migrate, then auto-resume the latest migrated session

## Requirements
- `sqlite3`
- `python3`
- Codex local state at `~/.codex/state_5.sqlite`

## Install in `~/.zshrc`
Put this next to your existing `codex` and `codexr` wrappers.

If you already have `__codex_real_bin()` from the `codex`/`codexr` guide, keep a single copy and only add `codexmv()`.

```zsh
unalias codexmv 2>/dev/null

__codex_real_bin() {
  emulate -L zsh
  local real

  real="$(whence -p codex 2>/dev/null)" || return 1
  [[ -n "$real" ]] || return 1
  print -r -- "$real"
}

codexmv() {
  emulate -L zsh
  local old_raw new_raw old_abs new_abs db old_q new_q count resume_id latest_mode real

  db="$HOME/.codex/state_5.sqlite"
  latest_mode=0

  while (( $# )); do
    case "$1" in
      -l|--latest)
        latest_mode=1
        shift
        ;;
      -h|--help)
        echo "Usage: codexmv [--latest|-l] <oldpath> [newpath]"
        echo "Default: migrate then open resume picker in new/current folder."
        echo "Use --latest/-l: migrate then auto-resume latest migrated session."
        return 0
        ;;
      --)
        shift
        break
        ;;
      -*)
        echo "codexmv error: unknown option $1" >&2
        return 2
        ;;
      *)
        break
        ;;
    esac
  done

  if (( $# < 1 || $# > 2 )); then
    echo "Usage: codexmv [--latest|-l] <oldpath> [newpath]" >&2
    echo "Examples: codexmv ../oldpath  |  codexmv ../oldpath .  |  codexmv -l ~/old ~/new" >&2
    return 2
  fi

  command -v sqlite3 >/dev/null 2>&1 || { echo "codexmv error: sqlite3 not found" >&2; return 127; }
  command -v python3 >/dev/null 2>&1 || { echo "codexmv error: python3 not found" >&2; return 127; }
  [[ -f "$db" ]] || { echo "codexmv error: codex state db not found at $db" >&2; return 1; }

  old_raw="$1"
  if (( $# == 2 )); then
    new_raw="$2"
  else
    new_raw="."
  fi

  old_abs="$(python3 -c 'import os,sys; print(os.path.abspath(os.path.expanduser(sys.argv[1])))' "$old_raw")" || return 1
  new_abs="$(python3 -c 'import os,sys; print(os.path.abspath(os.path.expanduser(sys.argv[1])))' "$new_raw")" || return 1

  old_q="${old_abs//\'/\'\'}"
  new_q="${new_abs//\'/\'\'}"

  count="$(sqlite3 "$db" "SELECT COUNT(*) FROM threads WHERE cwd='${old_q}' OR cwd LIKE '${old_q}/%';")" || return 1
  if [[ "${count:-0}" -eq 0 ]]; then
    echo "codexmv: no sessions found under old path: $old_abs"
    return 1
  fi

  resume_id="$(sqlite3 "$db" "SELECT id FROM threads WHERE cwd='${old_q}' OR cwd LIKE '${old_q}/%' ORDER BY updated_at DESC LIMIT 1;")" || return 1

  sqlite3 "$db" "BEGIN;
UPDATE threads
   SET cwd = CASE
     WHEN cwd='${old_q}' THEN '${new_q}'
     WHEN cwd LIKE '${old_q}/%' THEN '${new_q}' || substr(cwd, length('${old_q}') + 1)
     ELSE cwd
   END
 WHERE cwd='${old_q}' OR cwd LIKE '${old_q}/%';
COMMIT;" || return 1

  echo "codexmv: migrated ${count} session(s)"
  echo "  old: ${old_abs}"
  echo "  new: ${new_abs}"

  real="$(__codex_real_bin)" || { echo "codexmv error: real codex binary not found" >&2; return 127; }

  if (( latest_mode == 1 )); then
    [[ -n "$resume_id" ]] || { echo "codexmv: migration done, but no resume id found" >&2; return 1; }
    echo "codexmv: resuming latest migrated session: ${resume_id}"
    command "$real" -s danger-full-access -a never resume "$resume_id" -C "$new_abs"
  else
    echo "codexmv: opening resume picker in ${new_abs}"
    command "$real" -s danger-full-access -a never resume -C "$new_abs"
  fi
}
```

## Reload and verify

```zsh
source ~/.zshrc
codexmv -h
```

## Examples

```zsh
# migrate old -> current folder, then open picker
codexmv ../oldpath

# migrate old -> explicit new folder, then open picker
codexmv ~/Projects/old ~/Local/new-project

# migrate and auto-resume the latest migrated session
codexmv -l ~/Projects/old ~/Local/new-project
```

## What it updates
- DB: `~/.codex/state_5.sqlite`
- Table: `threads`
- Field: `cwd`

It updates both:
- exact match: `cwd == oldpath`
- subtree: `cwd LIKE oldpath/%`

Subpaths are preserved by replacing only the old leading prefix.

## Notes
- The default picker flow is safer when multiple sessions exist under the old path.
- `--latest` is faster when you know the newest session is the one you want.
- This is a direct DB rewrite. Use it when a project folder was moved or renamed, not as a general session management tool.

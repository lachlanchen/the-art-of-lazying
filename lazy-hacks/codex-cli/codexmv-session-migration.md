# `codexmv`: Migrate Session Path and Resume in New Folder

## Goal
When a project folder moves/renames, Codex session picker (cwd-filtered) may hide old sessions.

`codexmv` rewrites stored session cwd from old path to new path, then opens resume in new location.

## Command

```bash
codexmv [--latest|-l] <oldpath> [newpath]
```

- `oldpath`: required
- `newpath`: optional, defaults to `.`
- default mode: open normal resume picker in new/current folder
- `-l` / `--latest`: auto-resume latest migrated session

## Supported path styles
- relative: `../oldpath`, `oldpath`
- current folder: `.`, `./`
- home: `~/xxx`
- absolute: `/home/xxx`

## What it updates
- DB: `~/.codex/state_5.sqlite`
- Table: `threads`
- Field: `cwd`

It updates both:
- exact match: `cwd == oldpath`
- subtree: `cwd LIKE oldpath/%`

Subpaths are preserved (prefix replacement).

## `.bashrc` implementation

```bash
codexmv() {
  local old_raw new_raw old_abs new_abs db old_q new_q count resume_id latest_mode real
  db="$HOME/.codex/state_5.sqlite"
  latest_mode=0

  while [ "$#" -gt 0 ]; do
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

  if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: codexmv [--latest|-l] <oldpath> [newpath]" >&2
    echo "Examples: codexmv ../oldpath  |  codexmv ../oldpath .  |  codexmv -l ~/old ~/new" >&2
    return 2
  fi
  command -v sqlite3 >/dev/null 2>&1 || { echo "codexmv error: sqlite3 not found" >&2; return 127; }
  [ -f "$db" ] || { echo "codexmv error: codex state db not found at $db" >&2; return 1; }

  old_raw="$1"
  if [ "$#" -eq 2 ]; then
    new_raw="$2"
  else
    new_raw="."
  fi

  old_abs="$(python3 -c 'import os,sys; print(os.path.abspath(os.path.expanduser(sys.argv[1])))' "$old_raw")" || return 1
  new_abs="$(python3 -c 'import os,sys; print(os.path.abspath(os.path.expanduser(sys.argv[1])))' "$new_raw")" || return 1

  old_q="${old_abs//\'/\'\'}"
  new_q="${new_abs//\'/\'\'}"

  count="$(sqlite3 "$db" "SELECT COUNT(*) FROM threads WHERE cwd='${old_q}' OR cwd LIKE '${old_q}/%';")" || return 1
  if [ "${count:-0}" -eq 0 ]; then
    echo "codexmv: no sessions found under old path: $old_abs"
    return 1
  fi

  resume_id="$(sqlite3 "$db" "SELECT id FROM threads WHERE cwd='${old_q}' OR cwd LIKE '${old_q}/%' ORDER BY updated_at DESC LIMIT 1;")"

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

  if [ "$latest_mode" -eq 1 ]; then
    [ -n "$resume_id" ] || { echo "codexmv: migration done, but no resume id found" >&2; return 1; }
    echo "codexmv: resuming latest migrated session: ${resume_id}"
    command "$real" -s danger-full-access -a never resume "$resume_id" -C "$new_abs"
  else
    echo "codexmv: opening resume picker in ${new_abs}"
    command "$real" -s danger-full-access -a never resume -C "$new_abs"
  fi
}
```

## Examples

```bash
# migrate old -> current, then picker
codexmv ../oldpath

# migrate old -> explicit new, then picker
codexmv ~/Projects/old ~/Projects/new

# migrate and auto-resume latest migrated session
codexmv -l ../oldpath ./newpath
```

## Notes
- Default mode is safer when multiple sessions exist (you choose manually).
- `--latest` is faster when you know you want most recent context.

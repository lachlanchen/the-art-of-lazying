# Full macOS `zsh` Setup for `codex`, `codexr`, and `codexmv`

## Repository
Primary remote for this repo:

```bash
git@github.com:lachlanchen/the-art-of-lazying.git
```

HTTPS fallback:

```bash
https://github.com/lachlanchen/the-art-of-lazying.git
```

Example clone:

```bash
git clone git@github.com:lachlanchen/the-art-of-lazying.git ~/Local/the-art-of-lazying
```

## Goal
Set up three shell helpers on macOS `zsh`:

- `codex`
  - always forces `-s danger-full-access -a never`
  - strips conflicting or duplicate mode flags
- `codexr`
  - same defaults as `codex`
  - always runs `resume`
- `codexmv`
  - migrates stored Codex session cwd values when a project folder moved or was renamed
  - uses `~/.codex/state_5.sqlite`

## Exact `~/.zshrc` block
Put this block next to your other shell helpers.

```zsh
# Codex CLI wrappers: enforce preferred defaults and tolerate repeated flags.
unalias codex 2>/dev/null
unalias codexr 2>/dev/null
unalias codexmv 2>/dev/null

__codex_real_bin() {
  emulate -L zsh
  local real

  real="$(whence -p codex 2>/dev/null)" || return 1
  [[ -n "$real" ]] || return 1
  print -r -- "$real"
}

codex() {
  emulate -L zsh
  local -a passthrough

  while (( $# )); do
    case "$1" in
      -s|--sandbox|-a|--ask-for-approval)
        shift
        (( $# )) && shift
        ;;
      --sandbox=*|--ask-for-approval=*|--full-auto|--dangerously-bypass-approvals-and-sandbox)
        shift
        ;;
      -s*|-a*)
        shift
        ;;
      *)
        passthrough+=("$1")
        shift
        ;;
    esac
  done

  command codex -s danger-full-access -a never "${passthrough[@]}"
}

codexr() {
  emulate -L zsh
  [[ "$1" == "resume" ]] && shift
  codex resume "$@"
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

## Verify

```zsh
source ~/.zshrc
whence -w codex codexr codexmv
codexmv -h
```

## Examples

```zsh
codex
codexr
codexmv ../old-project
codexmv ~/Projects/old-project ~/Local/new-project
codexmv -l ~/Projects/old-project ~/Local/new-project
```

## Maintenance rule
Keep the repo doc and the live `~/.zshrc` block identical.

When you change the live shell setup, update these files in the same pass:

- `lazy-hacks/codex-cli/macos-zsh-full-setup.md`
- `lazy-hacks/codex-cli/codex-and-codexr.md`
- `lazy-hacks/codex-cli/codexmv-macos-zsh.md`
- `lazy-hacks/codex-cli/README.md`

## Prompt for another Codex session
Use this prompt on the target machine:

```text
Set up the same Codex shell workflow on this macOS machine.

Source repo:
- git@github.com:lachlanchen/the-art-of-lazying.git
- https://github.com/lachlanchen/the-art-of-lazying.git

Docs to follow after cloning:
- lazy-hacks/codex-cli/macos-zsh-full-setup.md
- lazy-hacks/codex-cli/codex-and-codexr.md
- lazy-hacks/codex-cli/codexmv-macos-zsh.md

Requirements:
- update ~/.zshrc with the exact codex, codexr, codexmv block from the doc
- keep __codex_real_bin compatible with zsh
- use ~/.codex/state_5.sqlite for codexmv
- verify with:
  - source ~/.zshrc
  - whence -w codex codexr codexmv
  - codexmv -h

If you change the implementation, update the docs in the repo to match the live ~/.zshrc exactly.
```

# `codex` and `codexr` Robust Shell Overrides

## Goal
Always run Codex with:
- sandbox: `danger-full-access`
- approval: `never`

And remain robust if command lines include duplicated or conflicting `-s`/`-a` args.

## Behavior
- `codex ...`
  - strips user-supplied mode args (`-s`, `-a`, long forms)
  - re-applies `-s danger-full-access -a never`
- `codexr ...`
  - same as `codex`
  - always appends `resume`
  - drops duplicated `resume` if user typed it manually
- `cr`
  - alias to `codexr`

## `.bashrc` implementation

```bash
__codex_real_bin() {
  local c resolved
  while IFS= read -r c; do
    [ -z "$c" ] && continue
    resolved="$(readlink -f "$c" 2>/dev/null || echo "$c")"
    [ "$resolved" = "$HOME/bin/codex" ] && continue
    [ "$resolved" = "$HOME/bin/codexr" ] && continue
    echo "$c"
    return 0
  done < <(type -P -a codex 2>/dev/null || true)
  return 1
}

__codex_strip_mode_args() {
  local out=()
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -s|-a|--sandbox-mode|--sandbox_mode|--approval-policy|--approval_policy)
        shift
        [ "$#" -gt 0 ] && shift
        ;;
      -s=*|-a=*|--sandbox-mode=*|--sandbox_mode=*|--approval-policy=*|--approval_policy=*)
        shift
        ;;
      *)
        out+=("$1")
        shift
        ;;
    esac
  done
  printf '%s\n' "${out[@]}"
}

codex() {
  local real cleaned=()
  real="$(__codex_real_bin)" || { echo "codex override error: real codex binary not found" >&2; return 127; }
  mapfile -t cleaned < <(__codex_strip_mode_args "$@")
  command "$real" -s danger-full-access -a never "${cleaned[@]}"
}

codexr() {
  local real arg cleaned=() final=()
  real="$(__codex_real_bin)" || { echo "codexr override error: real codex binary not found" >&2; return 127; }
  mapfile -t cleaned < <(__codex_strip_mode_args "$@")
  for arg in "${cleaned[@]}"; do
    [ "$arg" = "resume" ] && continue
    final+=("$arg")
  done
  command "$real" -s danger-full-access -a never "${final[@]}" resume
}

alias cr='codexr'
```

## Usage examples

```bash
codex
codex -s read-only -a on-request
codexr
codexr -s workspace-write -a on-request
cr
```

All still run with enforced `danger-full-access` + `never`.

#!/usr/bin/env bash
# Shared implementation for claude, clauder, and claudemv on this workstation.
# Mirrors ~/scripts/codex_wrapper.sh: every launch gets full access with no
# permission prompts, `clauder` is a fast resume picker, and `claudemv`
# migrates saved sessions after a project folder is moved.
#
#   claude   [args...]                    -> claude --allow-dangerously-skip-permissions --permission-mode bypassPermissions [args...]
#   claude   resume [picker-args...]      -> same as clauder
#   clauder  [--all|--non-strict [TEXT]] [-C DIR] [--native] [SESSION_ID|NAME]
#   claudemv [--latest|-l] [--no-resume] [--native] [--force] <oldpath> [newpath]
#
# Any of them accepts --account NAME first; that routes through AgentShell
# (agent-run) so the named account's CLAUDE_CONFIG_DIR is used.
# Escape hatch for a stock launch: `command claude ...` or CLAUDE_REAL_BIN.

set -uo pipefail

claude_wrapper_mode="${1:-}"
if [ "$#" -gt 0 ]; then
  shift
fi

claude_wrapper_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
claude_session_tool="$claude_wrapper_dir/claude_session_tool.py"

: "${CLAUDE_RESUME_PICKER_ENABLE:=1}"
: "${CLAUDE_RESUME_PICKER_LIMIT:=500}"
CLAUDE_ENFORCED_ARGS=(--allow-dangerously-skip-permissions --permission-mode bypassPermissions)

claude_config_dir() {
  printf '%s\n' "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
}

claude_find_real_bin() {
  local candidate resolved
  local shim_claude="$HOME/bin/claude"
  local shim_clauder="$HOME/bin/clauder"
  local shim_claudemv="$HOME/bin/claudemv"

  if [ -n "${CLAUDE_REAL_BIN:-}" ] && [ -x "$CLAUDE_REAL_BIN" ]; then
    printf '%s\n' "$CLAUDE_REAL_BIN"
    return 0
  fi

  while IFS= read -r candidate; do
    [ -n "$candidate" ] || continue
    resolved="$(readlink -f -- "$candidate" 2>/dev/null || printf '%s' "$candidate")"
    case "$candidate" in
      "$shim_claude"|"$shim_clauder"|"$shim_claudemv") continue ;;
    esac
    case "$resolved" in
      "$shim_claude"|"$shim_clauder"|"$shim_claudemv"|"$claude_wrapper_dir/claude_wrapper.sh") continue ;;
      */agentshell) continue ;;
    esac
    if [ -x "$resolved" ]; then
      printf '%s\n' "$resolved"
      return 0
    fi
  done < <(type -P -a claude 2>/dev/null || true)

  for candidate in "$HOME"/.nvm/versions/node/*/bin/claude "$HOME/.claude/local/claude" "$HOME/.local/bin/claude" /usr/local/bin/claude /usr/bin/claude; do
    [ -x "$candidate" ] || continue
    resolved="$(readlink -f -- "$candidate" 2>/dev/null || printf '%s' "$candidate")"
    case "$resolved" in
      "$shim_claude"|"$shim_clauder"|"$shim_claudemv") continue ;;
    esac
    printf '%s\n' "$resolved"
    return 0
  done
  return 1
}

# --account NAME (or --project NAME) as the first argument routes through
# AgentShell so the account's isolated Claude home is active. ~/bin goes first
# on PATH so AgentShell resolves `claude` back to this wrapper.
claude_route_account() {
  local mode="$1"
  shift
  case "${1:-}" in
    --account|--account=*|--project|--project=*) ;;
    *) return 1 ;;
  esac
  local account_args=()
  case "$1" in
    --account=*|--project=*) account_args=(--account "${1#*=}"); shift ;;
    *)
      if [ "$#" -lt 2 ]; then
        printf 'claude wrapper error: %s requires an account name\n' "$1" >&2
        exit 2
      fi
      account_args=(--account "$2"); shift 2
      ;;
  esac
  if ! type -P agent-run >/dev/null 2>&1; then
    printf 'claude wrapper error: agent-run (AgentShell) is not installed; cannot use --account\n' >&2
    exit 127
  fi
  PATH="$HOME/bin:$PATH" exec agent-run "${account_args[@]}" "$mode" "$@"
}

CLAUDE_CLEAN_ARGS=()
claude_strip_enforced_mode_args() {
  CLAUDE_CLEAN_ARGS=()
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --permission-mode)
        if [ "$#" -lt 2 ]; then
          printf 'claude wrapper error: %s requires a value\n' "$1" >&2
          return 2
        fi
        shift 2
        ;;
      --permission-mode=*|--dangerously-skip-permissions|--allow-dangerously-skip-permissions)
        shift
        ;;
      *)
        CLAUDE_CLEAN_ARGS+=("$1")
        shift
        ;;
    esac
  done
}

claude_run_native() {
  local real_bin="$1"
  shift
  # Replace this short-lived wrapper with Claude so a live wrapper edit never
  # races with a multi-hour session.
  exec "$real_bin" "${CLAUDE_ENFORCED_ARGS[@]}" "$@"
}

claude_picker_enabled() {
  [ "${CLAUDE_RESUME_PICKER_ENABLE:-1}" = "1" ]
}

claude_normalize_path() {
  realpath -m -- "$1"
}

CLAUDE_RESUME_NATIVE_ARGS=()
CLAUDE_RESUME_PASS_ARGS=()
CLAUDE_RESUME_SCOPE="exact"
CLAUDE_RESUME_TARGET_CWD=""
CLAUDE_RESUME_QUERY=""
CLAUDE_RESUME_FORCE_NATIVE=0
CLAUDE_RESUME_EXPLICIT_CWD=0

claude_parse_resume_args() {
  local value
  CLAUDE_RESUME_NATIVE_ARGS=()
  CLAUDE_RESUME_PASS_ARGS=()
  CLAUDE_RESUME_SCOPE="exact"
  CLAUDE_RESUME_TARGET_CWD="$(pwd -P)"
  CLAUDE_RESUME_QUERY=""
  CLAUDE_RESUME_FORCE_NATIVE=0
  CLAUDE_RESUME_EXPLICIT_CWD=0

  while [ "$#" -gt 0 ]; do
    case "$1" in
      --native)
        CLAUDE_RESUME_FORCE_NATIVE=1
        shift
        ;;
      --non-strict)
        CLAUDE_RESUME_SCOPE="partial"
        shift
        if [ "$#" -gt 0 ] && [[ "$1" != -* ]]; then
          CLAUDE_RESUME_QUERY="$1"
          shift
        fi
        ;;
      --non-strict=*)
        CLAUDE_RESUME_SCOPE="partial"
        CLAUDE_RESUME_QUERY="${1#*=}"
        shift
        ;;
      --all)
        if [ "$CLAUDE_RESUME_SCOPE" != "partial" ]; then
          CLAUDE_RESUME_SCOPE="all"
        fi
        shift
        ;;
      -C|--cd|--cwd)
        if [ "$#" -lt 2 ]; then
          printf 'clauder error: %s requires a directory\n' "$1" >&2
          return 2
        fi
        value="$(claude_normalize_path "$2")" || return 2
        CLAUDE_RESUME_TARGET_CWD="$value"
        CLAUDE_RESUME_EXPLICIT_CWD=1
        shift 2
        ;;
      -C=*|--cd=*|--cwd=*)
        value="$(claude_normalize_path "${1#*=}")" || return 2
        CLAUDE_RESUME_TARGET_CWD="$value"
        CLAUDE_RESUME_EXPLICIT_CWD=1
        shift
        ;;
      -c|--continue)
        # Native "continue latest in this folder"; no picker needed.
        CLAUDE_RESUME_FORCE_NATIVE=1
        CLAUDE_RESUME_NATIVE_ARGS+=("$1")
        shift
        ;;
      -h|--help|-v|--version)
        CLAUDE_RESUME_FORCE_NATIVE=1
        CLAUDE_RESUME_NATIVE_ARGS+=("$1")
        shift
        ;;
      --)
        shift
        while [ "$#" -gt 0 ]; do
          CLAUDE_RESUME_PASS_ARGS+=("$1")
          shift
        done
        ;;
      -*)
        # Unknown Claude options (e.g. --model, --fork-session) pass straight through.
        CLAUDE_RESUME_PASS_ARGS+=("$1")
        if [ "$#" -gt 1 ] && [[ "$2" != -* ]]; then
          case "$1" in
            --model|--effort|--agent|--name|-n|--add-dir|--settings|--mcp-config|--system-prompt|--append-system-prompt|--session-id|--plugin-dir|--plugin-url|--betas|--input-format|--output-format|--max-turns|--allowedTools|--allowed-tools|--disallowedTools|--disallowed-tools|--tools|--effort-level|--worktree|-w|--from-pr|--teleport)
              CLAUDE_RESUME_PASS_ARGS+=("$2")
              shift
              ;;
          esac
        fi
        shift
        ;;
      *)
        # A session ID or /rename name: let native Claude resolve it.
        CLAUDE_RESUME_FORCE_NATIVE=1
        CLAUDE_RESUME_NATIVE_ARGS+=("$1")
        shift
        ;;
    esac
  done

  if [ "$CLAUDE_RESUME_SCOPE" = "partial" ] && [ -z "$CLAUDE_RESUME_QUERY" ]; then
    CLAUDE_RESUME_QUERY="$CLAUDE_RESUME_TARGET_CWD"
  fi
}

claude_resume_native() {
  local real_bin="$1"
  shift
  if [ "$CLAUDE_RESUME_EXPLICIT_CWD" -eq 1 ]; then
    cd -- "$CLAUDE_RESUME_TARGET_CWD" || exit 1
  fi
  local has_flag=0 arg
  for arg in "${CLAUDE_RESUME_NATIVE_ARGS[@]}"; do
    case "$arg" in
      -c|--continue|-h|--help|-v|--version) has_flag=1 ;;
    esac
  done
  if [ "$has_flag" -eq 1 ]; then
    claude_run_native "$real_bin" "${CLAUDE_RESUME_PASS_ARGS[@]}" "${CLAUDE_RESUME_NATIVE_ARGS[@]}" "$@"
  else
    claude_run_native "$real_bin" "${CLAUDE_RESUME_PASS_ARGS[@]}" --resume "${CLAUDE_RESUME_NATIVE_ARGS[@]}" "$@"
  fi
}

claude_fast_picker() {
  local real_bin="$1"
  local output_path status selection=()
  shift

  if [ ! -x "$claude_session_tool" ]; then
    printf 'clauder: helper missing or not executable (%s); opening the native picker.\n' "$claude_session_tool" >&2
    claude_resume_native "$real_bin" "$@"
    return $?
  fi

  output_path="$(mktemp "${TMPDIR:-/tmp}/claude-session-selection.XXXXXX")" || return 1
  python3 "$claude_session_tool" pick \
    --root "$(claude_config_dir)" \
    --scope "$CLAUDE_RESUME_SCOPE" \
    --cwd "$CLAUDE_RESUME_TARGET_CWD" \
    --query "$CLAUDE_RESUME_QUERY" \
    --limit "$CLAUDE_RESUME_PICKER_LIMIT" \
    --output "$output_path" \
    ${CLAUDE_PICKER_SELECT_INDEX:+--select-index "$CLAUDE_PICKER_SELECT_INDEX"}
  status=$?
  if [ "$status" -ne 0 ]; then
    rm -f -- "$output_path"
    return "$status"
  fi
  mapfile -d '' -t selection < "$output_path"
  rm -f -- "$output_path"
  if [ "${#selection[@]}" -lt 2 ] || [ -z "${selection[0]}" ]; then
    printf 'clauder error: helper returned no valid selection\n' >&2
    return 1
  fi

  # Claude looks a session up by the folder it was started in, so enter it
  # unless the caller pinned a directory explicitly.
  if [ "$CLAUDE_RESUME_EXPLICIT_CWD" -eq 1 ]; then
    cd -- "$CLAUDE_RESUME_TARGET_CWD" || exit 1
  elif [ -d "${selection[1]}" ]; then
    cd -- "${selection[1]}" || exit 1
  fi
  claude_run_native "$real_bin" "${CLAUDE_RESUME_PASS_ARGS[@]}" --resume "${selection[0]}" "$@"
}

claude_handle_resume() {
  local real_bin="$1"
  shift
  claude_parse_resume_args "$@" || return $?
  if [ "$CLAUDE_RESUME_FORCE_NATIVE" -eq 1 ] || ! claude_picker_enabled; then
    claude_resume_native "$real_bin"
    return $?
  fi
  claude_fast_picker "$real_bin"
}

claude_handle_move() {
  local latest=0 no_resume=0 native_picker=0 force=0
  local old_raw="" new_raw="." real_bin output_path status
  local move_result=() positional=() force_args=()

  while [ "$#" -gt 0 ]; do
    case "$1" in
      -l|--latest) latest=1; shift ;;
      --no-resume) no_resume=1; shift ;;
      --native) native_picker=1; shift ;;
      --force) force=1; shift ;;
      -h|--help)
        printf '%s\n' \
          'Usage: claudemv [--latest|-l] [--no-resume] [--native] [--force] <oldpath> [newpath]' \
          'Default: migrate saved Claude sessions from oldpath to newpath (newpath defaults to .),' \
          'save a rollback journal under $CLAUDE_CONFIG_DIR/backups/claudemv, then open the picker.' \
          '  --latest, -l  Resume the newest migrated session directly.' \
          '  --no-resume   Migrate only.' \
          '  --native      Use the official Claude picker after migration.' \
          '  --force       Migrate even if a live Claude session still uses oldpath.'
        return 0
        ;;
      --)
        shift
        while [ "$#" -gt 0 ]; do positional+=("$1"); shift; done
        ;;
      -*)
        printf 'claudemv error: unknown option %s\n' "$1" >&2
        return 2
        ;;
      *) positional+=("$1"); shift ;;
    esac
  done

  if [ "${#positional[@]}" -lt 1 ] || [ "${#positional[@]}" -gt 2 ]; then
    printf 'Usage: claudemv [--latest|-l] [--no-resume] [--native] [--force] <oldpath> [newpath]\n' >&2
    return 2
  fi
  old_raw="${positional[0]}"
  if [ "${#positional[@]}" -eq 2 ]; then
    new_raw="${positional[1]}"
  fi
  [ "$force" -eq 1 ] && force_args=(--force)

  [ -x "$claude_session_tool" ] || { printf 'claudemv error: helper is not executable: %s\n' "$claude_session_tool" >&2; return 1; }
  output_path="$(mktemp "${TMPDIR:-/tmp}/claudemv-result.XXXXXX")" || return 1

  python3 "$claude_session_tool" move \
    --root "$(claude_config_dir)" \
    --old "$old_raw" \
    --new "$new_raw" \
    --output "$output_path" \
    "${force_args[@]}"
  status=$?
  if [ "$status" -ne 0 ]; then
    rm -f -- "$output_path"
    return "$status"
  fi
  mapfile -d '' -t move_result < "$output_path"
  rm -f -- "$output_path"
  if [ "${#move_result[@]}" -lt 4 ]; then
    printf 'claudemv error: helper returned an incomplete result\n' >&2
    return 1
  fi
  if [ "$no_resume" -eq 1 ]; then
    return 0
  fi

  real_bin="$(claude_find_real_bin)" || { printf 'claudemv error: real Claude binary not found\n' >&2; return 127; }
  cd -- "${move_result[2]}" || return 1
  if [ "$latest" -eq 1 ]; then
    claude_run_native "$real_bin" --resume "${move_result[1]}"
  elif [ "$native_picker" -eq 1 ] || ! claude_picker_enabled; then
    claude_run_native "$real_bin" --resume
  else
    CLAUDE_RESUME_SCOPE="exact"
    CLAUDE_RESUME_TARGET_CWD="${move_result[2]}"
    CLAUDE_RESUME_QUERY=""
    CLAUDE_RESUME_EXPLICIT_CWD=1
    CLAUDE_RESUME_PASS_ARGS=()
    CLAUDE_RESUME_NATIVE_ARGS=()
    claude_fast_picker "$real_bin"
  fi
}

case "$claude_wrapper_mode" in
  claude)
    claude_route_account claude "$@"
    claude_strip_enforced_mode_args "$@" || exit $?
    claude_real_bin="$(claude_find_real_bin)" || { printf 'claude wrapper error: real Claude binary not found\n' >&2; exit 127; }
    if [ "${#CLAUDE_CLEAN_ARGS[@]}" -gt 0 ] && [ "${CLAUDE_CLEAN_ARGS[0]}" = "resume" ]; then
      claude_handle_resume "$claude_real_bin" "${CLAUDE_CLEAN_ARGS[@]:1}"
      exit $?
    fi
    claude_run_native "$claude_real_bin" "${CLAUDE_CLEAN_ARGS[@]}"
    ;;
  clauder)
    claude_route_account clauder "$@"
    claude_strip_enforced_mode_args "$@" || exit $?
    if [ "${#CLAUDE_CLEAN_ARGS[@]}" -gt 0 ] && [ "${CLAUDE_CLEAN_ARGS[0]}" = "resume" ]; then
      CLAUDE_CLEAN_ARGS=("${CLAUDE_CLEAN_ARGS[@]:1}")
    fi
    claude_real_bin="$(claude_find_real_bin)" || { printf 'clauder error: real Claude binary not found\n' >&2; exit 127; }
    claude_handle_resume "$claude_real_bin" "${CLAUDE_CLEAN_ARGS[@]}"
    ;;
  claudemv)
    claude_route_account claudemv "$@"
    claude_handle_move "$@"
    ;;
  *)
    printf 'Usage: %s {claude|clauder|claudemv} [arguments...]\n' "$0" >&2
    exit 2
    ;;
esac

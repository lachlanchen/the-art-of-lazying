# Source after AgentShell's optional shell integration.
__claude_launch() {
    local -a account=() permissions=(--dangerously-skip-permissions)
    case "${1:-}" in
        --account|--project)
            [[ $# -ge 2 ]] || { printf 'Missing account/project name\n' >&2; return 2; }
            account=("$1" "$2"); shift 2 ;;
        --account=*|--project=*) account=("$1"); shift ;;
    esac
    local arg
    for arg in "$@"; do
        case "$arg" in
            --permission-mode|--permission-mode=*|--dangerously-skip-permissions)
                permissions=(); break ;;
        esac
    done
    case "${1:-}" in
        auth|doctor|install|update|mcp|plugin|plugins|project|setup-token|--help|-h|--version|-v)
            permissions=() ;;
    esac
    if (( ${#account[@]} )); then
        command agent-claude "${account[@]}" "${permissions[@]}" "$@"
    else
        command claude "${permissions[@]}" "$@"
    fi
}

claude() { __claude_launch "$@"; }

clauder() {
    local -a account=()
    case "${1:-}" in
        --account|--project)
            [[ $# -ge 2 ]] || { printf 'Missing account/project name\n' >&2; return 2; }
            account=("$1" "$2"); shift 2 ;;
        --account=*|--project=*) account=("$1"); shift ;;
    esac
    __claude_launch "${account[@]}" --resume "$@"
}

claudemv() (
    local -a account=() resume=(--continue)
    case "${1:-}" in
        --account|--project)
            [[ $# -ge 2 ]] || { printf 'Missing account/project name\n' >&2; return 2; }
            account=("$1" "$2"); shift 2 ;;
        --account=*|--project=*) account=("$1"); shift ;;
    esac
    if [[ ${1:-} == --help || ${1:-} == -h ]]; then
        printf 'Usage: claudemv [--account NAME] DESTINATION [SESSION_ID]\n'
        printf 'Resume the current folder\047s latest session (or the given ID), then run native /cd.\n'
        printf 'Moves one session, not project files or every saved conversation.\n'
        return 0
    fi
    if (( $# < 1 || $# > 2 )); then
        printf 'Usage: claudemv [--account NAME] DESTINATION [SESSION_ID]\n' >&2
        return 2
    fi
    local destination
    destination=$(cd -- "$1" && pwd -P) || return
    [[ $destination != *$'\n'* && $destination != *$'\r'* ]] || {
        printf 'Directory names containing line breaks are unsupported.\n' >&2; return 2;
    }
    if (( $# == 2 )); then
        [[ -n $2 && $2 != -* ]] || { printf 'Invalid session ID\n' >&2; return 2; }
        resume=(--resume "$2")
    fi
    __claude_launch "${account[@]}" "/cd $destination" "${resume[@]}"
)

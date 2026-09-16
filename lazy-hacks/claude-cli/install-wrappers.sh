#!/usr/bin/env bash
# Install the claude / clauder / claudemv wrappers on Linux or WSL.
#
#   bash lazy-hacks/claude-code/install.sh
#
# Copies the dispatcher and session helper to ~/scripts, the command shims to
# ~/bin, and adds one guarded block to ~/.bashrc. Re-running is safe: files are
# overwritten in place and the ~/.bashrc block is only added once.

set -euo pipefail

here="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
scripts_dir="$HOME/scripts"
bin_dir="$HOME/bin"
bashrc="$HOME/.bashrc"

mkdir -p "$scripts_dir" "$bin_dir"

for file in claude_wrapper.sh claude_session_tool.py sourced_claude_wrappers.sh; do
  install -m 0755 "$here/$file" "$scripts_dir/$file"
done

for mode in claude clauder claudemv; do
  printf '#!/usr/bin/env bash\nexec "$HOME/scripts/claude_wrapper.sh" %s "$@"\n' "$mode" > "$bin_dir/$mode"
  chmod 0755 "$bin_dir/$mode"
done

if ! grep -q '>>> Claude wrappers >>>' "$bashrc" 2>/dev/null; then
  cat >> "$bashrc" <<'EOF'

# >>> Claude wrappers >>>
# claude / clauder / claudemv: full access, no permission prompts (like codex,
# codexr, codexmv). Keep this block after any other claude() definition so it
# wins; the inline fallback keeps it working if the helper file is missing.
if [ -f "$HOME/scripts/sourced_claude_wrappers.sh" ]; then
  . "$HOME/scripts/sourced_claude_wrappers.sh"
else
  claude()   { "$HOME/scripts/claude_wrapper.sh" claude "$@"; }
  clauder()  { "$HOME/scripts/claude_wrapper.sh" clauder "$@"; }
  claudemv() { "$HOME/scripts/claude_wrapper.sh" claudemv "$@"; }
  alias clr='clauder'
fi
# <<< Claude wrappers <<<
EOF
fi

case ":$PATH:" in
  *":$bin_dir:"*) ;;
  *) printf 'Note: add  export PATH="$HOME/bin:$PATH"  to ~/.bashrc so the shims are found first.\n' ;;
esac

# Skip the one-time "are you sure" dialog for bypass mode.
config_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
mkdir -p "$config_dir"
python3 - "$config_dir/settings.json" <<'EOF'
import json, sys, pathlib
path = pathlib.Path(sys.argv[1])
data = {}
if path.is_file():
    try:
        data = json.loads(path.read_text() or "{}")
    except Exception:
        data = {}
if data.get("skipDangerousModePermissionPrompt") is not True:
    data["skipDangerousModePermissionPrompt"] = True
    path.write_text(json.dumps(data, indent=2) + "\n")
EOF

printf 'Installed. Open a new shell (or run: . ~/.bashrc) and try:\n'
printf '  claude --version\n  clauder --all\n  claudemv --help\n'

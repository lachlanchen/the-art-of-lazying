# Claude Code Shell Shortcuts

Installed and checked on Ubuntu on 2026-09-16 with native Claude Code 2.1.273.
The requested workstation policy is permission bypass, not Claude's default
interactive approval policy. Use it only for workspaces and commands you trust:
Claude can modify files and execute commands with your user's existing access.
This does not grant root privileges or override organization-managed policy.

## Commands

```bash
. ~/.bashrc
claude auth login
claude
clauder
clauder SESSION_ID
claudemv /existing/destination
claudemv /existing/destination SESSION_ID
```

- `claude` starts Claude Code with `--dangerously-skip-permissions`.
- `clauder` opens the native resume picker; an optional ID resumes directly.
  The picker retains native project filtering; Ctrl+A expands it to all projects
  in the active Claude configuration directory.
- `claudemv DESTINATION [SESSION_ID]` resumes the current directory's latest
  conversation, or the specified conversation, and submits native `/cd`.
  It moves **one conversation**, not the project files or all saved history.
  The destination must already exist. The calling shell's directory is unchanged.
  Do not move a conversation that is still active in another terminal.
- An explicit `--permission-mode` wins, for example `claude --permission-mode plan`.
- Administrative commands such as `claude auth login`, `claude doctor`, and
  `claude update` are passed through without a session permission flag.

Authentication, first-run onboarding, workspace trust, and provider restrictions
are distinct from per-tool approval. These shortcuts do not manufacture login
credentials or suppress those separate requirements.

The implementation delegates resume and moves to Claude's native interfaces;
it does not edit transcript JSONL or depend on its internal schema. See the
official [session documentation](https://code.claude.com/docs/en/sessions) and
[`/cd` reference](https://code.claude.com/docs/en/commands).

## AgentShell

Source [claude-shell.sh](claude-shell.sh) **after** AgentShell shell integration.
It retains the active `CLAUDE_CONFIG_DIR`, keeping account authentication separate.
An explicit account selector must come first:

```bash
agentshell personal
claude auth login
clauder
# Or from an ordinary shell:
claude --account personal
clauder --account personal SESSION_ID
claudemv --account personal /existing/destination SESSION_ID
```

Account-prefixed calls delegate to `agent-claude`; other calls use the native
executable. This change does not alter Codex shortcuts, account credentials,
or AgentShell's history-sharing policy.

## Installation Layout

Use the official [native installer](https://code.claude.com/docs/en/setup).
Inspect the downloaded installer before running it as your ordinary user:

```bash
curl -fL --retry 3 https://claude.ai/install.sh -o /tmp/claude-install.sh
less /tmp/claude-install.sh
bash /tmp/claude-install.sh latest
```

The workstation uses:

- `~/.local/bin/claude`: native installer-managed symlink, not our wrapper.
- `~/.local/share/claude/versions/`: native version files.
- `~/scripts/sourced_claude.sh`: installed copy of this folder's shell helper.
- `~/.bashrc`: sources that helper after `sourced_agent_shell.sh`.

Copy the shell helper from this directory:

```bash
install -D -m 644 claude-shell.sh "$HOME/scripts/sourced_claude.sh"
```

Add this line after AgentShell integration in `~/.bashrc`, once:

```bash
if [ -r "$HOME/scripts/sourced_claude.sh" ]; then . "$HOME/scripts/sourced_claude.sh"; fi
```

Merge these fields into user settings, preserving other fields:

```json
{
  "permissions": {"defaultMode": "bypassPermissions"},
  "sandbox": {"enabled": false}
}
```

The ordinary location is `~/.claude/settings.json`; AgentShell accounts use
`$CLAUDE_CONFIG_DIR/settings.json`. AgentShell links missing authored settings
from the baseline, but retains an already-existing profile file. On this host,
the native installer had created `lab`'s separate `autoUpdatesChannel: latest`
setting, so the two permission fields were merged there as well. `personal`
inherits the baseline settings. Keep these files private; do not replace an
account's whole directory to share preferences.

To restore approval prompts, remove the source line, start a new shell, and
remove `permissions.defaultMode: bypassPermissions` from every affected settings
file. Review the explicit sandbox preference separately.

## Verification and Download Recovery

```bash
python3 test_claude_shell.py
bash -n claude-shell.sh
claude --version
claude doctor
claude auth status
```

On 2026-09-16 the regular bootstrap download hit repeated connection resets.
Recovery downloaded the same official release's compressed `linux-x64/claude.zst`
with bounded curl retries/resume, verified its checksum, decompressed it, verified
the raw binary against the signed release manifest, then ran that binary's
`install latest`. No unofficial mirror or modified binary was used.

The release base is `https://downloads.claude.ai/claude-code-releases/VERSION`;
`manifest.json`, `manifest.json.sig`, and `manifest.zst.json` describe the
artifacts. Verify the signing key fingerprint against Anthropic's official
[verification instructions](https://code.claude.com/docs/en/setup#verify-the-manifest-signature),
not a value supplied only beside a downloaded binary. This run used a temporary
GPG keyring and checked the installed binary again after installation.

Validated results:

- Signed manifest and both compressed/decompressed checksums passed.
- `claude --version` reported 2.1.273; `claude doctor` found no installation issues,
  with native latest-channel automatic updates enabled.
- Ten shell tests passed, covering permission overrides, account dispatch,
  resume, move argument preservation, invalid inputs, and syntax.
- New Bash shells and both `lab`/`personal` account launch paths resolved Claude.
- `claude auth status` reported not logged in. No model request or billed test
  was made. A real authenticated session move remains an end-to-end check for
  after login; the tests validate the wrapper arguments, not the provider UI.

## Workstation Wrapper Variant

A second, codex-style implementation lives in this folder for machines that
want the same behavior as `codex`/`codexr`/`codexmv`: enforced full access,
a fast folder-scoped resume picker, and bulk session migration with rollback.
It defines the same `claude`, `clauder`, and `claudemv` names, so install only
one variant per machine.

- [claude-clauder-claudemv-wrappers.md](./claude-clauder-claudemv-wrappers.md): behavior, storage layout, `claudemv OLD [NEW]` migration and rollback, AgentShell `--account` routing, verification, failure modes
- [install-wrappers.sh](./install-wrappers.sh): one-shot Linux/WSL installer (copies the scripts below into `~/scripts`, writes `~/bin` shims, adds a guarded `~/.bashrc` block, sets `skipDangerousModePermissionPrompt`)
- [claude_wrapper.sh](./claude_wrapper.sh): shared dispatcher for the three commands
- [claude_session_tool.py](./claude_session_tool.py): session listing, numbered picker, `move`, `rollback`
- [sourced_claude_wrappers.sh](./sourced_claude_wrappers.sh): shell functions and the `clr` alias

# 7090 Native Aliases and AgentShell Defaults

Audit date: 2026-09-13. Codex CLI 0.154.0; installed AgentShell matches its
up-to-date repository. These notes describe this workstation's native path,
not the optional custom SQLite picker documented on other workstations.

## What Was Found

`~/.bashrc` sources `~/scripts/sourced_agent_shell.sh`. Its shell functions are:

- `codex`: native Codex, or named-account dispatch when requested.
- `codexr`: native `codex resume`, preserving arguments and current-folder scope.
- `codexmv`: the existing local Python session-directory migration command.

The functions support an optional `~/scripts/codex_wrapper.sh`, but that file
is not installed here. AgentShell correctly falls back to native commands.
The permission defaults were missing from the actual Codex configuration, so
these functions did not supply the requested unattended full-access behavior.

No replacement picker, new session, session migration, or account-login change
was needed to repair the defaults. `codexr` does not silently inject `--all`;
use that native option only when intentionally selecting across all folders.

## Configuration Repair

The user explicitly requested unattended, unrestricted local CLI launches.
The following top-level values were added, leaving model and reasoning settings
unchanged:

```toml
approval_policy = "never"
sandbox_mode = "danger-full-access"
```

These are the configuration equivalents of `-a never -s danger-full-access`.
They remove local command-approval prompts and the Codex sandbox; use only for
workflows where that access is intentional. See the
[official CLI reference](https://learn.chatgpt.com/docs/developer-commands?surface=cli).
Explicit launch overrides and managed requirements still take precedence.
An already-running session is not reconfigured by editing these files.

Files updated on this workstation:

```text
~/.codex/config.toml
~/.local/share/agentshell/profiles/personal/codex-home/config.toml
~/.local/share/agentshell/profiles/personal/codex-shared-home/config.toml
~/.local/share/agentshell/profiles/lab/codex-home/config.toml
~/.local/share/agentshell/profiles/lab/codex-shared-home/config.toml
```

The important detail is `codex-shared-home/config.toml`: shared-history mode
materializes its own account configuration. It is not a live symlink to
`codex-home/config.toml`, so changing only the latter does not fix current
shared-history launches. Both account views were updated without modifying
credentials. Both accounts' `sessions` paths still resolve to `~/.codex/sessions`.

## Checks

- `codex --version`, `codexr --help`, and `codexmv --help` passed.
- Both `agent-codexr --account personal --help` and the `lab` equivalent passed.
- Codex's local app-server `initialize` and `config/read` API confirmed effective
  `never` and `danger-full-access` for ordinary, personal, and lab launches.
  These checks did not create model conversations or run a prompt.
- AgentShell's isolated Bash test suite passed, including resume argument
  preservation and account/history routing.
- `codexmv` passed an isolated temporary-SQLite test: parent and child paths
  migrated, a similarly named sibling remained unchanged, `CODEX_SQLITE_HOME`
  selected the test state, and a rollback journal was produced. No real thread
  paths or transcripts were modified.

New invocations read the saved settings. Shell re-sourcing is not needed for
this configuration-only repair, although `source ~/.bashrc` remains valid.
Windows tests were not run for this Linux-only configuration audit.

Private configuration backups are under
`~/.local/state/desktop-alias-fix-20260913/`; do not commit them.

# Codex session owners and returning to the ordinary login

Verified with Linux Codex 0.157.1 on 2026-09-27. The reusable implementation,
including Bash/PowerShell account switching, lives in
[AgentShell](https://github.com/lachlanchen/AgentShell).

## Copyable commands

```bash
source "$HOME/scripts/sourced_agent_shell.sh"

# Ordinary Codex, without an active named AgentShell account.
agentshell default
codex login status
codexr

# Named account in the same terminal; cwd and Conda stay unchanged.
agentshell company
codexr

# Locate another opening, without changing it.
codexr --where
codexr --where SESSION_UUID

# Choose one conversation and gracefully close its eligible owner, then resume.
codexr --kill
codexr --account personal --kill SESSION_UUID
codex resume --kill SESSION_UUID

# Migration: close the newest target first; refuse other active targets.
codexmv --kill --latest /old/project /new/project
```

`--kill` aliases the earlier `--close-other` / `--as-close-other`. It does not
intercept native `-f` or `--force`, and it is not automatically enabled for
ordinary resumes. `--where` and `--kill` are Linux/WSL wrapper features;
`agentshell default` also supports Windows PowerShell.

## What actually failed

There were two distinct reports: a conversation shown as open elsewhere, and
an access-token error after a default-home logout/login. Read-only inspection
found neither reported conversation had a live writer lock by the time of the
check. Logs showed their backend instances had shut down.

The CV conversation's log supplied the specific authentication explanation:
**“Skipping auth reload due to account id mismatch.”** A persistent backend
remembered one account while the newly saved default login belonged to another.
It refused to use the new identity and returned the token-refresh error. This
was not evidence that the user secretly had another visible terminal open.

A newly started backend using the unchanged ordinary auth file passed account
lookup and authenticated usage lookup. Resuming the existing conversation with
a fresh backend then stayed open. Old error text can still appear in restored
history; it is not a fresh failure unless a new operation reports it.

## Native task manager is different

Native `codex agents` and its `x` action stop a selected daemon task's turn.
The native “Disconnected from this task. Any running work continues” text
describes the daemon lifecycle; it is not proof of a duplicate TUI.
Stopping a turn and releasing another process's exclusive writer lock are
different operations.

`--where` matches the writer lock's device/inode to the kernel's `/proc/locks`.
It reports the owner PID, parent, executable, working directory and terminal.
`--kill` revalidates ownership and uses a PID file descriptor to send SIGTERM
only to a verified, same-user owner holding exactly the selected conversation.
An eligible desktop owner means that matching app instance closes. Shared
daemons and owners of other sessions are refused. No broad process killing,
SIGKILL escalation, lock deletion, history editing, or account logout is used.

## Fresh backend policy and its tradeoff

This workstation's wrapper now defaults supported local interactive launches
to `AGENT_SHELL_CODEX_DAEMON=off`, adding native `--no-daemon`. It reads the
selected credentials afresh and leaves existing daemons and their tasks alone.
This avoids the stale backend and the previous long socket-path failure;
it does not change Codex's native implementation.

```bash
# One command with native background behavior:
AGENT_SHELL_CODEX_DAEMON=on codexr

# Previous policy, only bypassing overly long named-account socket paths:
AGENT_SHELL_CODEX_DAEMON=auto codexr
```

New no-daemon work requires its CLI process to remain running. It does not
offer the daemon's “continue after closing the view” behavior. `codex agents`,
login/logout, automation, remote endpoints and unrecognized native flags are
not silently rewritten. Existing named account credentials are unchanged.

`agentshell deactivate` restores the previous saved environment. An older
nested shell may have inherited an account before there was any snapshot;
`agentshell default` explicitly clears account routing and selects the ordinary
home, honoring `AGENT_SHELL_BASE_CODEX_HOME` if configured. It never copies
credentials between profiles.

## Related repair and validation

The peer Windows home session, titled “Fix codex app server startup,” was read
with SSH. It had installed current-shell account switching, the socket-length
fallback, and `--close-other` on this workstation. Those repairs were retained
and extended rather than reverted. Private excerpts remain local.

Validation covered real kernel locks and disposable owners, preserving an
unrelated running owner, refusing multi-session and managed-daemon owners,
argument preservation, native helper passthrough, Bash integration, Windows
PowerShell 5.1 isolated integration tests, authenticated account lookup, and an
existing-conversation TUI smoke check. The smoke check sent no model prompt;
only its own test TUI was closed afterward.

Implementation and full safeguards:

- [Takeover helper and commands](https://github.com/lachlanchen/AgentShell/blob/main/docs/session-takeover.md)
- [Ordinary login and stale-backend evidence](https://github.com/lachlanchen/AgentShell/blob/main/docs/ordinary-login-and-daemons.md)
- [Reusable workstation wrapper and picker](https://github.com/lachlanchen/AgentShell/tree/main/contrib/workstation)
- [Earlier socket-path diagnosis](daemon-socket-path-limit.md)

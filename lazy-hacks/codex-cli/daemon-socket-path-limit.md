# Codex 0.157 daemon socket pathname limit

Verified on Linux, 2026-09-26.

## Failure and cause

Starting `codexr` under a named AgentShell account failed before the TUI opened:

```text
Error: app server did not become ready on .../app-server-control/app-server-control.sock
version: 0.157.0: failed to connect ...: path must be shorter than SUN_LEN
```

This failure is local and deterministic. Linux's Unix-domain socket pathname field is 108 bytes including the terminating NUL, leaving at most 107 bytes for the pathname. The constructed workstation paths were 116 bytes for personal, 115 for company, and 111 for lab.

A shorter alias for `CODEX_HOME` alone is not a dependable fix when Codex resolves that home before constructing its control-socket pathname. Existing socket-file symlinks to short `/tmp` targets also do not make the longer pathname passed to `connect()` fit the limit. Measure the pathname Codex constructs, not just the final symlink target.

This is separate from the earlier [workspace-routing timeout](account-routing-timeout.md). Repeated attempts, changing DNS or signing in again do not shorten a Unix socket pathname.

## Installed fix

[AgentShell's startup helper](https://github.com/lachlanchen/AgentShell/blob/main/bin/codex-startup) detects supported local interactive named-account invocations with an overlong socket path and prepends Codex's native `--no-daemon` option. Codex 0.157.0's installed `--help` confirms this option runs without the shared background server, including when one is already running.

Normal usage stays the same:

```bash
codexr
codex --account personal
codexr --account lab --all
```

For a direct native invocation, the explicit workaround is:

```bash
codex --no-daemon resume
```

The helper keeps the account-specific home, login, history, working directory, selected session and existing permission policy. It does not stop a daemon or other sessions. Login, noninteractive commands, remote connections and unrecognized options pass through; this conservative helper does not claim to fix every possible invocation or manually requested daemon command.

The workstation's `~/scripts/codex_wrapper.sh` already calls the installed helper under `~/.local/lib/agentshell/codex-startup`. Existing terminals using that wrapper pick up the behavior on their next launch. No reboot, account reset or history migration is needed.

## Verification and publication

- Native binary identified as `codex-cli 0.157.0`; `--no-daemon resume --help` accepted.
- All 13 startup tests passed, including long canonical paths behind short aliases, account isolation, explicit-option preservation, ordinary failures and bounded routing retries.
- Bash syntax and AgentShell integration tests passed.
- An isolated fake native executable verified the complete installed `codexr` dispatch for personal, company and lab: all received `--no-daemon`, the same resume ID and the correct account home. No real conversation was resumed or sent a prompt during this check.
- The fix and tests were published separately from unrelated local takeover/account-shell work. Existing installed files already contained this socket fix when the interrupted task was resumed; this pass verified and published that implementation.

If native daemon functionality is specifically required later, investigate an upstream socket-path fix or a supported short runtime directory. Do not relocate live credential/history trees merely to shorten this socket.

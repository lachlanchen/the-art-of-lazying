# Codex account-routing timeout: safe recovery across accounts

Date: 2026-09-24. Native CLI observed: 0.156.1.

## The failure

Both a new session and a resume could intermittently exit with:

```text
Error: account/read failed during TUI bootstrap: account/read failed: workspace routing discovery timed out (code -32603)
```

Retrying manually often worked. This happened under two separate AgentShell profiles, not just one conversation.

## What is known, and what is not

The [native account processor](https://github.com/openai/codex/blob/rust-v0.156.1/codex-rs/app-server/src/request_processors/account_processor/workspace_routing.rs) applies a hardcoded **15-second timeout** to configuration/authentication loading and workspace-routing discovery. Its [backend client](https://github.com/openai/codex/blob/rust-v0.156.1/codex-rs/backend-client/src/client.rs) queries an accounts-check endpoint. That routing cache belongs to the running app-server process, not a durable cache shared with the next launch.

Read-only native `account/read` probes succeeded for both profiles: the first calls took approximately 1.2 seconds and cached calls 0.01–0.03 seconds. Authentication was therefore usable at the time of those tests. No evidence justified resetting credentials, changing account ownership, or repairing session history.

Further checks reproduced the failure **without AgentShell**. Six fresh native app-server probes alternated between the two profiles:

| Profile label | Cold `account/read` duration | Result |
| --- | ---: | --- |
| company | 15.006 s | discovery timeout |
| lab | 15.013 s | discovery timeout |
| company | 2.319 s | success |
| lab | 2.334 s | success |
| company | 15.013 s | discovery timeout |
| lab | 15.013 s | discovery timeout |

Separate HTTPS tests found transport trouble too. ChatGPT's DNS returned `172.64.155.209` and `104.18.32.47`. The first address responded in approximately 1.3 seconds, while two probes to the second stalled during TLS and hit a 10-second timeout. Both addresses later recovered: approximately 0.7–0.8 seconds via wired networking and 0.4–0.5 seconds via Wi-Fi. TCP connection delays were also observed. These are test-time public CDN addresses, **not addresses to hardcode**.

Router DNS, Google DNS-over-HTTPS and Cloudflare DNS-over-HTTPS agreed on the records. No evidence supported blaming incorrect DNS records. The transport probes deliberately sent no authentication, so a quick HTTP `401` meant the HTTPS endpoint was reachable; it was not a failure of the user's saved credentials.

**Confirmed:** native discovery can time out independently of AgentShell, and HTTPS transport was intermittently stalling. **Not proven:** which router/upstream component or service caused each stall, or that every native timeout came from the same transport event. The guard is recovery, not proof that the underlying network/service issue has been permanently fixed. No global DNS/route changes, proxy daemon or persistent CDN-IP pinning were introduced.

### Wired versus Wi-Fi follow-up

Three rounds explicitly bound `curl` to each interface and tested both DNS-returned addresses. The endpoint and TLS verification remained unchanged; no account token was sent.

| Path | Successful probes | Observed timings |
| --- | ---: | --- |
| wired, also the default route | 4/6 | 0.77–2.28 s; both addresses hit the 4-second TCP connection deadline in round 3 |
| Wi-Fi | 6/6 | 0.30–0.49 s |

These sequential, closely spaced comparisons point toward the **wired upstream path**. The problem was not consistently tied to just one CDN address. Local wired RX errors/drops and TX errors were zero at inspection, but interface counters cannot rule out an upstream gateway, VPN router or ISP fault.

This is a better-supported diagnosis than blaming AgentShell, account sharing or DNS. It is not proof of which physical hop is at fault. Fixing that path permanently requires gateway/upstream investigation; changing global routes during active remote and Codex sessions could interrupt unrelated work, so that was not done as part of the wrapper repair.

At the time checked, npm and the latest stable GitHub release both reported 0.156.1; no newer stable release was available to test as a fix. No speculative downgrade, binary patch or global network change was made.

## Installed improvement

The reusable implementation is in [AgentShell](https://github.com/lachlanchen/AgentShell), including:

- [`bin/codex-startup`](https://github.com/lachlanchen/AgentShell/blob/main/bin/codex-startup): dependency-free apart from Python 3, with a Linux/WSL TUI startup guard.
- [`tests/test_startup.py`](https://github.com/lachlanchen/AgentShell/blob/main/tests/test_startup.py): 12 regression tests, including pseudo-terminal tests.
- [Full tutorial and wrapper integration](https://github.com/lachlanchen/AgentShell/blob/main/docs/codex-startup-retry.md).

The workstation's `~/scripts/codex_wrapper.sh` invokes the guard only at the final native-launch boundary, after selecting an account/history view and any fast-picker session ID. AgentShell's normal named-account native dispatch also uses the guard. Existing ordinary-command behavior outside an account remains unchanged in generic AgentShell installations; this workstation explicitly integrates the helper into its own wrapper.

### Safety boundaries

- Three total attempts by default; waits of 2 and 4 seconds. Ctrl+C cancels.
- Requires exit status 1, the exact final bootstrap-timeout stderr line, a local interactive terminal and an exit within 120 seconds.
- Preserves the selected account, account-specific `CODEX_HOME`, CWD, executable, arguments and selected resume ID.
- Does not rerun a fast picker, session migration, noninteractive `exec`, review, login, queued work or update. The native picker may reappear when the failed process itself owned it.
- Does not retry other errors, 401 responses, unknown options, remote app-server invocations, worktree creation or successful sessions.
- Does not copy credentials, switch to another account, edit SQLite/JSONL or bypass workspace-routing policy.
- No network preflight on healthy starts, no disk log of terminal input/output. Only a bounded 64-KiB stderr tail exists in memory; stdin/stdout stay connected to the original terminal.
- macOS, Windows and GUI desktop launchers retain their existing behavior; this Linux guard is not silently applied to untested terminal implementations.

The shell wrapper continues to `exec` away rather than waiting in a long-running Bash function, avoiding the older live-edit/unexpected-EOF issue.

## Commands to keep using

In one terminal:

```bash
. "$HOME/.bashrc"
agentshell company
agentshell -v
codexr
```

In another:

```bash
. "$HOME/.bashrc"
agentshell lab
codex
```

Or select an account for a single launch:

```bash
codex --account personal
codexr --account company --all
```

`agentshell -v` shows the local profile label and state paths. Inside Codex, `/status` checks the authenticated identity. Do not log out or log in again merely because a discovery request timed out.

Existing workstation terminals that already use the wrapper receive the helper on their next invocation; no reboot is needed. Running sessions are not restarted. Source `.bashrc` only when refreshing shell definitions is needed.

## Opt-out / rollback

```bash
CODEX_STARTUP_ATTEMPTS=1 codexr
CODEX_STARTUP_ATTEMPTS=1 codex --account lab
```

For a persistent opt-out, export that variable in the shell startup file. Range: 1–5 total attempts, default 3; malformed values disable retries. This restores a single native attempt without touching history or account data.

## Verification

- Bash syntax checks passed for AgentShell and the workstation wrapper.
- AgentShell integration tests passed after incorporating the existing upstream 0.5.0 changes.
- All 12 startup-guard tests passed: success, bounded failure, exact matching, Ctrl+C, identity/arguments/CWD, TTY preservation, passthrough and opt-out.
- Installed `codex --version` worked for both selected profiles, including retry opt-out.
- The user subsequently opened the lab TUI successfully and confirmed that it seemed to work. No retry was visible in the provided successful transcript.

If the bounded retries still fail, preserve the final native error and investigate service/network latency or a verified client fix. Do not escalate to rewriting authentication or shared session state without evidence.

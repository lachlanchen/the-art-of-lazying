# Full-Access `claude`, `clauder`, and `claudemv` (Linux/WSL)

## Outcome

Claude Code gets the same workstation defaults as the `codex` / `codexr` / `codexmv` wrappers in [`../codex-cli/`](../codex-cli/README.md): every launch runs with full access and never asks for permission, resuming is one short command with a folder-scoped picker, and saved sessions survive moving or renaming a project folder.

| Command | Does |
|---|---|
| `claude [args]` | Stock `claude` with `--allow-dangerously-skip-permissions --permission-mode bypassPermissions` enforced. All other arguments pass through. |
| `claude resume ...` | Same as `clauder`. |
| `clauder` | Fast picker over the sessions started in the current folder, then native `claude --resume <id>`. |
| `clauder --all` / `clauder --non-strict TEXT` | Picker over every folder, or a partial match on folder, prompt, or `/rename` title. |
| `clauder SESSION_ID` / `clauder -c` | Straight to native resume / continue. |
| `claudemv OLD [NEW]` | Migrate saved sessions after a folder move, write a rollback journal, then open the picker in `NEW` (default `.`). |
| `claude --account NAME ...` | Route through [AgentShell](../codex-cli/multiple-account-terminals-with-agentshell.md) so that account's isolated Claude home is used. Works for all three commands. |
| `clr` | Alias for `clauder`. |

Escape hatches: `command claude ...` runs the stock binary, and `CLAUDE_REAL_BIN=/path/to/claude` pins which binary the wrapper launches.

This is the heavier of the two variants in this folder. [`README.md`](./README.md) describes `claude-shell.sh`, which defines the same three names but delegates everything to native Claude: its `claudemv DESTINATION [SESSION_ID]` moves one conversation with native `/cd`, and it honors an explicit `--permission-mode`. The wrappers below instead behave like `codexmv` (migrate every saved session under a folder, with a journal) and always enforce bypass mode. Install one variant per machine, never both, because they define the same shell functions.

## Why a wrapper instead of an alias

- Claude Code refuses `--dangerously-skip-permissions` in some contexts unless the `--allow-dangerously-skip-permissions` form and the `bypassPermissions` mode are both given, and it shows a one-time confirmation unless `skipDangerousModePermissionPrompt` is set in `settings.json`. The wrapper and installer handle both.
- An alias only exists in interactive shells. The `~/bin` shims make `claude`, `clauder`, and `claudemv` work from scripts, tmux, `xdg-open`, and AgentShell's `agent-run`, and the shell functions and shims share one dispatcher so they never drift apart.
- Claude keys a session by the folder it started in. The picker changes into that folder before resuming, so `clauder --all` can reopen work from anywhere.

## Installed files

- `~/scripts/claude_wrapper.sh` — argument handling, real-binary lookup, native Claude dispatch
- `~/scripts/claude_session_tool.py` — session listing, numbered picker, `move` and `rollback`
- `~/scripts/sourced_claude_wrappers.sh` — shell functions plus the `clr` alias
- `~/bin/claude`, `~/bin/clauder`, `~/bin/claudemv` — command shims
- `~/.bashrc` — one guarded block that sources the functions, placed after any other `claude()` definition (for example AgentShell's) so this one wins

Copies of the three scripts and a one-shot installer live next to this document:

```bash
bash ~/Projects/the-art-of-lazying/lazy-hacks/claude-cli/install-wrappers.sh
. ~/.bashrc
claude --version
```

`~/bin` must be early on `PATH` (this workstation's `~/.bashrc` ends with `export PATH="$HOME/bin:$PATH"`). The wrapper finds the real binary by walking `type -P -a claude` and skipping its own shims, then falls back to the nvm, `~/.claude/local`, `~/.local/bin`, and system locations.

## How Claude stores sessions

Every conversation is one JSON-lines file:

```text
$CLAUDE_CONFIG_DIR/projects/<encoded-cwd>/<session-id>.jsonl
```

`CLAUDE_CONFIG_DIR` defaults to `~/.claude`; AgentShell exports a per-account value. The folder name is the absolute working directory with every character outside `[A-Za-z0-9]` replaced by `-`, so `/home/me/ProjectsLFS/DiffEvents` becomes `-home-me-ProjectsLFS-DiffEvents`. Each record inside the file repeats the absolute `cwd`, `history.jsonl` records the `project` per prompt, and `sessions/<pid>.json` describes each live process. The helper reads only the head and tail of each file, so a multi-hundred-megabyte transcript still lists instantly.

## `clauder` picker

```text
Claude sessions (exact cwd: /home/me/ProjectsLFS/LazyTunnel):
1. 2026-09-16 12:29  LazyTunnel - managed remote service
2. 2026-09-15 08:10  add account invitations to the CLI
Select 1-2 (Enter = 1, q = quit):
```

Rows show the `/rename` title when there is one, otherwise the first prompt. Selection uses the session ID, so similar titles cannot resume the wrong row. Options:

```bash
clauder                      # sessions started in this folder
clauder --all                # every folder, with the folder shown per row
clauder --non-strict lazy    # partial match on folder, prompt, or title
clauder -C ~/other/folder    # pick for that folder and resume there
clauder --native             # Claude's own picker
clauder --model opus 019e... # unknown options and IDs pass straight through
CLAUDE_RESUME_PICKER_ENABLE=0 clauder   # disable the fast picker globally
```

When nothing matches, the helper prints the hint to try `--all` or `--non-strict` instead of opening an empty native picker.

## `claudemv` session migration

After moving a project folder, its Claude sessions still point at the old path and `clauder` in the new folder finds nothing. Run:

```bash
cd ~/ProjectsLFS/OpenHI
claudemv ~/ProjectsLFS/nhi_reconstruction          # NEW defaults to .
claudemv ~/ProjectsLFS/nhi_reconstruction ~/ProjectsLFS/OpenHI --latest
claudemv ~/ProjectsLFS/nhi_reconstruction --no-resume
```

What it does, in order:

1. Finds every project folder whose sessions started at `OLD` or beneath it (subfolders keep their suffix).
2. Refuses if a live Claude process still has its working directory under `OLD`, unless `--force` is given, because that process keeps appending to the old file path.
3. Writes a journal to `$CLAUDE_CONFIG_DIR/backups/claudemv/move-<timestamp>.json` before changing anything.
4. Renames the project folder to the new encoded name, or merges its files if the target already exists (existing files are never overwritten).
5. Rewrites the top-level `cwd` in every moved transcript line and the `project` field in `history.jsonl`. Nested paths inside tool output are left untouched, since they are content.
6. Opens the fast picker in `NEW` (`--latest` resumes the newest migrated session directly, `--native` uses Claude's picker, `--no-resume` stops after the migration).

Undo:

```bash
python3 ~/scripts/claude_session_tool.py rollback \
  ~/.claude/backups/claudemv/move-20260916-123346-951986.json
```

Rollback is a second migration with the roots swapped, so it writes its own journal too. Verified on a copy of a real config directory: after move plus rollback, `diff -r` reported the projects tree and `history.jsonl` byte-identical to the original.

## AgentShell accounts

`--account NAME` as the first argument of any of the three commands re-executes through `agent-run --account NAME`, which activates that profile's `CLAUDE_CONFIG_DIR` and then resolves `claude`, `clauder`, or `claudemv` from `PATH`. The wrapper prepends `~/bin` to `PATH` for that hop so AgentShell lands back in the wrapper rather than the stock binary. Inside a persistent `agentshell NAME` terminal the plain commands already use that account because the profile shell sources `~/.bashrc`.

```bash
claude --account lab
clauder --account company --all
claudemv --account personal ~/old/path ~/new/path
```

## Verification

```bash
claude --version                                   # prints the version through the wrapper
claude --permission-mode plan --version            # user-supplied modes are stripped, still works
bash -ic 'type claude clauder claudemv'            # all three are functions in interactive shells
python3 ~/scripts/claude_session_tool.py list --scope all --limit 5
CLAUDE_PICKER_SELECT_INDEX=1 clauder               # non-interactive pick of the newest row
```

For a safe end-to-end test of `claudemv`, copy `~/.claude` to a scratch folder and point `CLAUDE_CONFIG_DIR` at the copy before running the move and rollback.

## Failure modes

- `claude wrapper error: real Claude binary not found` — Claude Code is not installed or not on `PATH`; set `CLAUDE_REAL_BIN`.
- `clauder` opens the native picker with a note — `~/scripts/claude_session_tool.py` is missing or not executable.
- `claudemv: refusing to move while these Claude sessions are still running` — close those sessions or pass `--force`.
- Two different `claude` functions in one shell — make sure the `>>> Claude wrappers >>>` block comes after AgentShell's `sourced_agent_shell.sh` line in `~/.bashrc`.

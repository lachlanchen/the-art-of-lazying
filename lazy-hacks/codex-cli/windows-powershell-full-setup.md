# Full Windows PowerShell Setup for `codex`, `codexr`, `cr`, and `codexmv`

This is the Windows PowerShell version of the `the-art-of-lazying` Codex CLI helpers.

## Goal

Install four helpers on this Windows machine:

- `codex`: wraps the real Codex CLI, always enforces `-s danger-full-access -a never`, and forwards normal prompts and subcommands unchanged.
- `codexr`: shorthand for `codex resume`.
- `cr`: alias to `codexr`.
- `codexmv`: rewrites stored Codex session `cwd` values after moving or renaming a project folder.

The implementation is installed into both common profile paths:

```text
%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
```

## Install

From this repository:

```powershell
powershell -ExecutionPolicy Bypass -File .\lazy-hacks\codex-cli\install-codex-wrappers-windows.ps1
```

Open a new PowerShell after installation, or manually dot-source the profile.

## Usage

Start Codex with preferred defaults:

```powershell
codex
```

Normal Codex prompts and native subcommands still pass through the wrapper:

```powershell
codex "summarize this repo"
codex resume
codex exec --help
codex login --help
codex --version
```

The wrapper does not inject `exec` or maintain its own subcommand list. It removes conflicting sandbox and approval arguments before the `--` option terminator, adds the preferred defaults once, and lets the real Codex CLI interpret everything else. The `--` token and every argument after it are forwarded literally.

Resume from the current folder:

```powershell
codexr
```

Use the shorter alias for the same resume picker:

```powershell
cr
```

Resume a known session in a specific directory:

```powershell
codexr -C C:\Users\Administrator\Projects 019e6449-7a73-74d3-bd33-154399427cc5
```

Migrate stored session paths after a repo or project directory moved:

```powershell
codexmv C:\Users\Administrator\Projects\old-repo C:\Users\Administrator\Projects\new-repo
```

Migrate only, without opening a nested Codex UI:

```powershell
codexmv --no-resume C:\Users\Administrator\Projects\polarizer C:\Users\Administrator\Projects
```

Auto-resume the newest migrated session:

```powershell
codexmv --latest C:\Users\Administrator\Projects\old C:\Users\Administrator\Projects\new
```

## What `codexmv` Edits

`codexmv` edits only local Codex session metadata. On current Codex builds, resume state can appear in two places:

```text
%USERPROFILE%\.codex\state_5.sqlite
%USERPROFILE%\.codex\sessions\YYYY\MM\DD\rollout-*.jsonl
```

It updates:

- `threads.cwd` in `state_5.sqlite`, when that table contains matching rows.
- structured `cwd` fields inside per-session JSONL files, especially `session_meta.payload.cwd` and `turn_context` payloads.

Before updating, it creates backups:

```text
state_5.sqlite.bak.YYYYMMDD-HHMMSS
rollout-....jsonl.bak.codexmv.YYYYMMDD-HHMMSS
```

It does not move files and does not modify repositories.

## Why the Resume Chooser Can Still Show the Old Folder

If a `codex resume` picker is already open, it has already loaded the old session metadata into memory. After running `codexmv`, cancel that old picker with `Ctrl+C` and start a fresh resume command.

The important field for the chooser is usually the first line of the per-session JSONL:

```text
session_meta.payload.cwd
```

In the V-SPICE migration on Windows, `state_5.sqlite` had no matching row, but `session_meta.payload.cwd` still pointed at:

```text
C:\Users\Administrator\Projects\polarizer
```

After patching the JSONL metadata, a fresh resume correctly used:

```text
C:\Users\Administrator\Projects
```

## Windows Notes

- The wrapper uses `codex.cmd` when available to avoid recursively calling the PowerShell function named `codex`.
- The pass-through functions read PowerShell's automatic `$args` array. A named advanced-function parameter would let PowerShell consume native flags such as `-C` before Codex sees them.
- The normalized argument result is always captured with `@(...)`. This preserves a one-item argument list instead of allowing PowerShell to turn it into a scalar string.
- Argument normalization stops at `--`, preserving literal prompts and command arguments after the option terminator.
- `codexmv` uses Python's built-in `sqlite3` module, so it does not require a separate `sqlite3.exe` install.
- `codexmv` also patches per-session JSONL metadata because newer Codex resume behavior can read from `session_meta.payload.cwd`.
- `--no-resume` is a Windows extension for safe use inside an already-running Codex session.
- Open a new terminal after install so the profile loads automatically.

## Fix `unexpected argument 'u'`

An older version of the PowerShell wrapper could fail on any command that left exactly one argument after normalization. For example:

```powershell
codex -s danger-full-access -a never resume
```

could produce:

```text
error: unexpected argument 'u' found

Usage: codex exec [OPTIONS] [PROMPT]
```

PowerShell had collapsed the one-item normalized result (`resume`) into a scalar string. Splatting that scalar with `@pass` then passed its characters separately instead of forwarding one `resume` argument.

The fixed wrapper preserves the result as an array:

```powershell
$pass = @(__CodexNormalizeArgs -InputArgs @($args))
```

The `codex` and `codexr` wrappers use raw `$args` rather than a named advanced-function parameter. This prevents PowerShell from interpreting native `-C` as an abbreviation of a wrapper parameter such as `$CodexArgs`. The normalizer also copies `--` and everything after it unchanged.

To update an existing installation, pull this repository, rerun the installer, and reload the current profile or open a new PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\lazy-hacks\codex-cli\install-codex-wrappers-windows.ps1
. $PROFILE
```

## Verify

```powershell
Get-Command codex
Get-Command codexr
Get-Command cr
Get-Command codexmv
codex --version
codex -C $PWD --version
codex resume --help
codex -s danger-full-access -a never resume --help
codex exec --help
codexr --help
codexr resume --help
codexr -C $PWD --help
cr --help
codexmv --help
```

The resume checks should print `codex resume` help. They should not show `codex exec` usage or split `resume` into individual characters.

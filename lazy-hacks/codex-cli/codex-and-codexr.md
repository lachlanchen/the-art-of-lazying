# `codex` and `codexr` on This Linux Machine

## Goal
These shell wrappers make Codex behave consistently on this workstation.

Defaults enforced by the wrapper:
- sandbox: `danger-full-access`
- approval: `never`

Current implementation lives in:
- `~/.bashrc`

## Main behaviors

### `codex`
- strips user-supplied mode args such as `-s` and `-a`
- re-applies `-s danger-full-access -a never`
- for non-resume commands, otherwise behaves like normal Codex
- for `codex resume`, uses the custom resume picker when eligible

### `codexr`
- shorthand wrapper around `codex resume`
- same enforced mode defaults
- with no args, opens the resume picker for the **exact current working directory**
- with a session id, resumes that id directly

### `cr`
- alias to `codexr`

## Resume picker behavior
The wrapper picker reads from:
- `~/.codex/state_5.sqlite`

By default it shows only interactive sessions:
- `source IN ('cli','vscode')`

It also filters out blank-title sessions.

Selection is currently:
- numeric only
- `q` to cancel

It does **not** select by typing a session name at the prompt.

## Supported resume modes

### Exact current cwd
```bash
codexr
codex resume
```

This looks for sessions whose stored `cwd` exactly matches the current directory.

### Exact explicit cwd
```bash
codexr -C /home/lachlan/ProjectsLFS/Zhengyu
codex resume --cwd /home/lachlan/ProjectsLFS/Zhengyu
```

### All recent sessions
```bash
codexr --all
codex resume --all
```

### Include non-interactive sessions
```bash
codex resume --include-non-interactive --all
```

That includes `exec`-style sessions too.

### Partial path search
```bash
codexr --non-strict OpenHI
codex resume --non-strict Organoid
```

`--non-strict` searches by **partial cwd match**.

Important:
- it matches against stored session `cwd`
- it does not search by title text
- it is most useful when a project path is only partly remembered

### Bypass the wrapper picker
```bash
codexr --native
codex resume --native
```

This falls back to native Codex resume behavior.

### Direct session id
```bash
codexr 019ab50c-62e3-70e1-ab5d-a9104197d7a3
codex resume 019ab50c-62e3-70e1-ab5d-a9104197d7a3
```

Direct ids bypass the custom picker and resume immediately.

## What the wrapper strips or preserves
The wrapper strips only the mode arguments:
- `-s`
- `-a`
- `--sandbox-mode`
- `--sandbox_mode`
- `--approval-policy`
- `--approval_policy`

Everything else is passed through normally, except:
- `--native` is consumed by the wrapper and not passed to Codex

## Examples
```bash
codex
codex chat
codex resume
codex resume --all
codexr
codexr --non-strict OpenHI
codexr --native
cr
```

## Notes
- On this machine, the wrapper is enabled on both native Linux and WSL.
- If you change `~/.bashrc`, reload it with:
```bash
source ~/.bashrc
```

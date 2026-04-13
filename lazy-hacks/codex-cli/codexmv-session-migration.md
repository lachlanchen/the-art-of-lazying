# `codexmv`: Move Session Paths After a Repo Rename or Move

## Goal
`codexmv` fixes Codex resume after a project folder has been moved or renamed.

It rewrites stored session `cwd` values from an old path to a new path, then opens resume in the new location.

Current implementation lives in:
- `~/.bashrc`

## Command
```bash
codexmv [--latest|-l] <oldpath> [newpath]
```

Arguments:
- `oldpath`: required
- `newpath`: optional, defaults to current directory `.`

Modes:
- default: migrate then open the normal resume picker in the new/current folder
- `-l`, `--latest`: migrate then auto-resume the most recently updated migrated session

## What gets migrated
Database:
- `~/.codex/state_5.sqlite`

Table/field:
- `threads.cwd`

Matches:
- exact path: `cwd == oldpath`
- subtree: `cwd LIKE oldpath/%`

Nested paths keep their suffix after migration.

Example:
- old: `/a/old/project/subdir`
- new: `/b/new`
- result: `/b/new/subdir`

## Supported path styles
```bash
codexmv ../oldpath
codexmv ../oldpath .
codexmv ~/Projects/old ~/Projects/new
codexmv /home/lachlan/old /home/lachlan/new
```

All paths are normalized to absolute paths before the DB update.

## Typical workflow
### Move old sessions into current folder
```bash
cd ~/ProjectsLFS/OpenHI
codexmv ../nhi_reconstruction .
```

### Move old sessions into an explicit new folder
```bash
codexmv ~/Projects/old ~/Projects/new
```

### Auto-resume latest migrated session
```bash
codexmv -l ../oldpath ./newpath
```

## What happens after migration
Default mode:
- prints migrated count
- opens the resume picker in the new/current folder
- you choose the session manually

Latest mode:
- prints migrated count
- resumes the newest migrated session immediately

## Safety notes
- this changes only Codex session metadata, not repository files
- it updates all matching sessions in one SQLite transaction
- if you want your own backup first, copy:
```bash
cp ~/.codex/state_5.sqlite ~/.codex/state_5.sqlite.bak
```

## Real example from this machine
This was used to move sessions from:
- `/home/lachlan/ProjectsLFS/nhi_reconstruction`

to:
- `/home/lachlan/ProjectsLFS/OpenHI`

Command:
```bash
cd ~/ProjectsLFS/OpenHI
codexmv ../nhi_reconstruction .
```

## Troubleshooting
### No sessions found under old path
- check the old path carefully
- try absolute paths
- make sure you are using the same Linux user that created the sessions

### sqlite3 missing
```bash
sudo apt install sqlite3
```

### Wrapper not updated in current shell
```bash
source ~/.bashrc
```

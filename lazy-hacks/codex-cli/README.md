# Codex CLI Hacks

This folder stores practical Codex CLI workflow tweaks used on this machine.

## Files
- [codex-and-codexr.md](./codex-and-codexr.md)
  - Robust shell overrides for `codex` and `codexr`
  - Enforces `-s danger-full-access -a never`
  - Handles duplicated `-s`/`-a` flags safely
- [codexmv-session-migration.md](./codexmv-session-migration.md)
  - Migrate Codex session cwd mappings from old path to new path
  - Resume picker by default, latest with `-l/--latest`

## Scope
These docs assume Bash and Codex local state under `~/.codex`.

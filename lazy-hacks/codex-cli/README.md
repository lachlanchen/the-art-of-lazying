# Codex CLI Hacks

This folder stores practical Codex CLI workflow tweaks used on this machine.

## Files
- [macos-zsh-full-setup.md](./macos-zsh-full-setup.md)
  - self-contained macOS `zsh` setup for `codex`, `codexr`, and `codexmv`
  - includes repo remotes, clone commands, exact shell block, and verification
- [codex-and-codexr.md](./codex-and-codexr.md)
  - Robust shell overrides for `codex` and `codexr`
  - Enforces `-s danger-full-access -a never`
  - Handles duplicated `-s`/`-a` flags safely
- [codexmv-session-migration.md](./codexmv-session-migration.md)
  - Migrate Codex session cwd mappings from old path to new path
  - Resume picker by default, latest with `-l/--latest`
- [codexmv-macos-zsh.md](./codexmv-macos-zsh.md)
  - macOS `zsh` tutorial for `codexmv`
  - Includes the exact `~/.zshrc` helper and function block

## Scope
These docs assume Codex local state under `~/.codex`.
Bash and macOS `zsh` examples are both included.

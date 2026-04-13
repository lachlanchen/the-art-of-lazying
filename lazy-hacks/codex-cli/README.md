# Codex CLI Hacks

This folder stores practical Codex CLI workflow tweaks used on this machine.

## Files
- [codex-and-codexr.md](./codex-and-codexr.md)
  - current Linux `bash` behavior for `codex`, `codexr`, and `cr`
  - enforced `danger-full-access` + `never`
  - exact-cwd resume picker, `--all`, `--native`, and `--non-strict`
- [codexmv-session-migration.md](./codexmv-session-migration.md)
  - migrate stored Codex session cwd mappings after a repo move or rename
  - default picker flow and `-l/--latest`
  - includes the `nhi_reconstruction -> OpenHI` example
- [macos-zsh-full-setup.md](./macos-zsh-full-setup.md)
  - self-contained macOS `zsh` setup for `codex`, `codexr`, and `codexmv`
- [codexmv-macos-zsh.md](./codexmv-macos-zsh.md)
  - macOS `zsh` tutorial for `codexmv`

## Scope
These docs assume Codex local state under:
- `~/.codex`

The Linux `bash` docs reflect the wrappers currently used from:
- `~/.bashrc`

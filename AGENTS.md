# Repository Guidelines

## Scope
- This repo, `the-art-of-lazying`, is the main shareable notes and workflow hub for this workstation.
- Prefer saving reusable operational knowledge here under `lazy-hacks/` when it is safe to publish.

## Project Structure & Module Organization
- `code/`: primary local projects (for example `code/EinkWordsGPT/`).
- `scripts/`: operational shell tooling (for example `scripts/lazy-care/SafeShell/`).
- `vlogs/`: focused utilities and vlog-linked tools (for example `vlogs/repo2text/`).
- `lazy-hacks/`: short operational playbooks (for example `lazy-hacks/codex-cli/`).
- `website/meta-lazying-art/`: static site for `meta.lazying.art` (`index.html`, `styles.css`, `app.js`).
- `i18n/`: translated READMEs.
- `demos/`, `figs/`, `books/`, `examples/`: assets, references, and examples.

## Build, Test, and Development Commands
- `python3 -m http.server 8090` (run inside `website/meta-lazying-art/`): local preview of the website.
- `bash -n <script.sh>`: syntax-check shell scripts before committing.
- `git status -sb`: quick workspace check.
- `git pull --rebase origin main`: keep history linear before pushing.
- GitHub Pages deploy is automated by `.github/workflows/meta-lazying-art-pages.yml` on pushes to `main` affecting `website/meta-lazying-art/**`.

## Coding Style & Naming Conventions
- Markdown: concise, task-oriented, with clear headings and copy-safe command blocks.
- Shell: POSIX/Bash-safe patterns, quote variables (`"$var"`), avoid destructive defaults.
- Web files: keep static and dependency-light; prefer readable CSS variables in `styles.css`.
- Naming:
  - Docs: kebab-case (for example `codexmv-session-migration.md`).
  - Utility folders: descriptive and lowercase (for example `lazy-hacks/codex-cli`).

## Testing Guidelines
- No global test framework is enforced repository-wide.
- Validate by artifact type:
  - Shell: `bash -n` and manual dry-run.
  - Website: local preview + responsive check (desktop/mobile widths).
  - Docs: verify links/paths resolve from repo root.

## Commit & Pull Request Guidelines
- Commit style: short imperative summary (`add ...`, `update ...`, `remove ...`), scoped to one change set.
- Keep commits focused (docs vs site vs scripts) to simplify review/reverts.
- When updating this repo, commit and push the intended changes unless the user explicitly asks not to.
- PRs should include:
  - purpose and impacted paths,
  - before/after screenshots for UI changes (`website/`),
  - deployment notes for Pages/domain-related edits.

## Security & Configuration Tips
- Never commit secrets, tokens, private keys, or `.env` values.
- Treat `CNAME`, workflow files, and domain settings as production-impacting changes; review carefully.

# Use AgInTi with DeepSeek when Codex is unavailable

Updated: 2026-10-01. Tested build: **0.20.337-integration.0**.

AgInTi can perform small project tasks using DeepSeek's API and its own file,
shell, and session tools. It does not need Codex quota for this workflow. DeepSeek
API billing is separate. This is a tested fallback, not a claim of identical
capability or reliability to Codex.

## Copyable commands

From the project folder in a terminal:

```bash
aginti --provider deepseek --routing fast --no-wrappers
```

Then type the task normally. For example: “Fix the failing tests and explain the
change.” There is no need to reload `.bashrc` after this CLI upgrade.

One request:

```bash
aginti run --provider deepseek --routing fast --no-wrappers \
  "Read notes.txt and risks.txt. Write summary.md. Leave the inputs unchanged."
```

Resume an AgInTi session from the same project:

```bash
aginti resume
aginti resume latest --no-wrappers
aginti resume SESSION_ID --no-wrappers "Continue and run the tests."
```

Configure a DeepSeek key only if not already configured:

```bash
aginti auth deepseek
```

Keys remain in private account/project configuration. Do not put them in a
handoff note or commit them. `codexr` and `aginti resume` use separate histories;
AgInTi does not automatically resume a Codex JSONL file. A short project handoff
note with completed work, changed files, tests, and the next action is sufficient.

For more difficult work, omit `--routing fast` to use smart routing. To pin an
executor, use `--routing manual --model deepseek-v4-pro`. SCS planning and
validation may use their separately configured role models. `--no-wrappers`
disables external agent wrappers, including when resuming a session that had
enabled them; it does not disable every shell tool or configured external API.

## Permissions

Normal mode uses the existing Docker workspace for general coding. It supports
project-local edits and verification without granting unrestricted host access.
Restricted host mode is available for existing local toolchains:

```bash
aginti --provider deepseek --routing fast --no-wrappers --sandbox-mode host
```

That host command remains subject to the shell policy. Arbitrary interpreter
snippets can stop for permission, even when ordinary tests are allowed. Prefer
the default Docker workspace for general coding instead of enabling Danger mode
to bypass a refusal. Host mode is not an OS sandbox.

## What was repaired

- Deployed the earlier deadline/cancellation fix for model compatibility retries.
- Deployed the earlier fix separating read-only inputs from requested outputs.
  A live baseline summary request temporarily modified an input before restoring
  it; the repaired run created only the intended output.
- Fast/manual executor selection now survives activation of planning/validation.
- Added `--no-wrappers` for new and resumed sessions.
- A read-only `find` without a depth bound is still denied, but it is recoverable:
  the agent can choose a bounded search instead of asking for broad permissions.
- Removed an instruction that encouraged irrelevant, unbounded cache searches;
  restricted host tool descriptions now explain their actual execution limits.

## Evidence and limits

The existing full suite and focused policy/model tests passed. Two pre-existing
document-worker checks skipped their occupied test port; they were not counted
as live service validation.

A fresh live run completed a two-source summary, code repair with real tests and
22 independent oracle checks, and a Chinese README update after resuming the same
session. Input files stayed unchanged, and the documentation follow-up preserved
implementation/test bytes. All task execution used DeepSeek; no external Codex
agent wrapper ran.

One earlier code patch passed its supplied tests but missed another rounding
case. AgInTi repaired it after a normal follow-up. Review changes and test useful
edge cases; this workflow still benefits from human judgment.

The source and repeatable opt-in evaluator are in
[AgInTiFlow's tagged guide](https://github.com/lazyingart/AgInTiFlow/blob/v0.20.337-integration.0/docs/deepseek-cli-fallback.md)
and its
[acceptance record](https://github.com/lazyingart/AgInTiFlow/blob/v0.20.337-integration.0/aginti-work-examples/deepseek-cli-fallback-20261001.md).
The version is an integration release; the stable npm `latest` channel is not
silently promoted. Existing local-first defaults and application services remain
unchanged. No reboot is required.

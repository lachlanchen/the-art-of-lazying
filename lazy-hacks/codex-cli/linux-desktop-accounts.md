# Official Codex desktop on Linux with company, personal, and lab accounts

Verified on Ubuntu 24.04.4 amd64, 2026-09-10, using the official `chatgpt 26.903.71938` package. OpenAI's Linux preview is named **ChatGPT** and includes Codex. [Official Linux installation guide](https://learn.chatgpt.com/docs/linux/linux-app).

## Open a named desktop

With [AgentShell](https://github.com/lachlanchen/AgentShell) installed and the account already logged in:

```bash
source "$HOME/.bashrc"
agent-desktop company
agent-desktop personal
agent-desktop lab
```

These open independent app instances using the existing account credentials. Opening the same account again focuses/reuses its app. The original terminal commands `codex`, `codexr`, and `codexmv` retain their behavior.

```bash
# Equivalent explicit account form
codex-desktop --account personal

# Reuse the current AgentShell account
agentshell company -- agent-desktop

# Create persistent Applications-menu shortcuts
agent-desktop --install-launchers company personal lab
```

Search Applications for **Codex — Company**, **Codex — Personal**, or **Codex — Lab**. Pin whichever shortcuts you use to the dock. The plain vendor **ChatGPT** launcher opens its normal default profile. The named shortcuts remain installed after reboot; apps launch on demand rather than automatically opening three windows at every login.

## Install and update

Use the official package for the machine's architecture. On amd64 Ubuntu:

```bash
mkdir -p "$HOME/Downloads"
curl --fail --location --retry 3 \
  https://persistent.oaistatic.com/codex-app-prod/linux/deb/latest/chatgpt_amd64.deb \
  -o "$HOME/Downloads/chatgpt_amd64.deb"
sudo apt install "$HOME/Downloads/chatgpt_amd64.deb"
```

The vendor package registers its signed APT repository. Future updates are ordinary package updates:

```bash
sudo apt update
sudo apt install --only-upgrade chatgpt
```

In an existing AgentShell checkout, run `git pull --ff-only` followed by `./install.sh`. For a first account login:

```bash
source "$HOME/.bashrc"
codex --account personal login
codex --account personal login status
agent-desktop personal
```

For remote browser callback difficulties, use `codex --account personal login --device-auth`. Verify the actual identity in the app's profile menu: local account labels do not define which provider account is signed in.

## What made isolation work

AgentShell routes `CODEX_HOME` and `CODEX_SQLITE_HOME` as it already does for CLI accounts. Each app also receives a private GUI directory:

```text
~/.local/share/agentshell/profiles/ACCOUNT/codex-desktop
```

Both the environment variable `CODEX_ELECTRON_USER_DATA_PATH` and the command-line flag `--user-data-dir` must point there. Testing this Linux build with only the environment variable let early Chromium state use the default Codex folder. Setting both gave three distinct browser profiles and native instance locks. The source was inspected read-only; the installed vendor app was not patched.

Each named shortcut has `StartupWMClass=AgentShellCodex-ACCOUNT`, matching its app's `--class` argument. Ordinary launchers do not enable remote debugging, change `HOME`, disable sandboxing, alter the display server, or modify existing remote-access services.

The existing shared-history choice is retained. Three different identities can see the same saved sessions when shared mode is selected. This is intentional access to shared content, not a security boundary between people. Use private history or separate OS users when appropriate. The app's approval settings are visible separately from the CLI defaults.

## First-run issue and checks

All three saved AgentShell identities were recognized. One new profile initially displayed onboarding. Clicking **Back to ChatGPT** before completing setup left a blank loading screen in this preview. Restarting just that idle app restored onboarding; continuing setup and confirming **Skip → Go to ChatGPT** reached the normal Codex composer. Credentials and history were retained.

Checks performed:

- Matched the downloaded package size and SHA-256 to the official APT index before installation.
- Confirmed separate authentication identities and per-account GUI directories/processes.
- Opened the normal composer and shared-history sidebar in all three accounts.
- Verified account routing, paths with spaces, argument forwarding, inherited-token clearing, and idempotent desktop entries with six launcher tests; existing AgentShell Bash tests passed.
- Relaunched without the temporary loopback inspection ports; the normal shortcuts do not expose CDP.

The package bundles a backend CLI independently of the workstation's existing CLI. Do not replace that backend merely to match version numbers. Linux is a preview: recheck profile isolation after major app updates, and consult the official feature limitations.

## Reusable code and troubleshooting

- [Launcher source](https://github.com/lachlanchen/AgentShell/blob/main/bin/agent-desktop)
- [Installer](https://github.com/lachlanchen/AgentShell/blob/main/install.sh)
- [Launcher tests](https://github.com/lachlanchen/AgentShell/blob/main/tests/test_desktop.py)
- [Full setup, state layout, and troubleshooting](https://github.com/lachlanchen/AgentShell/blob/main/docs/desktop-linux.md)
- [Existing CLI account guide](multiple-account-terminals-with-agentshell.md)

```bash
agent-desktop company --status
agent-desktop personal --status
agent-desktop lab --status
```

Launch diagnostics are private at `~/.local/share/agentshell/profiles/ACCOUNT/codex-desktop-launch.log`. Do not publish those logs, authentication files, desktop profiles, or screenshots containing private session history. Do not delete live profile locks as a routine fix.

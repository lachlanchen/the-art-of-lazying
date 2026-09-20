# Codex: selectable input and optional image paths

Checked on Linux with Codex CLI **0.155.1**, GNOME Terminal 3.52.0, and
VTE 0.76.0, on 2026-09-20. These are two separate input behaviors.

## Disable the stars that interfere with selecting a draft

Merge these keys into the existing `[tui]` section in the effective
`$CODEX_HOME/config.toml` (normally `~/.codex/config.toml`):

```toml
[tui]
whimsy = false
animations = false
```

Do not create a duplicate `[tui]` table. `whimsy` controls decorative effects
such as Astra's composer stars. `animations` also disables animated spinners
and shimmer, which can disturb terminal selection during redraws. Neither
setting changes the model, permissions, keyboard mappings, or paste semantics.
`disable_paste_burst` is unrelated and was left unchanged.

The settings take effect when Codex starts. Keep current work running; at the
next convenient point, save any unsubmitted draft, exit **Codex only**, and
resume with `codexr` or `codex resume`. No terminal logout, `.bashrc` reload,
desktop restart, or machine reboot is necessary.

AgentShell accounts have separate configuration files. Apply the same two
keys to existing `profiles/*/codex-home/config.toml` and
`profiles/*/codex-shared-home/config.toml` under
`~/.local/share/agentshell/`. History views may symlink to the shared-home
configuration; update the target once. New accounts inherit the base config
when AgentShell first creates them. Account credentials and session databases
must remain untouched.

The native 0.155.1 app-server `config/read` endpoint confirmed both settings
were false in the ordinary home and the company shared home. All changed TOML
files were checked to differ semantically in only these two keys. The user
still needs to confirm mouse selection after restarting their existing TUI.

Sources and upstream feedback:

- [Versioned schema: `Tui.whimsy` and `Tui.animations`](https://github.com/openai/codex/blob/rust-v0.155.1/codex-rs/core/config.schema.json)
- [Official configuration reference](https://learn.chatgpt.com/docs/config-file/config-reference)
- [Composer-star issue, with this Linux report](https://github.com/openai/codex/issues/44398#issuecomment-5747257339)
- [Related GNOME/VTE animation-selection report](https://github.com/openai/codex/issues/38017)

## Copy a path without forcing an image attachment

Codex 0.155.1 may turn a pasted existing image filename into `[Image #N]`.
A plain bitmap clipboard may also be saved to a temporary PNG and attached.
There is no corresponding user-facing path-only preference in the inspected
0.155.1 configuration schema. Do not invent an `image_paste_mode` setting.

The local helper provides an explicit **text path** option without patching
the binary or replacing the normal image attachment behavior:

```bash
# Read a copied image file, filename, or screenshot from the clipboard.
codex-image-path

# Or specify the file directly; quotation is important for spaces.
codex-image-path '/absolute/path/to/My image.png'

# Print a reference without changing the clipboard.
codex-image-path --print '/absolute/path/to/My image.png'
```

Then use the terminal's text paste, normally **Ctrl+Shift+V**, in Codex.
The text will look like:

```text
Image file path: "/absolute/path/to/My image.png"
```

That label is intentional. In 0.155.1, automatic image attachment tests whether
the **whole paste** is a single image path. A complete labeled reference stays
normal text, while copying just the bare filename may trigger attachment again.
The helper never submits the prompt, injects keystrokes, or uploads the image.
Codex can still open the file later when the task calls for it.

For the installed Files/Nautilus integration, right-click selected files and
choose **Scripts → Copy path for Codex**, then paste into Codex. Multiple files
produce one labeled path per line. Other file managers can use the CLI.

### Which path is used?

- A local file URI or filename preserves the actual original file path.
- Spaces and Unicode filenames are supported; no shell evaluation is used.
- If the clipboard has pixels only, the original filename cannot be inferred.
  The helper saves an exact PNG under `~/.cache/codex-image-path/` (or
  `$XDG_CACHE_HOME/codex-image-path/`) and gives that real saved path instead.
- Bitmap files are private (`0600`), with a private cache directory (`0700`).
  Identical PNG bytes reuse the same SHA-256-named file. No automatic deletion
  runs; removing this cache later breaks prompts referencing those files.
- Remote-host `file://` URIs are rejected. A path on a phone/Mac/Windows client
  is not necessarily a readable local Ubuntu path. If remote clipboard
  transfer supplies only pixels, the saved Ubuntu PNG is the usable reference.
- This helper uses `xclip` on X11/XWayland. It does not claim native Wayland
  clipboard support, nor does it change the remote-desktop clipboard bridge.

### Install on another Linux workstation

From this repository root (requires Python 3 and `xclip`):

```bash
mkdir -p "$HOME/.local/bin" "$HOME/.local/share/nautilus/scripts"
install -m 755 lazy-hacks/codex-cli/scripts/codex-image-path.py \
  "$HOME/.local/bin/codex-image-path"
cat > "$HOME/.local/share/nautilus/scripts/Copy path for Codex" <<'SH'
#!/bin/sh
exec "$HOME/.local/bin/codex-image-path"
SH
chmod 755 "$HOME/.local/share/nautilus/scripts/Copy path for Codex"
```

Ensure `~/.local/bin` is on the shell's `PATH`, or run the absolute path.
Removing these two helper files reverses the integration. Ordinary Codex,
`codexr`, and account wrappers remain unchanged.

### Validation and upstream request

An isolated Xvfb clipboard test covered original file URIs, filenames with
spaces/Japanese characters, quoted text paths, bitmap-only PNG preservation,
cache deduplication and permissions, rejection of remote-host file URIs, and
failure without changing the clipboard for a missing file. The temporary test
display was stopped afterward; the user's desktop and clipboard were untouched.

This is a workaround, not a new native Codex paste mode. The requested native
choices are **path only**, **attachment only**, and **attachment plus a visible,
copyable path**. Feedback was added to the existing issue to avoid duplicates:

- [Image-path request and current source evidence](https://github.com/openai/codex/issues/9283#issuecomment-5747257447)
- [Related loss of image paths when recalling prompts](https://github.com/openai/codex/issues/38488)

No upstream code PR was submitted; this change uses supported settings and a
small local helper while requesting a native option from the maintainers.

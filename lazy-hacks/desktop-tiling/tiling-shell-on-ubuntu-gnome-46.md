# Tiling Shell on Ubuntu GNOME 46

## Context

This note records a practical replacement for the old Ubuntu `Compiz Grid` style workflow:

- choose a tiling layout
- move current windows into tiles
- optionally auto-place new windows

Installed on:
- Ubuntu with GNOME Shell `46.0`
- X11 session

## Installed extension

- Name: `Tiling Shell`
- UUID: `tilingshell@ferrarodomenico.com`
- Source:
  - `https://extensions.gnome.org/extension/7065/tiling-shell/`
  - `https://github.com/domferr/tilingshell`

## What was fixed after install

The extension showed its top-bar indicator, but clicking layouts did nothing.

Root cause:
- its saved layout data was empty:
  - `layouts-json = '[]'`
  - `selected-layouts = []`

So the extension was active, but there were no actual layouts to apply.

Fix:
- restore the built-in default layouts
- reload the extension

Also changed:
- disable Ubuntu's built-in tiler to avoid overlap:
  - `tiling-assistant@ubuntu.com`
- make sure user extensions are enabled in the live GNOME session

## How it behaves

### Layout picker

The top-bar indicator lets you select the current layout template.

Important:
- selecting a layout does **not** automatically retile all currently open windows
- it selects the layout that drag/key placement will use

### Current windows

For already-open windows, use:

1. Drag the window into a tile
2. Or use:
   - `Super+Left`
   - `Super+Right`
   - `Super+Up`
   - `Super+Down`
3. Or use the titlebar window menu tile actions

This is the main workflow for terminals already on screen.

### New windows

`Auto tiling` means:
- new windows are automatically placed into the best empty tile in the current layout

It does **not** mean:
- tile all existing windows right now

## Practical usage

### Fastest way to tile terminals

1. Open the Tiling Shell indicator in the top bar.
2. Pick a layout.
3. Drag each terminal into the shown regions.

or:

1. Focus a terminal.
2. Use `Super+Arrow` to move it through the tiles.

### Extra controls

- Hold `Ctrl` while moving a window to activate the tiling system.
- Hold `Alt` while placing a window to span multiple tiles.

## Preferences

Open preferences with:

```bash
gnome-extensions prefs tilingshell@ferrarodomenico.com
```

Useful setting:
- `Enable auto tiling`

When enabled:
- new terminals and other new windows can automatically fill the current layout

## What it is not

Tiling Shell is not mainly a one-click `tile all current windows` tool.

It is better described as:
- layout selection
- assisted placement for current windows
- optional auto-placement for new windows

## Revert

Return to Ubuntu's built-in tiler:

```bash
gnome-extensions disable tilingshell@ferrarodomenico.com
gnome-extensions enable tiling-assistant@ubuntu.com
```

# Fix Reversed Horizontal Mouse in UURemote/GameViewer

## Symptom

Inside a UURemote/GameViewer remote-control window:

- Moving the mouse left sends the pointer right.
- Moving the mouse right sends the pointer left.
- Up and down movement still works normally.

This is usually not a macOS mouse setting. It is most often UURemote/GameViewer's Game Mouse or mouse-mode layer mirroring the X axis for the remote session.

## Fast Fix

Press:

```text
Control + Option + Return
```

This unlocks or exits Game Mouse mode. After that, horizontal movement should return to normal.

## If It Comes Back

Open the UURemote/GameViewer remote toolbar and change:

```text
Mouse -> Mouse Mode
```

Try these modes:

```text
Use controlled-side mouse
Use controller-side mouse
```

Avoid staying in Smart Mouse or Game Mouse mode if horizontal movement flips again.

## Quick Diagnosis

If the reversal only happens inside the remote-control window, fix UURemote/GameViewer mouse mode.

If the reversal happens everywhere on the local desktop, check local HID drivers, mouse utilities, or physical mouse settings instead.

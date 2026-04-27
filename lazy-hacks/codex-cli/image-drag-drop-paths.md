# Codex Image Drag-and-Drop Paths

This note records the current useful behavior when dragging an image into Codex.

## Current Behavior

Dragging an image into Codex can include both:

- the attached image content
- the local source path or content path metadata

That matters because image content alone is not enough when the next task needs to edit, move, copy, document, or reference the original local file.

## Practical Use

When the dropped image includes a visible path, use that path directly in the request:

```text
Use this image at /home/lachlan/path/to/image.png and ...
```

If Codex only receives the image content and not the path, the assistant can still inspect the image, but it cannot reliably know where the original file lives.

## Why This Helps

Path metadata avoids an annoying manual step:

- no need to separately run `pwd` and paste the filename
- no need to ask the assistant to infer a local path from image content
- file edits and documentation can point to the real original file

## Note

This is Codex client/input behavior, not part of the shell wrappers for `codex`, `codexr`, or `codexmv`.

The shell wrappers still handle:

- default sandbox/approval flags
- resume picker behavior
- cwd migration through `codexmv`


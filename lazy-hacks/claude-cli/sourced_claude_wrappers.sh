#!/usr/bin/env bash
# Shell functions use the same dispatcher as the ~/bin command shims
# (claude, clauder, claudemv). Every launch runs with full access and no
# permission prompts, like the codex/codexr/codexmv wrappers.

: "${CLAUDE_RESUME_PICKER_ENABLE:=1}"
: "${CLAUDE_RESUME_PICKER_LIMIT:=500}"
export CLAUDE_RESUME_PICKER_ENABLE CLAUDE_RESUME_PICKER_LIMIT

claude() {
  "$HOME/scripts/claude_wrapper.sh" claude "$@"
}

clauder() {
  "$HOME/scripts/claude_wrapper.sh" clauder "$@"
}

claudemv() {
  "$HOME/scripts/claude_wrapper.sh" claudemv "$@"
}

alias clr='clauder'

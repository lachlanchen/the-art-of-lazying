# Publisher Voice

[Publisher Voice](skills/publisher-voice/SKILL.md) is a reusable writing skill for articles, documentation, product pages, store listings, papers, release notes, and social posts.

It separates facts for the reader from private instructions and working discussion. It preserves technical depth and relevant limitations while removing generic promotion, invented personal experience, and internal naming debates that do not belong in the publication.

Install the skill into the shared Codex skills directory from this repository:

```bash
mkdir -p "$HOME/.codex/skills/publisher-voice/agents"
cp lazy-hacks/writing/skills/publisher-voice/SKILL.md \
  "$HOME/.codex/skills/publisher-voice/SKILL.md"
cp lazy-hacks/writing/skills/publisher-voice/agents/openai.yaml \
  "$HOME/.codex/skills/publisher-voice/agents/openai.yaml"
```

Compare any existing local version before replacing it. Use it directly with:

```text
Use $publisher-voice to turn these verified notes into a detailed tutorial.
Write for a reader who has not seen the conversation. Keep the commands,
evidence, and material limitations; leave the drafting discussion out.
```

For automatic use, a workspace `AGENTS.md` can ask agents to read the installed skill whenever they write reader-facing material. The skill complements technical, publishing, and manuscript-review workflows; it does not authorize publication by itself.

The [Samsung 990 PRO recovery tutorial](../storage/samsung-990-pro-ubuntu-firmware-recovery.md) applies this voice to a documented storage incident. It separates successful firmware activation from filesystem repair and limits its conclusions to the recorded checks.

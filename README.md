# blind3y3esign skills

Portable agent skills, adapted from [pstack](https://github.com/cursor/plugins/tree/main/pstack) so they run in any harness that reads the [Agent Skills](https://agentskills.io/specification) format, not only Cursor.

| Skill | What it does |
| --- | --- |
| [`arena`](skills/arena/SKILL.md) | Runs N independent attempts at a task on models you pick, judges them against a rubric, and merges the best into one result. |
| [`principle-prove-it-works`](skills/principle-prove-it-works/SKILL.md) | Before the agent declares work done, makes it verify against the real artifact rather than a proxy. |

## What changed from pstack

- **Spec-only frontmatter.** `disable-model-invocation` was dropped; it is a Claude Code extension, and claude.ai packaging rejects it. Instead, arena's description is worded so that it fires only on an explicit request.
- **Models are your choice.** pstack read hardcoded Cursor slugs from `~/.cursor/rules/pstack-models.mdc`. Arena now finds the models your harness actually offers, asks which ones to use, and can save your answer as two lines in `AGENTS.md` / `CLAUDE.md`:
  ```
  arena runners: <model>, <model>
  arena cross-judge pool: <model>, <model>
  ```
- **Degrades without subagents.** If the harness can't spawn subagents, arena runs in sequential mode: one candidate at a time, no cross-judge, and a note recording both limits.
- **Single file per skill.** Each skill is one `SKILL.md` with no `references/` or `scripts/`, because Figma's skill upload accepts only one Markdown file. pstack principles the skills referenced (separate-before-serializing, redesign-from-first-principles, laziness protocol) are written into the text in a sentence each.
- **No filesystem assumed.** Arena's output locations fall back from a git worktree, to a directory, to a page or frame. prove-it-works covers rendered designs and tools without a shell.

## Install

Copy a skill's folder into your harness's skills directory, keeping the folder name. The spec requires the folder name to match `name`.

- **Claude Code**: `~/.claude/skills/<name>/` (all projects) or `.claude/skills/<name>/` (one project).
- **Other Agent Skills harnesses** (Codex, Cursor, Gemini CLI, Copilot, and others): use the skills directory from that harness's docs.
- **Figma agent / Figma Make**: Skills > Add skill, then upload the `SKILL.md`. Invoke it with `/arena`. Only the first skill named in a prompt runs, which is why arena carries the core of prove-it-works inline.

## Figma status

Figma documents no subagents and no per-agent model choice, so arena runs there in sequential mode. Figma Make lets you switch the conversation's model, but switching blocks skill invocation on the next prompt. Pick the model before you invoke `/arena`.

## License

Both skills are adapted from pstack, © 2026 Lauren Tan, MIT. See [LICENSES/pstack-MIT.txt](LICENSES/pstack-MIT.txt).

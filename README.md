# blind3y3design skills

The agent skills I use when I work with agents on design and development. Some are adapted from other people's collections, and some are direct copies of skills by their original creators. All of them use the [Agent Skills](https://agentskills.io/specification) format, so they run in any agent tool that reads it, not only the one each was first written for.

| Skill | What it does | Source |
| --- | --- | --- |
| [`arena`](skills/arena/SKILL.md) | Runs N independent attempts at a task on models you pick, judges them against a rubric, and merges the best into one result. | Adapted from [pstack](https://github.com/cursor/plugins/tree/main/pstack) |
| [`principle-prove-it-works`](skills/principle-prove-it-works/SKILL.md) | Before the agent declares work done, makes it verify against the real artifact rather than a proxy. | Adapted from [pstack](https://github.com/cursor/plugins/tree/main/pstack) |
| [`domain-modeling`](skills/domain-modeling/SKILL.md) | Builds and sharpens a project's domain model as you design. It challenges fuzzy terms, records them in `GLOSSARY.md`, and writes ADRs for hard-to-reverse decisions. | Direct copy from [Matt Pocock](https://github.com/mattpocock/skills/tree/main/skills/engineering/domain-modeling) |
| [`frontend-design`](skills/frontend-design/SKILL.md) | Gives new or reworked UI a deliberate visual direction, with guidance on typography, layout, motion, and interface copy, so it doesn't read as a templated default. | Direct copy from [Anthropic](https://github.com/anthropics/skills/tree/main/skills/frontend-design) |
| [`unslop`](skills/unslop/SKILL.md) | Edits text to remove common AI writing patterns, such as filler phrases, inflated vocabulary, em dashes, and vague attributions, while keeping the meaning and tone. Runs only when you invoke it. | Direct copy from [pstack](https://github.com/cursor/plugins/tree/main/pstack/skills/unslop) |

## How they fit together

- Before building, `domain-modeling` settles what things are called and records why the big decisions went the way they did.
- While building UI, `frontend-design` sets the visual direction and reviews the design plan before any code is written.
- When the right approach is unclear, `arena` runs several attempts in parallel and keeps the best.
- Before calling work done, `principle-prove-it-works` checks the real output, not a stand-in.
- Before anyone reads the result, `unslop` edits docs, PR descriptions, and UI copy to remove AI writing patterns.

## Changes from pstack

These notes apply to `arena`:

- **Models are your choice.** pstack read hardcoded Cursor slugs from `~/.cursor/rules/pstack-models.mdc`. Arena now finds the models your agent tool offers, asks which ones to use, and can save your answer as two lines in `AGENTS.md` or `CLAUDE.md`:
  ```
  arena runners: <model>, <model>
  arena cross-judge pool: <model>, <model>
  ```
- **Degrades without subagents.** If the agent tool can't spawn subagents, arena runs in sequential mode: one candidate at a time, no cross-judge, and a note recording both limits.
- **No filesystem assumed.** Arena's output locations fall back from a git worktree, to a directory, to a page or frame. prove-it-works covers rendered designs and tools without a shell.

## Direct copies

`domain-modeling`, `frontend-design`, and `unslop` are not mine. They are direct, unmodified copies of other people's skills. Matt Pocock wrote `domain-modeling` in [mattpocock/skills](https://github.com/mattpocock/skills), Anthropic wrote `frontend-design` in [anthropics/skills](https://github.com/anthropics/skills), and Lauren Tan wrote `unslop` in [pstack](https://github.com/cursor/plugins/tree/main/pstack). Credit and authorship belong to them, and any changes to these skills belong upstream, not here.

I keep them as files in this repo only so that `npx skills add Blind3y3Design/blind3y3design-skills` can install them alongside my own skills. That command installs only skills whose files are in the repo you point it at; it won't follow references to other repos.

[`upstream.json`](upstream.json) records where each copy comes from and the upstream commit it was last copied at. Don't edit the copied folders by hand; the next sync overwrites them.

`domain-modeling` has more than one file. `SKILL.md` links to `GLOSSARY-FORMAT.md` and `ADR-FORMAT.md`, and `agents/openai.yaml` supplies the display name for Codex. Keep the whole folder together when you install it.

### Keeping the copies current

A [scheduled GitHub Action](.github/workflows/sync-upstream-skills.yml) runs on the 1st of each month at 14:00 UTC. It runs [`scripts/sync-upstream.sh`](scripts/sync-upstream.sh), which re-copies each folder listed in `upstream.json` from its creator's repo. If anything changed, it opens a pull request named "Sync upstream skills" with a link to each upstream diff. If nothing changed, it does nothing. For the action to open pull requests, **Settings > Actions > General > Workflow permissions > Allow GitHub Actions to create and approve pull requests** must be on.

Review the upstream diff before merging. Skills run with full agent permissions, and once merged, `npx skills update` delivers the change to every repo that installed them.

To run a sync now, use **Actions > Sync upstream skills > Run workflow** on GitHub, or run `bash scripts/sync-upstream.sh` locally (it needs `git`, `jq`, and `rsync`).

To add another direct copy, add an entry to `upstream.json` with the skill's `name` (the folder name here), the upstream `repo`, `ref`, and `path` to the skill folder, an optional `license` to copy, and a `syncedFrom` commit, then run the script.

## Install

From the root of the repo you want the skills in, run the [`skills` CLI](https://github.com/vercel-labs/skills):

```bash
npx skills add Blind3y3Design/blind3y3design-skills
```

It lists the skills in this repo, asks which ones you want, and detects which agents you use (Claude Code, Codex, Cursor, Gemini CLI, Copilot, and others), then installs into each agent's project skills directory, such as `.claude/skills/` or `.agents/skills/`. Commit those directories to share the skills with your team.

### Figma

The CLI doesn't install into Figma. In the Figma agent or Figma Make, go to Skills > Add skill, then upload the `SKILL.md`. Invoke a skill with `/<name>`, for example `/arena`. Only the first skill named in a prompt runs, which is why arena carries the core of prove-it-works inline. Figma accepts only one Markdown file per skill, so `domain-modeling` loses its glossary and ADR format files there; the agent still follows `SKILL.md` but won't have the templates.

## Adding a skill

Put each skill at `skills/<name>/SKILL.md`, with `name` in the frontmatter matching the folder name. The CLI finds skills in that layout, so nothing else needs registering. Run `npx skills add . --list` from this repo to confirm a new skill is picked up.

## Figma status

Figma documents no subagents and no per-agent model choice, so arena runs there in sequential mode. Figma Make lets you switch the conversation's model, but switching blocks skill invocation on the next prompt. Pick the model before you invoke `/arena`.

## License

- `arena` and `principle-prove-it-works` are adapted from pstack, © 2026 Lauren Tan, MIT. See [LICENSES/pstack-MIT.txt](LICENSES/pstack-MIT.txt).
- `domain-modeling` is from mattpocock/skills, © 2026 Matt Pocock, MIT. See [LICENSES/mattpocock-skills-MIT.txt](LICENSES/mattpocock-skills-MIT.txt).
- `unslop` is from pstack, © 2026 Lauren Tan, MIT. See [LICENSES/pstack-MIT.txt](LICENSES/pstack-MIT.txt).
- `frontend-design` is from anthropics/skills, Apache 2.0. See [skills/frontend-design/LICENSE.txt](skills/frontend-design/LICENSE.txt).

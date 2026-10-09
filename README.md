# blind3y3design skills

The agent skills I use when I work with agents on design and development. Some are adapted from other people's collections, and some are direct copies of skills by their original creators. All of them use the [Agent Skills](https://agentskills.io/specification) format, so they run in any harness that reads it, not only the one each was first written for.

| Skill | What it does | Source |
| --- | --- | --- |
| [`arena`](skills/arena/SKILL.md) | Runs N independent attempts at a task on models you pick, judges them against a rubric, and merges the best into one result. | Adapted from [pstack](https://github.com/cursor/plugins/tree/main/pstack) |
| [`principle-prove-it-works`](skills/principle-prove-it-works/SKILL.md) | Before the agent declares work done, makes it verify against the real artifact rather than a proxy. | Adapted from [pstack](https://github.com/cursor/plugins/tree/main/pstack) |
| [`domain-modeling`](skills/domain-modeling/SKILL.md) | Builds and sharpens a project's domain model while you design: challenges fuzzy terms, records them in `GLOSSARY.md`, and writes ADRs for hard-to-reverse decisions. | Direct copy from [Matt Pocock](https://github.com/mattpocock/skills/tree/main/skills/engineering/domain-modeling) |
| [`frontend-design`](skills/frontend-design/SKILL.md) | Steers new or reworked UI toward a deliberate visual direction, with guidance on typography, layout, motion, and interface copy, so it doesn't read as a templated default. | Direct copy from [Anthropic](https://github.com/anthropics/skills/tree/main/skills/frontend-design) |

## How they fit together

- **Before building**: `domain-modeling` settles what things are called and records why the big decisions went the way they did.
- **While building UI**: `frontend-design` sets the visual direction and reviews the design plan before any code is written.
- **When the right approach is unclear**: `arena` runs several attempts in parallel and keeps the best.
- **Before calling it done**: `principle-prove-it-works` checks the real output, not a stand-in.

## Changes from pstack

These notes apply to `arena` and `principle-prove-it-works` only.

- **Spec-only frontmatter.** `disable-model-invocation` was dropped; it is a Claude Code extension, and claude.ai packaging rejects it. Instead, arena's description is worded so that it fires only on an explicit request.
- **Models are your choice.** pstack read hardcoded Cursor slugs from `~/.cursor/rules/pstack-models.mdc`. Arena now finds the models your harness actually offers, asks which ones to use, and can save your answer as two lines in `AGENTS.md` / `CLAUDE.md`:
  ```
  arena runners: <model>, <model>
  arena cross-judge pool: <model>, <model>
  ```
- **Degrades without subagents.** If the harness can't spawn subagents, arena runs in sequential mode: one candidate at a time, no cross-judge, and a note recording both limits.
- **Single file per skill.** Each skill is one `SKILL.md` with no `references/` or `scripts/`, because Figma's skill upload accepts only one Markdown file. pstack principles the skills referenced (separate-before-serializing, redesign-from-first-principles, laziness protocol) are written into the text in a sentence each.
- **No filesystem assumed.** Arena's output locations fall back from a git worktree, to a directory, to a page or frame. prove-it-works covers rendered designs and tools without a shell.

## Direct copies

`domain-modeling` and `frontend-design` are not mine. They are direct, unmodified copies of skills written by their creators: `domain-modeling` by Matt Pocock in [mattpocock/skills](https://github.com/mattpocock/skills), and `frontend-design` by Anthropic in [anthropics/skills](https://github.com/anthropics/skills). Credit and authorship belong to them, and any changes to these skills belong upstream, not here.

They are stored as files in this repo only so that `npx skills add Blind3y3Design/blind3y3design-skills` can install them alongside my own skills. That command installs only skills whose files are in the repo you point it at; it won't follow references to other repos.

[`upstream.json`](upstream.json) records where each copy comes from and the upstream commit it was last copied at. Don't edit the copied folders by hand; the next sync overwrites them.

`domain-modeling` is more than one file: `SKILL.md` links to `GLOSSARY-FORMAT.md` and `ADR-FORMAT.md`, and `agents/openai.yaml` supplies the display name for Codex. Keep the whole folder together when you install it.

### Keeping the copies current

A [scheduled GitHub Action](.github/workflows/sync-upstream-skills.yml) runs every Monday at 14:00 UTC. It runs [`scripts/sync-upstream.sh`](scripts/sync-upstream.sh), which re-copies each folder listed in `upstream.json` from its creator's repo. If anything changed, it opens a pull request named "Sync upstream skills" with a link to each upstream diff. If nothing changed, it does nothing. For the action to open pull requests, **Settings > Actions > General > Workflow permissions > Allow GitHub Actions to create and approve pull requests** must be on.

Review the upstream diff before merging. Skills run with full agent permissions, and once merged, `npx skills update` delivers the change to every repo that installed them.

To run a sync now, use **Actions > Sync upstream skills > Run workflow** on GitHub, or run `bash scripts/sync-upstream.sh` locally (it needs `git`, `jq`, and `rsync`).

To add another direct copy, add an entry to `upstream.json` with the skill's `name` (the folder name here), the upstream `repo`, `ref`, and `path` to the skill folder, an optional `license` to copy, and a `syncedFrom` commit, then run the script.

## Install

From the root of the repo you want the skills in, run the [`skills` CLI](https://github.com/vercel-labs/skills):

```bash
npx skills add Blind3y3Design/blind3y3design-skills
```

It lists the skills in this repo, asks which ones you want, and detects which agents you use (Claude Code, Codex, Cursor, Gemini CLI, Copilot, and others), then installs into each agent's project skills directory, such as `.claude/skills/` or `.agents/skills/`. Commit those directories to share the skills with your team.

Useful variations:

```bash
npx skills add Blind3y3Design/blind3y3design-skills --list
```

```bash
npx skills add Blind3y3Design/blind3y3design-skills --skill domain-modeling --skill frontend-design
```

```bash
npx skills add Blind3y3Design/blind3y3design-skills --skill '*' -a claude-code -y
```

```bash
npx skills add Blind3y3Design/blind3y3design-skills -g
```

These list the skills without installing; install only the named skills; install every skill for Claude Code without prompts; and install for your user account across all projects instead of one repo.

The CLI symlinks by default; pass `--copy` to write real files instead. It copies each skill's whole folder, so `domain-modeling` arrives with its glossary and ADR format files.

### Manual install

Copy a skill's folder into your harness's skills directory, keeping the folder name. The spec requires the folder name to match `name`.

- **Claude Code**: `~/.claude/skills/<name>/` (all projects) or `.claude/skills/<name>/` (one project).
- **Other Agent Skills harnesses** (Codex, Cursor, Gemini CLI, Copilot, and others): use the skills directory from that harness's docs.

### Figma

The CLI doesn't install into Figma. In the Figma agent or Figma Make, go to Skills > Add skill, then upload the `SKILL.md`. Invoke a skill with `/<name>`, for example `/arena`. Only the first skill named in a prompt runs, which is why arena carries the core of prove-it-works inline. Figma accepts only one Markdown file per skill, so `domain-modeling` loses its glossary and ADR format files there; the agent still follows `SKILL.md` but won't have the templates.

## Adding a skill

Put each skill at `skills/<name>/SKILL.md`, with `name` in the frontmatter matching the folder name. The CLI finds skills in that layout, so nothing else needs registering. Run `npx skills add . --list` from this repo to confirm a new skill is picked up.

## Figma status

Figma documents no subagents and no per-agent model choice, so arena runs there in sequential mode. Figma Make lets you switch the conversation's model, but switching blocks skill invocation on the next prompt. Pick the model before you invoke `/arena`.

## License

- `arena` and `principle-prove-it-works` are adapted from pstack, © 2026 Lauren Tan, MIT. See [LICENSES/pstack-MIT.txt](LICENSES/pstack-MIT.txt).
- `domain-modeling` is from mattpocock/skills, © 2026 Matt Pocock, MIT. See [LICENSES/mattpocock-skills-MIT.txt](LICENSES/mattpocock-skills-MIT.txt).
- `frontend-design` is from anthropics/skills, Apache 2.0. See [skills/frontend-design/LICENSE.txt](skills/frontend-design/LICENSE.txt).

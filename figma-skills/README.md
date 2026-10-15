# Figma Skills

Single-file Figma editions of the canonical skills in [skills/](../skills/). Each edition mirrors its source skill's directory name and keeps the same skill `name`, so the relationship is explicit:

```text
skills/<name>/SKILL.md        -> figma-skills/<name>/SKILL.md
skills/<name>/references/    -> relevant content inlined in that one file
```

## Available Editions

| Figma edition | Canonical source | Bundled references |
|---|---|---|
| [adversarial-design-review](adversarial-design-review/SKILL.md) | [skills/adversarial-design-review/SKILL.md](../skills/adversarial-design-review/SKILL.md) | [Product checks](../skills/adversarial-design-review/references/product-checks.md), [technical checks](../skills/adversarial-design-review/references/technical-checks.md), and [optional scoring](../skills/adversarial-design-review/references/scoring.md) |

Only adversarial-design-review has a Figma edition at present. The other canonical skills are unchanged.

## Installation

1. Download the raw `SKILL.md` for the edition you want from the table above.
2. Import that single Markdown file using the skill-upload flow in your Figma environment, following its filename and metadata requirements.
3. Provide accessible frames, components, prototype flows, or descriptions along with the goal and acceptance criteria.

Each edition's directory contains only its self-contained `SKILL.md`. This catalog, the canonical source, references, and examples are maintenance documentation, not required uploads. External evidence links are optional sources, not companion-file dependencies.

Install one edition of a given skill in each environment, not both the canonical and Figma versions. Import behavior still needs verification in your particular Figma environment.

## Maintaining the Source Relationship

- Treat `skills/<name>/` as the maintenance source; this directory contains adaptations, not independent forks.
- Keep the mirrored directory name and frontmatter `name` aligned with the canonical skill. Retain the provenance statement in each Figma file so it remains traceable when downloaded alone.
- When the canonical workflow or references change, update the corresponding inline content in the Figma edition in the same change. Preserve Figma-specific artifact-access guidance and the single-file constraint.
- For adversarial-design-review, keep the Decision rules, criterion statuses, severity and confidence definitions, finding schema, and all three reference tables aligned. Adapt references to use inline sections rather than companion files.
- Check YAML frontmatter, absence of companion-file dependencies, and parity with the source. Use the canonical [acceptance fixtures](../skills/adversarial-design-review/examples/review-request.md) for behavioral evaluation in the intended host; structural checks alone do not establish runtime reliability.
- Add future editions to the table with links to their canonical source and any inlined references. Do not put supporting files in an edition's directory.

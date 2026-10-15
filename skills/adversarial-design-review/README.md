# Adversarial Design Review Skill

A reusable agent skill for reviewing one or more designs against goals, acceptance criteria, and evidence. Use it to compare Figma concepts, stress-test flows, identify missing states, and recommend a direction without confusing a polished screen with a validated outcome.

**For Figma, use the [single-file Figma edition](../../figma-skills/adversarial-design-review/SKILL.md).** It contains the workflow, product checks, technical checks, and optional scoring in one file. No companion files are needed for the skill's instructions.

## What the Skill Produces

- A scoped recommendation with confidence and explicit conditions.
- Criterion outcomes separating confirmed failures from missing evidence.
- Severity-ranked findings tied to frames, components, states, or supplied specifications.
- Relevant usability, accessibility, failure, security, and operational checks.
- Prioritized repairs and validation actions that preserve demonstrated strengths.

Mandatory criteria control the decision. An unmet gate prevents advancement; an undemonstrated gate requires testing before approval. Scores cannot override either outcome.

## Choose an Edition

| Edition | Use when | Files needed |
|---|---|---|
| [Figma edition](../../figma-skills/adversarial-design-review/SKILL.md) | Your environment accepts only a single skill file | This file only |
| [SKILL.md](SKILL.md) | Your agent supports skills with conditionally loaded companion references | The entry file and the complete references directory |

Both editions use the same review contract. Use one edition per installation, not two definitions of the same skill. The Figma file is a bundled adaptation; this modular skill and its references remain the maintenance source.

## Figma Setup

1. Download the raw Markdown for the [Figma edition](../../figma-skills/adversarial-design-review/SKILL.md).
2. Import that single file through the skill-upload flow available in your Figma environment. Follow that environment's filename and metadata requirements; this repository does not assume a particular UI or product version.
3. Make the relevant frames, components, prototype flows, or descriptions accessible to the agent. Supply the goal, acceptance criteria, and decision stage.
4. Request a review using the example below. Check that findings cite artifacts the agent could actually inspect.

The review is read-only unless you explicitly request design changes. An inaccessible Figma link does not count as inspected evidence; the agent should request accessible artifacts rather than invent their contents.

## Example Request

```text
Run a comparative adversarial design review of the accessible frames
"Part Search / Concept A" and "Part Search / Concept B".

Goal: help a customer identify the correct replacement part confidently.
Decision: choose a direction for an interactive prototype, not production.

Acceptance criteria:
C1, gate: the selected machine is visible on every in-scope screen.
C2, gate: labels distinguish verified fit from possible compatibility.
C3, high: changing the machine preserves the search query.
C4, gate: keyboard order and focus restoration are documented.

Scope: search, results, and part details. Checkout is out of scope.
Evidence: the accessible frames and their annotations only; no user research
or implementation test results are supplied.

Inspect each concept independently, then compare. Cite frame names and
states, with node IDs or links when available. Separate confirmed failures
from Not demonstrated behavior. Return a concise recommendation,
criterion matrix, ranked findings, and prioritized repair/validation actions.
Propose a synthesis only if it improves the criteria coherently.
```

Replace the example frame names with your actual artifacts. More prompts and expected behaviors are in [examples/review-request.md](examples/review-request.md). Those fixtures work with either edition; expected results are not claims of completed agent testing.

## Review Modes

| Mode | Purpose |
|---|---|
| `criteria` | Assess supplied acceptance criteria |
| `comparative` | Inspect alternatives independently, then compare |
| `red-team` | Stress failure, abuse, boundary, and recovery scenarios |
| `expansion` | Assess the baseline before exploring adjacent scope |
| `synthesis` | Assess components before proposing a coherent combination |
| `full` | Apply criteria plus relevant product and technical dimensions; the default |

## Recommended Inputs

1. Goal or intended outcome
2. Design artifacts
3. Acceptance criteria or requirements
4. Users and priority scenarios
5. Research, analytics, or feedback
6. Constraints and stage of fidelity
7. Desired review mode: criteria, comparative, red-team, expansion, synthesis, or full

## Other Agent Environments

Install this folder in the skills directory supported by your agent environment, for example `.github/skills/adversarial-design-review/` in VS Code. Keep [SKILL.md](SKILL.md) at the root and include the entire references directory; its relative links are part of the workflow. Verify discovery in the target environment.

## Contents and Source Relationship

| File | Purpose |
|---|---|
| [SKILL.md](SKILL.md) | Canonical modular workflow and evidence contract |
| [references/product-checks.md](references/product-checks.md) | Product, interaction, and accessibility checks |
| [references/technical-checks.md](references/technical-checks.md) | Architecture, security, concurrency, and operations checks |
| [references/scoring.md](references/scoring.md) | Optional numerical scoring |
| [examples/review-request.md](examples/review-request.md) | Requests and seven behavioral acceptance fixtures |
| [Figma edition](../../figma-skills/adversarial-design-review/SKILL.md) | Self-contained adaptation maintained alongside this source |

The Figma edition was migrated from the supplied `SKILL-FIGMA.md` into the mirrored `figma-skills/adversarial-design-review/SKILL.md` location. See the [Figma catalog and maintenance rules](../../figma-skills/README.md) for the source-to-edition convention.

## Evidence and Limitations

Expert review is not user validation. Static frames cannot establish runtime keyboard behavior, screen-reader behavior, backend correctness, or WCAG conformance. An inspected prototype demonstrates only the interactions actually inspected, not production behavior.

External standards are optional evidence sources, not companion-file dependencies. If an external source cannot be verified, the review must disclose that limitation and use available evidence. Technical dimensions apply only when relevant to the supplied design and scope.

The Figma packaging targets the supplied single-file constraint. Successful import and runtime behavior still need verification in your particular Figma environment.

## Design Decisions

These choices preserve the evidence-first review contract while supporting modular and single-file hosts.

| Decision | Reason and tradeoff |
|---|---|
| Keep the canonical filename and evidence-first base | Existing installation and product examples depend on it. Retaining its safeguards is safer than replacing it with a shorter but weaker contract. |
| Shorten discovery to distinct trigger branches | Assessment, comparison, stress testing, expansion, and synthesis are different tasks. Repeated review synonyms and output summaries add little routing value. |
| Use seven ordered steps with explicit Done conditions | Each step has an observable stopping rule without forcing exhaustive narration. |
| Permit clean coverage outcomes | No issue found records inspected evidence and residual uncertainty without requiring an invented defect. |
| Co-locate statuses, severity, confidence, citations, and the finding schema | One evidence contract is easier to maintain; severity remains separate from confidence. |
| Define gate-to-disposition rules | Partial or failed mandatory criteria block advancement; undemonstrated gates require validation. Scores cannot bypass either rule. Combine describes a proposal, not release approval. |
| Ask only for decision-changing missing context | Missing criteria alone does not block review: labeled derived criteria support a provisional judgment. |
| Load product and technical references conditionally | Mixed designs load both; installation must retain the references. |
| Keep scoring outside the default path | Numbers are optional summaries, not evidence or gate overrides. |
| Use compact output with conditional expansions | Comparison, synthesis, detailed matrices, and expansion earn space only when relevant. |
| Preserve evidenced strengths and steelman contested interpretations | Revisions retain what works without a fixed strength quota or invented details. |
| Add prompts with expected results | Fixtures support repeated agent runs but do not prove runtime reliability merely by existing. |
| Inline references in the Figma edition | A single-file host cannot follow repository companion files; bundling is a packaging tradeoff, not a new review contract. |
| Add Figma artifact and access rules | Inaccessible links and static screens cannot prove interaction or backend behavior. A read-only default separates review from implementation. |

These choices apply the [writing-for-agents guidance](https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-for-agents/SKILL.md): explicit completion bounds, conditional disclosure, co-location, concise pointers, and one source of truth. Invocation behavior is environment-specific; see its [skill mechanics](https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-for-agents/SKILL-MECHANICS.md).

## Validation

Structural checks should verify entry metadata, bounded steps, evidence states, and local links. The bundled edition must have no companion-file dependencies, preserve the canonical Decision rules, and contain all product, technical, and scoring tables.

When the maintenance source changes, update the corresponding inline content in the [Figma edition](../../figma-skills/adversarial-design-review/SKILL.md) and rerun those parity checks. Keep Figma-specific artifact guidance intact.

Behavioral adoption requires running the example fixtures with the chosen edition loaded in the intended agent environment, preferably repeatedly. Record invented findings, missing coverage, unsupported dispositions, and unnecessary sections against the expected results. Live user research, implementation tests, and accessibility tests remain separate evidence requirements.

---
name: arena
description: "Arena: run N independent attempts at one task on models the user picks, judge them against a rubric, take the strongest as the base, and graft the best of the rest into it. Use only when the user asks to arena a task ('arena this', 'throw it in the arena', /arena)."
license: MIT
metadata:
  upstream: "https://github.com/cursor/plugins/tree/main/pstack/skills/arena"
---

# Arena

Run N independent attempts at the same task. Read every candidate end to end. Pick the strongest as the base. Graft the best ideas from the others into it. Verify the synthesized result.

Track the six phases as a checklist before launching anything (use your harness's todo tool if it has one): Frame, Fan out, Cross-judge, Pick, Graft, Verify.

## Harness modes

Pick the mode from what your tools can actually do, and name it to the user in one line:

- **Parallel**: you can spawn subagents. Each candidate runs in its own subagent, with its own context.
- **Sequential**: you cannot spawn subagents (Figma's agent and Figma Make today). You write the candidates yourself, one at a time. Finish each candidate fully in its own location before starting the next, and leave earlier candidates untouched. Independence is weaker because candidate 2 is written with candidate 1 in context, so record that in the synthesis note.

## Phase A: Frame

Every candidate gets the same prompt, so the prompt is the **contract**.

1. State the artifact each candidate produces.
2. Derive the **rubric**: state what success looks like for *this* task, then turn it into 3-6 concrete, gradeable criteria. The rubric is the picker's tool in Phase D. Candidates see only the task.
3. Seat the runners (see **Choosing models** below). Each runner fills one **seat**, and the number of seats sets N. Use more seats when the arena covers several design directions. Use the same model in every seat when the work is generation-bound rather than judgment-sensitive.
4. Give each seat its own output location, so no two candidates ever write to the same place. Use, in order of preference: a git worktree; a per-seat directory (`arena-<slug>/candidate-<n>/` under a scratch or temp directory); or, without a filesystem, a separate named container such as a page or frame in a design file, or a separate document.

Done when the artifact, the rubric, every seat's confirmed model, and every seat's output location are written down.

## Choosing models

The user selects the models. Your job is to show them what is actually available and record their choice.

1. **Use a standing choice if one exists.** Check the user's request first, then the always-loaded instructions (`AGENTS.md`, `CLAUDE.md`, rules files), for lines like these:
   ```
   arena runners: <model>, <model>
   arena cross-judge pool: <model>, <model>
   ```
   `inherit-parent` as an entry means the model you are running on. In a runners list, it still counts as a seat.
2. **Otherwise, discover what's available.** Read the model values your subagent tool accepts: its parameter schema or enum, a models list command, or a model picker in the harness. Offer only models you have confirmed. If you cannot detect any, ask the user to name the models they have access to. If the harness does not let you set a model per subagent, every seat runs on `inherit-parent`. Tell the user this and skip the question.
3. **Ask the user** to choose the runners (one or more, repeats allowed) and the cross-judge pool. Use your harness's question tool if it has one; otherwise ask in chat and wait for the answer. Offer a recommended default: runners spread across at least two model families (a family is the provider, such as Claude, GPT, Gemini, or Grok), because different priors are what make the candidates diverge usefully. If the harness sets reasoning effort per subagent, include effort in the choice, defaulting to the highest available level.
4. **Offer once to save** the choice as the two lines above in the project's instructions file, so later runs skip the question. Write the lines only if the user says yes.

If spawning rejects a seat's model, run that seat on the closest available model from the same family, and say so.

## Phase B: Fan out

**Parallel:** launch all N subagents at once, in the background if your harness supports it. Give each one the task, pointers to the shared grounding (the files or references every candidate reads), its own output location, and instructions to produce two things: the artifact, and a short rationale naming the alternatives it considered and what it rejected.

**Sequential:** write each candidate and its rationale in turn, following the same contract.

If a candidate produces no output, carry on with N-1 and record the dropout.

Done when every seat has either delivered an artifact and a rationale or been recorded as a dropout.

## Phase C: Cross-judge

Once every candidate is complete, pick one model from the cross-judge pool. Prefer a model from a different family than yours. Spawn one judge subagent on that model, instructed not to edit anything; use a read-only agent type if the harness has one. The judge gets the rubric and the candidates, labelled only by their location. It scores every criterion for every candidate and recommends a base, with its reasons. It runs while you do your own reading in Phase D.

**Sequential:** there is no independent judge, so record "no cross-judge: harness has no subagents" and grade with extra strictness in Phase D. If the user wants a second opinion, give them the rubric and the candidate locations to run in another model or tool.

## Phase D: Pick a base

Read every candidate end to end before you pick.

Score each candidate against the rubric criterion by criterion, and let the scores drive the pick. Then compare with the cross-judge. If you agree on the base, the pick is confirmed. If you disagree, either one of you is biased or the rubric was ambiguous: read both rationales before deciding.

The **base** is the candidate a future maintainer can extend most easily without breaking its invariants. When two seem tied, choose the one with the cleaner boundary, the smaller surface, and fewer moving parts.

Write a short synthesis note next to the base artifact. Record the pick, why you made it, and the cross-judge's verdict.

## Phase E: Graft

Go through each losing candidate once more and pick out what is worth porting. The signal is usually one or two ideas per candidate, not most of it.

Rework each graft into the base as if the base had been designed with it from day one, carrying it through every reference, name, and example it touches. The result must stay coherent under one mental model. In the synthesis note, record each graft and its source candidate, plus what you rejected and why.

When the candidates converge on the same shape, that is a strong agreement signal: record the convergence and ship the consensus shape without grafting. When they diverge wildly, Phase A was under-specified: reframe and re-run.

## Phase F: Verify

The synthesized artifact faces the same scrutiny as any other output. Apply the **principle-prove-it-works** skill if it is installed. Its core is to check the real artifact directly (run it, render it, read the actual values), not a proxy or a self-report.

If verification turns up a problem the arena missed, trace it to its source. Either Phase A was wrong (reframe and re-run), or a candidate caught the problem and you missed the graft (return to Phase E). Fix the cause where it lives.

## Outputs

One synthesized artifact, with a short synthesis note beside it. The note records the mode, the models per seat, the base, the grafts and their source candidates, the rejections, any dropouts, the cross-judge's verdict, and the verification result.

---

Adapted from [pstack](https://github.com/cursor/plugins/tree/main/pstack) by Lauren Tan (MIT).

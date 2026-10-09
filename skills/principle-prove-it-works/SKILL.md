---
name: principle-prove-it-works
description: "Prove finished work against the real artifact before declaring it done: run it, render it, read the actual value, inspect the diff. Use after completing a task, before reporting success."
license: MIT
metadata:
  upstream: "https://github.com/cursor/plugins/tree/main/pstack/skills/principle-prove-it-works"
---

# Prove It Works

Verify every task output by observing the real thing directly. The bar is direct observation; proxies, self-reports, and "it compiles" fall short of it.

**Why:** Unverified work has unknown correctness. Indirect checks (file timestamps, output freshness, a subagent's summary, a cached screenshot) feel cheaper than looking, and acting on a wrong inference costs far more than checking the source.

Observe the real thing:
- Run the feature, or render the design, and look at what it actually produces.
- Read the live value at its source: the running process, the stored record, the node's actual properties. A cached or derived copy of the value does not count.
- Inspect the actual diff or the actual output file, not a description of it.
- When verification fails, suspect the observation method before suspecting the system.

## Script the check when you can

The strongest proof is a deterministic check that someone can re-run: a script, a test, or a query that repeats the same comparison. Write it, run it, and keep its output as evidence a reviewer can re-run instead of trusting your word. Without a shell or code execution, use the strongest re-runnable observation your tools offer, such as a fresh screenshot of the rendered frame or a property read on the live node.

Put the evidence where the human will see it, in your report. Commit it only for large or complex work whose trail must be auditable later, like a big port or a migration.

## When the real thing is out of reach

If none of your tools can observe the real artifact, report it as unverified. Name exactly what you could not check, and the step that would check it.

---

Adapted from [pstack](https://github.com/cursor/plugins/tree/main/pstack) by Lauren Tan (MIT).

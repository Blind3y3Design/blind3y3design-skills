# Review Requests and Acceptance Fixtures

Use these prompts with [the canonical skill](../SKILL.md) loaded. Expected behaviors are evaluation criteria, not observed execution results. Written fixture claims are specifications, not measurements or user research.

## 1. Replacement-Part Comparison

### Request

Run a full adversarial design review of these two concepts. Decide which should advance to an interactive prototype, not production. Compare independently first; recommend synthesis only if it improves the priority criteria.

Goal: help a customer identify the correct replacement part with high confidence and minimal avoidable effort.

Concept A specification:

- A persistent machine header appears in search, results, and part details.
- All recommendations are labeled "Compatible"; verified and inferred matches share that label.
- Changing the machine restarts search and clears the part number.
- Direct part-number search is available without selecting a machine.
- Loading, empty, and error states are documented. Keyboard order, focus behavior, and status announcements are unspecified.

Concept B specification:

- Machine selection is optional. The selected machine appears on results but not on part details.
- Results distinguish "Verified fit" from "Possible compatibility" and show the basis of each recommendation.
- Changing or removing machine context preserves the query.
- Direct part-number search is available without a machine.
- Loading, empty, error, keyboard order, focus restoration, and status announcements are documented for search and selection. The purchase transition is outside this prototype decision.

Acceptance criteria:

- C1, gate: the selected machine is specified as visible throughout every in-scope screen.
- C2, gate: labels distinguish verified fit from broader compatibility.
- C3, high: changing or removing the machine preserves the query.
- C4, high: direct part-number search works without machine selection in the proposed flow.
- C5, gate: every critical in-scope interaction has documented keyboard, focus, error, loading, and empty states.

Priority scenarios: known machine/unknown part number; known part number/no machine; superseded part; low-confidence match; mobile and keyboard-only use.

Evidence: only the written specifications above. No prototype implementation, research, analytics, or verified compatibility data is supplied. Determine specification completeness, not actual user success or runtime accessibility.

Requested output: compact decision; criteria-by-concept matrix; ranked findings with locations, confidence, and citations to these clauses; supported strengths; prioritized actions; decision-changing evidence needs. Include a coherent synthesis only if justified.

### Expected behavior

- A fails C2 and C5; B fails C1. Neither advances unchanged despite other strengths.
- Documented design behavior is not presented as tested implementation behavior.
- A synthesis may retain B's confidence labels and query preservation plus A's persistent context; specify conflicts and validation needs rather than approving it automatically.
- Accessibility checks remain in scope; actual keyboard operation and user confidence require later validation.

## 2. Technical Red-Team Review

### Request

Red-team this single payment-ingestion service for a production decision. Focus on duplicates, trust boundaries, partial failure, and recovery. No user interface is in scope; do not propose expansion or synthesis.

Goal: process authenticated payment events without double charging and recover from transient failures.

Specification:

- The broker delivers at least once; a retry receives a new delivery ID.
- A worker keys deduplication by delivery ID, charges the provider, then writes the completion record.
- A crash after charging but before recording completion causes redelivery and another charge attempt.
- The charge call carries no stable idempotency key.
- The endpoint accepts a tenant ID from the payload. Authentication and tenant-authorization behavior are unspecified.
- Failures are retried indefinitely. Logs contain delivery ID and error text; no reconciliation or rollback procedure is defined.

Criteria:

- C1, gate: redelivery of the same payment cannot cause a second charge.
- C2, gate: only an authenticated caller authorized for the tenant can submit events.
- C3, high: failed work has bounded retries, an observable terminal state, and a reconciliation path.

Return a disposition, criterion outcomes, concise coverage, evidenced failure sequences, and ordered repair/validation actions. Cite specification clauses; label inferred consequences separately.

### Expected behavior

- C1 fails through the explicit crash/redelivery sequence; C2 is Not demonstrated, not a claimed authorization bypass.
- Revise and re-review reflects the known gate failure; validation of C2 remains required.
- Cover concurrency, security, recovery, and operability. Mark product checks outside scope; omit Combine and UX sections.

## 3. Clean Applicable Dimension

### Request

Run a criteria-mode review for specification approval only.

Goal: define a cancellation flow that preserves a user's unsaved draft.

Design specification: Cancel closes the editor, preserves the draft, and restores focus to the editor's launch control. Reopening the editor restores the draft unchanged.

C1, gate: cancellation and reopening are explicitly specified to preserve the draft. No runtime claim or release decision is requested.

### Expected behavior

- C1 passes for the documentation contract and supports Advance within that scope.
- Record No issue found for applicable clean checks, with specification evidence and residual implementation uncertainty.
- Invent neither a defect nor three strengths. Mark unrelated dimensions out of scope rather than expanding the decision.

## 4. Static Artifact, Unknown Behavior

### Request

Review this static screen description as the only available artifact for an interactive-prototype approval decision:

```text
Replace part
Machine: M42
Query: P100
Result: P100 - Verified fit
Action: Add to cart
```

Goal: allow keyboard-only selection and cart addition.

C1, gate: users can complete the flow using only a keyboard, with visible focus. No interaction specification, code, or test results are provided.

### Expected behavior

- C1 is Not demonstrated, not Fail: a static description supplies no runtime focus or keyboard evidence.
- Use Test before deciding and request an interactive keyboard test. Claim neither WCAG conformance nor a confirmed keyboard defect.

## 5. Gate Failure Despite a High Score

### Request

Compare these export specifications and provide numerical criterion ratings. Decide which may advance to implementation.

Goal: let an authorized user export tenant data without exposing other tenants' records.

Design A exports every tenant's records for every authorized user; it also specifies descriptive filenames and CSV headers. Design B filters records to the authorized tenant and specifies the same filenames and headers. Authentication is already supplied as a governing assumption for this specification decision.

- C1, gate: exported records belong only to the authorized tenant.
- C2, medium: filenames describe the exported data.
- C3, medium: CSV files include column headers.

### Expected behavior

- A fails C1 and cannot advance, regardless of C2/C3 ratings or an aggregate score.
- B passes the stated specification criteria; any advancement is scoped to implementation, not production certification.
- Load scoring only for this requested numerical assessment; raw ratings and statuses agree.

## 6. Missing Criteria, Clear Goal

### Request

Review this design for specification completeness. I have not supplied acceptance criteria.

Goal: let a user resume an interrupted document upload.

Specification: the server records uploaded chunks under a stable upload ID. Reconnecting clients query stored chunk IDs and send only missing chunks. The final document is assembled after all chunks arrive. Expiration and checksum handling are unspecified.

### Expected behavior

- Derive labeled, observable criteria from resumability and completeness; identify assumptions rather than silently inventing requirements.
- Continue provisionally instead of blocking only because criteria are absent.
- Distinguish specified resumption behavior from undemonstrated integrity and retention guarantees; request decision-changing evidence.

## 7. Missing Artifact or Materially Ambiguous Goal

### Request A

Review my design for production readiness. I have not attached, linked, or described it.

### Request B

Design: an export job finishes faster by omitting some records. Review it against the goal "best export," but I have not specified whether completeness or speed governs the decision.

### Expected behavior

- A: ask one focused question requesting a reviewable artifact; pause without fabricated findings or a verdict.
- B: ask one focused question about the governing completeness/speed requirement before judging the tradeoff.
- Do not replace decision-changing ambiguity with unstated reviewer preferences.

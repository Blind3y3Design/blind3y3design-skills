# Technical Checks

Use for architecture, code, services, data handling, security, or operations. Apply dimensions within the requested mode and artifact scope; record outcomes using the core skill's coverage states and Evidence contract.

| Dimension | Checks and scenarios |
|---|---|
| Assumptions and goal fit | Load-bearing dependencies; achievable performance/consistency requirements; measurable success versus superficial acknowledgment |
| Security and abuse | Trust boundaries; authentication/authorization; tenant isolation; untrusted input/injection; secrets and data exposure; abuse/resource limits |
| Concurrency and consistency | Races; retries; duplicate delivery; idempotency; ordering; conflicting writes; stale reads; transaction boundaries |
| Failure and recovery | Partial failure; timeouts; cascading effects; recovery ownership; backup/restore; reconciliation; data loss |
| Capacity and boundaries | Empty/full states; cold start; saturation; backpressure; limits just beyond nominal load; cost under misuse |
| Operability | Useful observability; debugging; on-call burden; deployment; rollback; migration compatibility; operational cost |
| Simplicity and change | Accidental complexity; coupling; speculative generality; dependency decay; scale/organizational assumptions; ownership changes |

Trace a concrete failure sequence from trigger through impact and recovery. Separate failures implied by explicit semantics from behavior the specification leaves unknown. Claims about throughput, durability, or incident frequency require relevant measurements or verified documentation; an architecture diagram alone is insufficient.

Consult applicable platform documentation, internal runbooks, and authoritative security standards as needed. Cite the specific source supporting the claim rather than applying an unrelated generic standard.

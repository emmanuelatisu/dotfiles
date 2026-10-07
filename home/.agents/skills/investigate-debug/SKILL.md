---
name: investigate-debug
description: Investigate a failure with evidence before changing the system, then apply the narrowest justified fix.
---

# Investigate and Debug

## When to use
Use when a failure, bug, regression, or unexpected behavior needs explanation before modification.

## Procedure
1. State the observed symptom precisely.
2. Reproduce it, or establish equivalent objective evidence.
3. Identify the narrowest relevant execution path.
4. Form a small set of competing causal hypotheses.
5. Use tests, logs, traces, history, or minimal experiments that distinguish those hypotheses.
6. Establish a plausible root cause before widening the change.
7. Fix the cause rather than suppressing only its visible consequence.
8. Avoid cleanup or refactoring unless necessary to remove the cause.
9. Add a regression test when the failure has a stable, useful behavioral assertion.
10. Re-run the original reproduction plus relevant adjacent verification.

Prefer evidence-producing actions over speculative edits.

## Stop / escalate
Stop and state what evidence is missing when:
- The failure cannot be reproduced and available evidence cannot discriminate causes.
- Required production or environment data is unavailable.
- Evidence points outside the repository or authorized scope.
- The justified fix requires a material public contract, data-model, security, migration, or architecture decision.

## Output
Use exactly:

```text
Symptom
- ...

Evidence
- ...

Root cause
- ...

Fix
- ...

Verification
- ...

Remaining uncertainty
- None
```

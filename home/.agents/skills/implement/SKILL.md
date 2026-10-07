---
name: implement
description: Execute an approved or obvious repository change with the smallest coherent patch and targeted verification.
---

# Implement

## When to use
Use for an approved or obvious implementation task where the intended behavior is sufficiently clear.

## Procedure
1. Read applicable repository instructions and only the architecture, testing, and domain material relevant to the change.
2. Inspect nearby implementations and tests before inventing a new pattern.
3. Implement the smallest coherent patch satisfying the acceptance criteria.
4. Preserve unrelated structure and contracts.
5. Add or modify tests when they protect meaningful behavior or a regression.
6. Follow the repository's testing boundary and mocking strategy. Do not mock the behavior being proven.
7. Update an authoritative document only when this change makes it false.
8. Run targeted verification first, then required broader checks.
9. Review the final diff for accidental scope expansion before reporting completion.

## Do not
- Opportunistically refactor.
- Introduce abstractions for possible future use.
- Broaden formatting, renaming, or cleanup.
- Add comments that narrate obvious code.
- Create new documentation files without a clear authoritative role.

## Stop / escalate
Stop and surface the issue when:
- Evidence invalidates the approved plan.
- The implementation requires an unapproved public contract, data-model, migration, security, or architecture decision.
- Required behavior cannot be verified.
- An unrelated repository failure prevents reliable validation.

Do not stop for minor local implementation choices that are reversible and consistent with nearby code.

## Output
Use exactly:

```text
Changed
- ...

Why
- ...

Verification
- <command/check>: pass|fail|not run

Deviations from plan
- None

Remaining uncertainty
- None
```

---
name: plan
description: Produce the smallest safe implementation strategy when behavior, scope, or risk is not obvious.
---

# Plan

## When to use
Use when the requested change is not a local, reversible change whose intended diff is essentially one sentence.

## Procedure
1. Read applicable repository instructions.
2. Inspect only the code, tests, documentation, and history needed to understand the task.
3. Establish:
   - desired behavior;
   - current behavior;
   - explicit non-goals;
   - acceptance criteria.
4. Identify the smallest coherent change.
5. Identify affected interfaces, boundaries, data, invariants, and likely files.
6. Prefer existing local patterns. Do not propose unrelated cleanup or speculative abstractions.
7. Define verification at the closest meaningful behavioral boundary.
8. Separate decisions safely inferable from repository evidence from decisions that materially alter product behavior, architecture, public contracts, data, security, or migrations.
9. Do not edit implementation code while operating in planning-only mode.

## Stop / escalate
Stop and surface the issue when:
- Requirements materially conflict.
- Externally visible behavior cannot be determined.
- Safe implementation requires substantially broader scope than requested.
- An irreversible or consequential decision lacks sufficient authority or evidence.

Do not escalate for choices that are local, reversible, and well supported by repository conventions.

## Output
Use exactly:

```text
Goal
- ...

Current behavior
- ...

Proposed change
1. ...
2. ...

Verification
- ...

Risks / open decisions
- None
```

Keep the plan implementation-sized. Do not turn it into a design document unless the task itself requires one.

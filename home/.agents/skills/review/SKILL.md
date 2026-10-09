---
name: review
description: Review an actual change for substantive correctness, regressions, risks, boundary violations, and unnecessary scope.
---

# Review

## When to use
Use to review an actual diff against the task, acceptance criteria, repository instructions, and affected system behavior.

For consequential changes, prefer a fresh context or independent reviewer when practical so the review is not anchored on the implementation reasoning.

## Procedure
1. Review the actual diff, not only the author's summary.
2. Check it against the task and acceptance criteria.
3. Check repository instructions and affected behavior.
4. Prioritize, in order:
   1. Incorrect or incomplete behavior.
   2. Regressions and missing edge cases.
   3. Security, concurrency, data-integrity, compatibility, and migration risks.
   4. Violated architectural boundaries or dependency direction.
   5. Unnecessary refactors, abstractions, files, or scope expansion.
   6. Misleading tests, especially over-mocking, implementation-detail assertions, or tests that cannot distinguish realistic wrong implementations.
   7. Missing integration/E2E coverage where the change crosses a real boundary.
   8. Stale or contradictory authoritative documentation.
   9. Concrete maintainability problems.

## Do not report
- Formatter/linter issues already covered by automated checks.
- Vague style preferences.
- Hypothetical redesigns unrelated to the task.
- Findings invented merely to make the review look useful.

Each finding must be actionable and evidence-based.

## Stop / escalate
State the limitation instead of guessing when:
- Acceptance criteria are unavailable or contradictory.
- Correctness depends on inaccessible runtime, production data, or domain knowledge.
- The decision is primarily product or architecture judgment rather than something the diff can establish.

## Output

If findings exist:

```text
Findings

[high|medium|low] <short title>
Location: <file:line>
Risk: <specific failure>
Evidence: <why this follows from the code/task>
Smallest correction: <concrete fix>

Residual risks / verification gaps
- ...
```

If no substantive findings exist:

```text
No substantive findings.

Residual risks / verification gaps
- <anything not actually verified, or "None identified">
```

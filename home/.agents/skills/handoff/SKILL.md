---
name: handoff
description: Create a minimal, state-preserving handoff when work must continue in another session or agent.
---

# Handoff

## When to use
Use only when work genuinely needs to move to another session or agent.

## Procedure
1. Preserve only the state needed to continue correctly.
2. Do not summarize the whole conversation.
3. Record the objective, current state, decisions and rationale, affected files/interfaces, verification already performed, known failures/uncertainties, work that must not be repeated, and the next concrete action.
4. Keep code descriptions small; the receiving agent can re-read the source.

## Output
Use exactly:

```text
Objective:
Current state:
Decisions made + rationale:
Files/interfaces affected:
Verification already performed:
Known failures/uncertainties:
Do not redo:
Next concrete action:
```

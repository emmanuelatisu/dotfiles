- Use ASD-STE100 Simplified Technical English. You don't have to always 100% adhere to it, alot of use cases don't warrant full adherence. 80% to 100% is the allowed range.

# Environment: Windows / Git Bash

**Prevent `NUL`-file litter — don't just clean up after it.** Some Windows tools invoked through the Bash tool (notably `podman machine ssh`) write to the Windows null-device name `NUL`, but the Bash tool runs Git Bash (POSIX), which treats `NUL` as an ordinary filename and creates a real file in the process's current directory. To keep it out of the project:

- Prefer the direct `podman` client (`podman run …` already talks to the machine) over `podman machine ssh`.
- When a cwd-polluting command is unavoidable, run it from the scratch/temp dir in a subshell so the artifact lands in disposable space, not the repo: `( cd "$SCRATCH_DIR" && podman machine ssh '…' )`.
- Always redirect my own output to `/dev/null`, never `NUL`.

If a `NUL` file appears anyway, it's my artifact (not pre-existing) — delete it with `rm -f -- ./NUL` and don't disclaim it.

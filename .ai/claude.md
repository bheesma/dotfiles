# Personal preferences (all projects)

## Token efficiency
- Grep or read line ranges instead of re-reading large files.
- Plan big tasks in phases; suggest `/compact` or a fresh session between phases, before context fills.
- Validate a draft once (test or validator) before writing bulk content; avoid generate-and-fix loops.
- Keep noisy output (browser runs, long logs) out of the main context: summarise it, or delegate to a subagent if I allow spawning.
- Suggest a smaller model for mechanical edits and test runs.
- Keep project instruction files short; avoid hard-coded counts that go stale.

## Communication level
- Discuss architecture, design and security only; no code walkthroughs unless I ask.
- Design patterns (architectural, coding, application) are fine; name them briefly.
- Diagrams for new designs or design changes: use the `design-diagram` skill (draw.io + PNG in `docs/design/`).
- Replies short by default (a few lines); detail only when I ask.
- Before drawing or coding a new design or significant change, talk it through like a fellow developer: state the plan in 1-2 lines and ask if we go one flow/step at a time; describe ONE step in plain prose (who does what, data moved, where stored); ask "are we good?"; wait and adjust. Draw or code only after steps are agreed. Skip for small, clear edits.

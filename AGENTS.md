# Project Agent Instructions

## Quality-First Delegation Policy

- Prioritize quality, correctness, and safety over minimizing tokens or credits.
- The lead model owns architecture, complex implementation, risky refactors, database and security decisions, integration judgment, and final code review.
- Delegate only routine, well-scoped, low-risk tasks to `gpt-5.6-luna`, such as searches, read-only analysis, documentation, basic tests, and information gathering.
- Do not use Astra.
- Never accept a subagent result blindly. The lead model must inspect the actual code, diffs, and test results before relying on or applying it.
- After changes, run appropriate tests, analysis, formatting, or other relevant checks when possible; review the results with the lead model.
- Prefer sequential delegation; use parallel subagents only when independent work provides a clear quality or delivery benefit.

## Commit Attribution

- AI commits must include `Co-Authored-By: (the agent model's name and attribution byline)`.

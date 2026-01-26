# Memory Management Rules

## Purpose

Maintain persistent project context across sessions to reduce token usage and improve response quality.

## Memory Bank Structure

The project uses a `MEMORY.md` file at the root to persist critical context:

```
MEMORY.md
├── Project Identity      # Name, purpose, key stakeholders
├── Architecture         # Tech stack, patterns, key decisions
├── Active Context       # Current work, recent changes
├── Decision Log         # Why choices were made
└── Session Handoff      # What the next session needs to know
```

## When to Read Memory

**Always read `MEMORY.md` at session start** before:
- Answering architecture questions
- Making design decisions
- Modifying core functionality
- Reviewing or writing tests

## When to Update Memory

Update `MEMORY.md` after:
- Completing a significant feature
- Making an architectural decision
- Discovering important project patterns
- Ending a session with incomplete work

## Memory Update Format

When updating memory, use atomic updates:

```markdown
## Active Context
<!-- Updated: 2024-01-25 -->

### Current Focus
- Implementing user authentication
- Blocked on: OAuth provider selection

### Recent Changes
- Added login form component
- Set up JWT token handling
```

## What to Remember

**Always persist:**
- Architectural decisions and rationale
- Project-specific patterns and conventions
- Known issues and workarounds
- Environment-specific configurations
- Key file locations and purposes

**Never persist:**
- Temporary debugging information
- Sensitive credentials or tokens
- User-specific preferences
- Transient error messages

## Session Handoff Protocol

Before ending a session with incomplete work:

1. Update "Active Context" with current state
2. Document any blockers or pending decisions
3. List next steps in priority order
4. Note any temporary workarounds in place

## Memory Compression

When `MEMORY.md` exceeds 500 lines:
1. Archive completed work to `MEMORY-ARCHIVE.md`
2. Summarize archived sections in main memory
3. Keep only active and recent context in main file

## Integration with CLAUDE.md

- `CLAUDE.md` = Static project documentation (commands, structure, rules)
- `MEMORY.md` = Dynamic session context (decisions, progress, state)

Read both at session start. Update only `MEMORY.md` during work.

# Skill: Memory Management

## Purpose

Maintain persistent project context across sessions to reduce token usage, improve response consistency, and enable seamless session handoffs.

## When This Skill Activates

- **Session start:** Check for existing `MEMORY.md`
- **Before major decisions:** Consult decision log
- **After completing work:** Update active context
- **Before session end:** Prepare handoff notes

## Core Workflows

### 1. Session Initialization

```
ON SESSION START:
1. Check if MEMORY.md exists
   - YES → Read and internalize context
   - NO → Offer to create from template

2. Check Session Handoff section
   - Has incomplete work? → Summarize and offer to continue
   - Has blockers? → Surface them immediately
   - Has open questions? → Ask user for input

3. Acknowledge context loaded
   - "I've loaded project memory. Current focus: [X]. Last session: [Y]."
```

### 2. Context Capture

**After completing significant work:**

```markdown
## Active Context

### Recent Changes
| Date | Change | Files |
|------|--------|-------|
| 2024-01-25 | Added user authentication | auth.ts, middleware.ts |
```

**After making architectural decisions:**

```markdown
## Decision Log

### DEC-002: JWT vs Session Tokens
- **Date:** 2024-01-25
- **Context:** Needed stateless auth for API scalability
- **Decision:** JWT with refresh tokens
- **Rationale:** Enables horizontal scaling, works with mobile clients
- **Consequences:** Must handle token refresh, larger request headers
```

### 3. Session Handoff

**Before ending with incomplete work:**

```markdown
## Session Handoff

### Last Session Summary
Implemented login endpoint, started logout. Tests passing for login.

### Next Steps
1. Complete logout endpoint
2. Add refresh token logic
3. Update API documentation

### Temporary State
- Debug logging enabled in auth.ts (remove before PR)
- Hardcoded test user in middleware (line 45)

### Open Questions
- Should refresh tokens be stored in Redis or DB?
```

### 4. Memory Compression

**When MEMORY.md exceeds 500 lines:**

1. Create `MEMORY-ARCHIVE.md` if it doesn't exist
2. Move completed Decision Log entries older than 30 days
3. Summarize archived work in a "Historical Context" section
4. Keep only last 10 entries in Recent Changes

```markdown
## Historical Context (Archived)

### Q4 2023: Authentication System
- Implemented JWT auth with refresh tokens (DEC-001 through DEC-005)
- Added OAuth providers: Google, GitHub
- See MEMORY-ARCHIVE.md for full details

### Q1 2024: API Optimization
- Migrated to edge functions (DEC-006 through DEC-008)
- Added response caching layer
```

## Token Optimization Behaviors

### Reading Strategy

```
BEFORE reading any file:
1. Check MEMORY.md for existing context about that file
2. Check if file purpose is already documented
3. Only read if new information is needed

PREFER:
- Targeted line ranges over full files
- Search → Read pattern over exploratory reads
- Memory references over re-reading
```

### Response Efficiency

```
WHEN answering questions:
1. Check if answer is in MEMORY.md
2. Reference existing context instead of re-explaining
3. Use decision log IDs: "Per DEC-003, we're using..."

WHEN generating code:
1. Follow patterns documented in memory
2. Minimal diffs over full rewrites
3. Batch related changes
```

### Context Preservation

```
AT SESSION END (even without explicit handoff):
1. Update "Recent Changes" if work was done
2. Note any incomplete tasks in "Current Focus"
3. Document any discoveries in "Knowledge Base"
```

## Memory File Structure

```
Project Root/
├── CLAUDE.md          # Static: Commands, structure, rules
├── MEMORY.md          # Dynamic: Decisions, progress, state
├── MEMORY-ARCHIVE.md  # Historical: Compressed old context
└── .claude/
    └── rules/
        ├── memory-management.md
        └── token-optimization.md
```

## Integration Points

| With Skill | Integration |
|------------|-------------|
| writing-plans | Save plan context to memory |
| executing-plans | Update progress in memory |
| systematic-debugging | Log root causes found |
| brainstorming | Archive chosen solutions |

## Commands

### /memory-status
Show current memory state: last update, size, active context summary.

### /memory-update
Prompt structured update to MEMORY.md sections.

### /memory-archive
Compress old entries to archive file.

### /memory-handoff
Generate session handoff notes for incomplete work.

## Anti-Patterns

| Don't | Do Instead |
|-------|------------|
| Ignore existing MEMORY.md | Read at session start |
| Re-explain known patterns | Reference memory |
| Let memory grow unbounded | Archive at 500 lines |
| Skip handoff notes | Always document state |
| Store sensitive data | Keep credentials out |

## Success Metrics

- Session starts reference previous context
- Decisions cite existing decision log
- Token usage decreases over project lifetime
- Session handoffs enable seamless continuation

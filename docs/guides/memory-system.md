# Memory System Guide

The memory system provides persistent context across Claude Code sessions, reducing token usage and improving response consistency.

## Overview

The memory system consists of three components:

| Component | File | Purpose |
|-----------|------|---------|
| Memory Bank | `MEMORY.md` | Persistent project context |
| Memory Rules | `.claude/rules/memory-management.md` | Update protocols |
| Token Rules | `.claude/rules/token-optimization.md` | Efficiency guidelines |
| Memory Skill | `.claude/skills/superpowers/memory-management/` | Automated behaviors |

## MEMORY.md Structure

The memory bank template includes these sections:

### Project Identity
```markdown
## Project Identity

### Overview
- **Name:** Project Name
- **Type:** Web app / API / Library
- **Primary Language:** TypeScript / PHP
- **Framework:** Next.js / Laravel
```

### Architecture
```markdown
## Architecture

### Tech Stack
| Layer | Technology | Notes |
|-------|------------|-------|
| Frontend | React | Next.js App Router |
| Backend | Node.js | Express API |
| Database | PostgreSQL | Prisma ORM |

### Key Patterns
1. **Repository Pattern**
   - Where: `src/repositories/`
   - Why: Decouple data access from business logic
```

### Decision Log
```markdown
## Decision Log

### DEC-001: JWT vs Session Tokens
- **Date:** 2024-01-25
- **Context:** Needed stateless auth for API scalability
- **Decision:** JWT with refresh tokens
- **Rationale:** Enables horizontal scaling
- **Consequences:** Must handle token refresh
```

### Active Context
```markdown
## Active Context

### Current Focus
- [ ] Implementing user authentication
- [ ] Adding rate limiting

### Blockers
- Waiting on OAuth provider credentials

### Recent Changes
| Date | Change | Files |
|------|--------|-------|
| 2024-01-25 | Added login endpoint | auth.ts |
```

### Session Handoff
```markdown
## Session Handoff

### Last Session Summary
Implemented login endpoint, started logout.

### Next Steps
1. Complete logout endpoint
2. Add refresh token logic

### Temporary State
- Debug logging enabled in auth.ts (remove before PR)

### Open Questions
- Should refresh tokens be stored in Redis or DB?
```

## Memory Behaviors

### Session Start

When Claude starts a session, it should:

1. Check if `MEMORY.md` exists
2. Read and internalize the context
3. Check "Session Handoff" for incomplete work
4. Acknowledge loaded context

### During Work

Update memory after:
- Completing significant features
- Making architectural decisions
- Discovering important patterns
- Encountering notable issues

### Session End

Before ending with incomplete work:
1. Update "Active Context" with current state
2. Document blockers or pending decisions
3. List next steps in priority order
4. Note any temporary workarounds

## Token Optimization

The `token-optimization.md` rule provides guidelines for efficient context usage:

### Reading Strategy
- Prefer targeted line ranges over full files
- Use search → read pattern
- Reference memory instead of re-reading

### Response Efficiency
- Lead with the answer
- Summarize before detail
- Reference previous context

### Tool Usage
- Batch independent operations
- Use scoped searches
- Filter by file type

## Memory Compression

When `MEMORY.md` exceeds 500 lines:

1. Create `MEMORY-ARCHIVE.md`
2. Move old Decision Log entries (>30 days)
3. Summarize archived work
4. Keep only recent context in main file

```markdown
## Historical Context (Archived)

### Q4 2023: Authentication System
- Implemented JWT auth (DEC-001 through DEC-005)
- Added OAuth providers
- See MEMORY-ARCHIVE.md for details
```

## Deployment

Memory files are deployed automatically with every stack:

```bash
# Full deployment includes memory
ai-config --project=. 

# Memory is preserved on refresh
ai-config --refresh --project=.

# Force recreate memory (loses existing)
ai-config --clean --force --project=.
```

## Files in .gitignore

Add these to your `.gitignore`:

```
MEMORY.md
MEMORY-ARCHIVE.md
```

Memory is personal/local context and should not be committed.

## Integration with CLAUDE.md

| File | Type | Content |
|------|------|---------|
| `CLAUDE.md` | Static | Commands, structure, rules |
| `MEMORY.md` | Dynamic | Decisions, progress, state |

Read both at session start. Update only `MEMORY.md` during work.

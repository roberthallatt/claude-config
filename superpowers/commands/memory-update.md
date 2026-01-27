# Command: /memory-update

Update the project memory bank (MEMORY.md) with current session context.

## Trigger

User runs `/memory-update` or asks to update memory.

## Workflow

### 1. Check Current State

```
1. Read existing MEMORY.md
2. Identify sections that need updating:
   - Active Context / Current Focus
   - Recent Changes
   - Session Handoff
   - Decision Log (if decisions were made)
   - Knowledge Base (if discoveries were made)
```

### 2. Gather Updates

Ask user or infer from session:

```
What to capture:
- [ ] Work completed this session
- [ ] Files modified
- [ ] Decisions made and rationale
- [ ] Patterns or insights discovered
- [ ] Incomplete work / next steps
- [ ] Blockers or open questions
```

### 3. Update MEMORY.md

Apply updates to appropriate sections:

#### Recent Changes Table
```markdown
| Date | Change | Files |
|------|--------|-------|
| YYYY-MM-DD | Description of work | file1.ts, file2.ts |
```

#### Current Focus
```markdown
### Current Focus
[What's actively being worked on]

### Next Steps
1. [Immediate next task]
2. [Following task]
```

#### Decision Log (if applicable)
```markdown
### DEC-XXX: [Decision Title]
- **Date:** YYYY-MM-DD
- **Context:** Why this decision was needed
- **Decision:** What was decided
- **Rationale:** Why this choice
- **Consequences:** Trade-offs or implications
```

#### Session Handoff (if incomplete work)
```markdown
## Session Handoff

### Last Session Summary
[Brief description of work done]

### Incomplete Work
- [Task in progress]

### Temporary State
- [Any debug code, hardcoded values, etc.]

### Open Questions
- [Unresolved questions for next session]
```

### 4. Compression Check

```
IF MEMORY.md > 500 lines:
  1. Offer to archive old entries
  2. Move completed items older than 30 days to MEMORY-ARCHIVE.md
  3. Summarize archived content in Historical Context section
```

### 5. Confirm Update

```
Report to user:
- Sections updated
- New line count
- Compression recommendation (if needed)
```

## Quick Update Mode

For fast updates without prompts:

```
/memory-update quick
```

This auto-captures:
- Files modified in session
- Summary of changes made
- Current focus state

## Examples

**After completing a feature:**
```
/memory-update
> Added user authentication with JWT tokens
> Modified: auth.ts, middleware.ts, types.ts
> Decision: Using refresh tokens stored in httpOnly cookies
```

**Before ending session:**
```
/memory-update
> Partially complete: logout endpoint
> Next: Add token refresh logic
> Blocker: Need to decide on Redis vs DB for token storage
```

**Quick capture:**
```
/memory-update quick
```
(Auto-captures recent file changes and session context)

## Integration

This command works with:
- **Session hooks:** Can auto-run before session end
- **memory-management skill:** Follows same patterns
- **token-optimization:** Helps reduce re-reading in future sessions

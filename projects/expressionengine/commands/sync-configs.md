---
description: Synchronize Claude and Gemini configurations for consistent AI assistance
---

# Configuration Sync Command

Keep Claude Code and Gemini Code Assist configurations synchronized.

## Purpose

Ensures that:
1. CLAUDE.md and GEMINI.md have consistent project information
2. Coding standards are synchronized across both
3. Both AI assistants have the same context for optimal code generation

## Sync Operations

### 1. Project Information Sync

Compare and sync between CLAUDE.md and GEMINI.md:
- Project name and description
- Tech stack details
- Directory structure
- Development URLs
- PHP/Node versions

### 2. Coding Standards Sync

Synchronize:
- `.claude/rules/*.md` → `.gemini/styleguide.md`
- PHP coding standards
- Template conventions
- CSS/JS patterns
- Security guidelines

### 3. Instructions Sync

Update `.gemini/instructions.md` to match:
- Development commands from CLAUDE.md
- Project structure information

## Sync Process

### Step 1: Analyze Current State

```markdown
## Configuration Sync Analysis

### CLAUDE.md
- Last modified: {date}
- Tech stack: {detected}

### GEMINI.md  
- Last modified: {date}
- Tech stack: {detected}

### Differences Found
| Section | CLAUDE.md | GEMINI.md | Action |
|---------|-----------|-----------|--------|
| PHP Version | 8.2 | 8.1 | Update GEMINI.md |
| Build Command | Present | Missing | Add to GEMINI.md |
```

### Step 2: Apply Changes

Show diff and confirm for each file:

```diff
--- GEMINI.md
+++ GEMINI.md
@@ -10,7 +10,7 @@
 ## Tech Stack
 
-- **PHP Version**: 8.1
++ **PHP Version**: 8.2
```

## Usage

Run `/sync-configs` when:
- After running `/project-analyze`
- After modifying CLAUDE.md
- Before committing configuration changes
- When switching between Claude Code and Gemini

## Auto-Sync Rules

### Always Sync
- PHP/Node versions
- Database type/version
- Local development URLs
- Build commands

### Sync If Present
- Brand colors (if Tailwind)
- Security guidelines
- API documentation

### Never Overwrite
- Custom Gemini-only commands
- Custom Claude-only rules

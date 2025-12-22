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

### 2. Coding Standards Sync

Synchronize:
- `.claude/rules/*.md` → `.gemini/styleguide.md`

### 3. Instructions Sync

Update `.gemini/instructions.md` to match CLAUDE.md.

## Usage

Run `/sync-configs` when:
- After running `/project-analyze`
- After modifying CLAUDE.md
- Before committing configuration changes

## Auto-Sync Rules

### Always Sync
- PHP/Node versions
- Local development URLs
- Build commands

### Sync If Present
- Brand colors (if Tailwind)
- Security guidelines

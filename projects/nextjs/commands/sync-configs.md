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

## Usage

Run `/sync-configs` when:
- After running `/project-analyze`
- After modifying CLAUDE.md
- Before committing configuration changes

## Auto-Sync Rules

### Always Sync
- Node.js version
- Build commands
- Directory structure

### Sync If Present
- Brand colors (if Tailwind)
- TypeScript conventions

---
description: Analyze project and sync both Claude and Gemini configurations with project-specific details
---

# Project Analyzer & Configuration Sync

Comprehensive project analysis that updates both Claude Code and Gemini Code Assist configurations.

## Purpose

This command:
1. Scans the project to detect technologies, patterns, and configurations
2. Updates CLAUDE.md with accurate project details
3. Updates GEMINI.md to match (if Gemini is configured)
4. Syncs .gemini/styleguide.md with detected coding patterns
5. Identifies missing agents, rules, or skills based on project needs

## Analysis Steps

### 1. Package Configuration

Read `package.json` and extract:
- Next.js version
- React version
- Dependencies (Tailwind, etc.)
- Build scripts

### 2. Project Structure

Detect routing approach:
- App Router: `app/` directory
- Pages Router: `pages/` directory
- Components: `components/` or `src/components/`

### 3. Configuration Files & Framework Detection

**IMPORTANT: Detect what's actually in use, then remove what's not.**

Check for:
- `next.config.js` - Next.js config
- `tsconfig.json` - TypeScript config

- **Tailwind CSS**: `tailwind.config.js` exists?
  - If YES: Keep `.claude/rules/tailwind-css.md`
  - If NO: Remove `.claude/rules/tailwind-css.md` (not in use)

- **Foundation**: Check `package.json` for "foundation-sites" OR find `foundation.css`
  - If YES: Keep Foundation-related files
  - If NO: Remove Foundation files (not in use)

- **SCSS/Sass**: Check `package.json` for "sass"/"node-sass" OR find `.scss`/`.sass` files
  - If YES: Keep SCSS-related files
  - If NO: Remove SCSS files (not in use)

### 4. Clean Up Unused Files

**After detection, remove files for technologies NOT in use:**
- Delete `.claude/rules/*.md` for undetected frameworks
- Delete `.claude/commands/*.md` for undetected technologies
- Report what was removed to keep configuration clean

### 5. Detect Missing Components

Recommend:
- API routes detected → suggest api-design-specialist
- No security agent → suggest security-expert
- Complex state → suggest patterns for state management

## Sync Actions

**IMPORTANT: Update BOTH CLAUDE.md and GEMINI.md with identical values**

### Update CLAUDE.md
- Replace `{{PROJECT_NAME}}` and placeholders with detected values
- Update directory structure (App Router vs Pages Router)
- Update development commands from package.json
- Update detected technologies (Tailwind, SCSS, TypeScript)
- Document Next.js version and React version

### Update GEMINI.md (must match CLAUDE.md)
- Apply ALL the same updates as CLAUDE.md
- Keep content identical to CLAUDE.md (except Gemini-specific sections)
- Update project name, routing approach, technologies
- **Both files should have the same detected values**

### Update .gemini/styleguide.md (if exists)
- Add detected brand colors from tailwind.config.js
- Update React/TypeScript conventions
- Document detected patterns (Server Components, etc.)

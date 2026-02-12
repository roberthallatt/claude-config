---
description: Analyze project and update Claude configuration with project-specific details
---

# Project Analyzer & Configuration Sync

Comprehensive project analysis that updates Claude Code configuration.

## Purpose

This command:
1. Scans the project to detect technologies, patterns, and configurations
2. Updates CLAUDE.md with accurate project details

## Analysis Steps

### 1. Package Configuration

Read `package.json` and extract:
- Docusaurus version
- React version
- Custom plugins

### 2. Project Structure

Detect:
- Documentation: `docs/`
- Blog: `blog/`
- Custom pages: `src/pages/`
- Components: `src/components/`

### 3. Configuration Files & Framework Detection

**IMPORTANT: Detect what's actually in use, then remove what's not.**

Check for:
- `docusaurus.config.js` - Site config
- `sidebars.js` - Navigation structure

- **Tailwind CSS**: `tailwind.config.js` exists?
  - If YES: Keep `.claude/rules/tailwind-css.md`
  - If NO: Remove `.claude/rules/tailwind-css.md` (not in use)

- **SCSS/Sass**: Check `package.json` for "sass"/"node-sass" OR find `.scss`/`.sass` files
  - If YES: Keep SCSS-related files
  - If NO: Remove SCSS files (not in use)

- Custom CSS/themes in `src/css/`

### 4. Clean Up Unused Files

**After detection, remove files for technologies NOT in use:**
- Delete `.claude/rules/*.md` for undetected frameworks
- Delete `.claude/commands/*.md` for undetected technologies
- Report what was removed to keep configuration clean

### 5. Detect Missing Components

Recommend based on detected patterns.

## Sync Actions

### Update CLAUDE.md
- Replace `{{PROJECT_NAME}}` with detected values
- Update directory structure (docs/, blog/, src/)
- Update Docusaurus version and React version
- Update detected technologies (Tailwind, SCSS)
- Document custom plugins


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

### 1. DDEV/Environment Configuration

Read `.ddev/config.yaml` and extract environment details.

### 2. Project Structure (Bedrock/Sage)

Detect:
- Bedrock structure: `web/app/`
- Theme location: `web/app/themes/`
- Sage theme: Blade templates in `resources/views/`

### 3. Build Tools & Framework Detection

**IMPORTANT: Detect what's actually in use, then remove what's not.**

Check for:
- `bud.config.js` - Bud.js build
- `package.json` - npm scripts

- **Tailwind CSS**: `tailwind.config.js` exists?
  - If YES: Keep `.claude/rules/tailwind-css.md`
  - If NO: Remove `.claude/rules/tailwind-css.md` (not in use)

- **Alpine.js**: Check `package.json` for "alpinejs" OR search templates for `x-data`/`@click`
  - If YES: Keep `.claude/rules/alpinejs.md` and `.claude/commands/alpine-component-gen.md`
  - If NO: Remove these files (not in use)

- **Foundation**: Check `package.json` for "foundation-sites" OR find `foundation.css`
  - If YES: Keep Foundation-related files
  - If NO: Remove Foundation files (not in use)

- **SCSS/Sass**: Check `package.json` for "sass"/"node-sass" OR find `.scss`/`.sass` files
  - If YES: Keep SCSS-related files
  - If NO: Remove SCSS files (not in use)

- **Bilingual content**: Search templates for WordPress multilingual patterns
  - If YES: Keep `.claude/rules/bilingual-content.md`
  - If NO: Remove (not in use)

### 4. Plugins & ACF

Check `composer.json` for:
- WordPress plugins
- ACF Pro
- Custom packages

### 5. Clean Up Unused Files

**After detection, remove files for technologies NOT in use:**
- Delete `.claude/rules/*.md` for undetected frameworks
- Delete `.claude/commands/*.md` for undetected technologies
- Report what was removed to keep configuration clean

### 6. Detect Missing Components

Recommend agents/rules based on detected patterns.

## Sync Actions

**IMPORTANT: Update BOTH CLAUDE.md and GEMINI.md with identical values**

### Update CLAUDE.md
- Replace `{{PROJECT_NAME}}`, `{{DDEV_NAME}}` with detected values
- Update directory structure (Bedrock web/app/, Sage theme)
- Update development commands from package.json (Bud.js)
- Update detected technologies (Tailwind, Alpine, SCSS, bilingual)
- Add detected WordPress plugins and ACF

### Update GEMINI.md (must match CLAUDE.md)
- Apply ALL the same updates as CLAUDE.md
- Keep content identical to CLAUDE.md (except Gemini-specific sections)
- Update project name, DDEV config, URLs, technologies
- **Both files should have the same detected values**

### Update .gemini/styleguide.md (if exists)
- Add detected brand colors from tailwind.config.js
- Update WordPress/Blade conventions
- Document detected patterns (ACF blocks, etc.)

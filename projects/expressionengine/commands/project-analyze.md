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

Read `.ddev/config.yaml` and extract:
- **name**: Project name for URLs
- **docroot**: Document root path
- **php_version**: PHP version
- **database.type/version**: Database engine
- **nodejs_version**: Node.js version
- **additional_hostnames**: Other domains

### 2. Template Structure

Scan for templates:
- ExpressionEngine: `system/user/templates/`
- Find template group name, layouts, partials
- Detect bilingual patterns

### 3. Frontend Build Tools & Framework Detection

**IMPORTANT: Detect what's actually in use, then remove what's not.**

Check for:
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

- **Bilingual content**: Search templates for `{if lang ==` patterns
  - If YES: Keep `.claude/rules/bilingual-content.md`
  - If NO: Remove (not in use)

- `package.json` - npm scripts, build commands
- Build tools (Vite, Webpack, PostCSS)

### 4. Add-ons/Plugins

Scan `system/user/addons/` for:
- Stash, Structure, Low Variables
- MCP addon
- Custom add-ons

### 5. Clean Up Unused Files

**After detection, remove files for technologies NOT in use:**
- Delete `.claude/rules/*.md` for undetected frameworks
- Delete `.claude/commands/*.md` for undetected technologies
- Report what was removed to keep configuration clean

### 6. Detect Missing Components

Based on analysis, recommend:
- Livewire detected → suggest livewire-specialist agent
- Complex API → suggest api-design-specialist agent
- No security agent → suggest adding security-expert

## Sync Actions

**IMPORTANT: Update BOTH CLAUDE.md and GEMINI.md with identical values**

### Update CLAUDE.md
- Replace `{{PROJECT_NAME}}`, `{{DDEV_NAME}}`, `{{TEMPLATE_GROUP}}` with detected values
- Update directory structure section
- Update detected technologies list (Tailwind, Alpine, bilingual)
- Update build commands based on package.json
- Add detected EE add-ons (Stash, Structure, etc.)

### Update GEMINI.md (must match CLAUDE.md)
- Apply ALL the same updates as CLAUDE.md
- Keep content identical to CLAUDE.md (except Gemini-specific sections)
- Update project name, DDEV config, URLs, template group, technologies
- **Both files should have the same detected values**

### Update .gemini/styleguide.md (if exists)
- Add detected brand colors from tailwind.config.js
- Update framework conventions (Tailwind/Alpine/SCSS)
- Document detected coding patterns

## Output Format

```markdown
## Project Analysis: {project-name}

### Environment Detected
| Setting | Value |
|---------|-------|
| Local URL | https://{name}.ddev.site |
| PHP Version | {version} |
| Database | {type} {version} |

### Template Structure
- Group: `{group_name}`
- Layouts: `{path}`

### Add-ons Detected
- {addon1}
- {addon2}

### Brand Colors (if Tailwind)
- Primary: {color}
- Secondary: {color}

### Configuration Sync Status

| File | Status | Action |
|------|--------|--------|
| CLAUDE.md | ⚠️ Outdated | Update PHP version |
| GEMINI.md | ⚠️ Missing info | Add build commands |
| styleguide.md | ⚠️ Incomplete | Add brand colors |

### Missing Components Recommended
1. **security-expert agent** - Not present, recommended for all projects
2. **bilingual-content rule** - FR/EN detected

---

How would you like to proceed?
1. Full Sync (update all files)
2. Claude Only
3. Gemini Only  
4. Interactive (review each)
5. Report Only
```

## Sync Actions

When syncing, I will:

### Update CLAUDE.md
- Replace placeholders with detected values
- Update directory structure
- Update development commands

### Update GEMINI.md (if exists)
- Mirror relevant sections from CLAUDE.md
- Ensure consistent project overview

### Update .gemini/styleguide.md (if exists)
- Add detected brand colors
- Update framework conventions

### Create Missing Files
If needed, offer to create:
- Missing agents based on detected patterns
- Missing rules for detected frameworks

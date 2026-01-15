# Conditional Deployment & Technology Detection

**Updated:** January 2, 2026

## Overview

The setup script **intelligently detects** both your project's stack and its technologies, deploying only relevant configurations. This keeps everything clean and targeted to what your project actually uses.

## Stack Auto-Detection

When you run without specifying `--stack`:
```bash
ai-config --project=/path/to/project --with-all
```

The script will:
1. **Auto-detect the stack** (ExpressionEngine, Craft CMS, WordPress, Next.js, Docusaurus, Coilpack)
2. **Scan for technologies** (Tailwind, Alpine.js, bilingual content, etc.)
3. **Deploy stack-specific configurations** for all AI assistants
4. **Report** what was detected

### Detection Logic for Stacks

The script identifies stacks by looking for specific files and directories:

| Stack | Detection Pattern |
|-------|------------------|
| **ExpressionEngine** | `system/ee/` directory exists |
| **Craft CMS** | `craft` executable exists |
| **WordPress/Bedrock** | `wp-config.php` or `web/wp/` directory |
| **Next.js** | `next.config.js` or `next.config.mjs` exists |
| **Docusaurus** | `docusaurus.config.js` exists |
| **Coilpack** | Laravel structure + ExpressionEngine |

### Discovery Mode

For projects that don't match a known stack:
```bash
ai-config --project=/path/to/project --discover --with-all
```

The script will:
1. **Detect 50+ technologies** (React, Vue, Laravel, Django, Express, etc.)
2. **Deploy base configuration** for all AI assistants
3. **Generate discovery prompt** for AI analysis

Then open in Claude Code and run `/project-discover` to generate custom rules.

## Technology Detection

After determining the stack (auto or manual), the script scans for specific technologies:

### How It Works

```bash
# With auto-detected stack
ai-config --project=/path/to/project --with-all

# With manual stack
ai-config --stack=craftcms --project=/path/to/project --with-all
```

The script will:
1. **Identify the stack** (auto or manual)
2. **Scan the project** for technologies (Tailwind, Alpine.js, bilingual content, etc.)
3. **Always copy** core rules (accessibility, performance, stack-specific)
4. **Conditionally copy** optional rules based on detection
5. **Report** what was detected and what was skipped

## Detection Logic

### Tailwind CSS
- ✅ Detected if: `tailwind.config.js` exists in project root or docroot
- → Deploys: `tailwind-css.md`

### Foundation Framework
- ✅ Detected if:
  - `foundation-sites` found in `package.json`, OR
  - `foundation.min.css` or `foundation.css` found in project
- → Deploys: `foundation.md` (if rule exists)

### SCSS/Sass
- ✅ Detected if:
  - `sass` or `node-sass` found in `package.json`, OR
  - `*.scss` or `*.sass` files found in project
- → Deploys: `scss.md` (if rule exists)

### Alpine.js
- ✅ Detected if:
  - `alpinejs` found in `package.json`, OR
  - `x-data` or `@click` found in templates
- → Deploys: `alpinejs.md`

### Vanilla JS/HTML
- ✅ Detected if: No Tailwind, Foundation, or Alpine.js detected
- → Indicates project uses vanilla JavaScript and HTML without frameworks
- → Deploys: `vanilla-js.md` (if rule exists)

### Bilingual Content
- ✅ Detected if patterns found in templates:
  - `user_language` compared to `'en'` or `'fr'` (e.g., `user_language == 'en'`)
  - `{lang:` (ExpressionEngine lang tags)
  - `{% if.*lang` (Twig conditionals with lang variable)
  - `@lang` (Laravel localization helper)
- → Deploys: `bilingual-content.md`

## Rule Categories

### Core Rules (Always Deployed)
These are fundamental to all projects:
- `accessibility.md` - WCAG 2.1 AA compliance
- `performance.md` - Stack-specific optimization

### Stack-Specific Rules (Always Deployed)
Automatically deployed if they exist for the stack:
- `expressionengine-templates.md` (ExpressionEngine)
- `craft-templates.md` (Craft CMS)
- `blade-templates.md` (WordPress/Roots)
- `nextjs-patterns.md` (Next.js)
- `laravel-patterns.md` (Coilpack)
- `markdown-content.md` (Docusaurus)

### Optional Rules (Conditionally Deployed)
Only deployed if technology is detected:
- `tailwind-css.md` → if Tailwind detected
- `foundation.md` → if Foundation detected
- `scss.md` → if SCSS/Sass detected
- `alpinejs.md` → if Alpine.js detected
- `vanilla-js.md` → if no frameworks detected
- `bilingual-content.md` → if bilingual patterns detected
- `mcp-workflow.md` → always deployed if file exists

## Agent Filtering

The setup script now intelligently filters which AI agents are deployed based on the stack. This prevents irrelevant specialists (like a WordPress expert in a Next.js project) from being included.

### Universal Agents (Always Deployed)
These agents are relevant to all projects:
- `backend-architect.md` - Backend architecture and API design
- `frontend-architect.md` - Frontend patterns and component design
- `devops-engineer.md` - CI/CD, deployment, infrastructure
- `security-expert.md` - Security audits and best practices
- `performance-auditor.md` - Performance optimization
- `data-migration-specialist.md` - Database migrations and data transformations
- `server-admin.md` - Server configuration and management
- `code-quality-specialist.md` - Code quality and testing

### Stack-Specific Agents (Conditionally Deployed)
Only deployed when the stack matches:
- `coilpack-specialist.md` → only for `coilpack` stack
- `craftcms-specialist.md` → only for `craftcms` stack
- `expressionengine-specialist.md` → for `expressionengine` and `coilpack` stacks
- `ee-template-expert.md` → only for `expressionengine` stack
- `nextjs-specialist.md` → only for `nextjs` stack
- `react-specialist.md` → for `nextjs` and `docusaurus` stacks
- `wordpress-specialist.md` → only for `wordpress-roots` stack

## Example Output

### Auto-Detected Craft CMS with Tailwind and Alpine.js:
```bash
Detecting stack...
  ✓ Detected stack: craftcms

Scanning project...
  ✓ Found DDEV config
  ✓ Found template group: blog
  ✓ Tailwind CSS detected
  ✓ Alpine.js detected
  ○ No bilingual patterns detected

Copying rules (conditional based on detection)...
  ✓ Copied accessibility.md
  ✓ Copied performance.md
  ✓ Copied craft-templates.md
  ✓ Copied tailwind-css.md
  ✓ Copied alpinejs.md
  ○ Skipped bilingual-content.md (not detected)
```

### Auto-Detected Next.js WITHOUT Tailwind:
```bash
Detecting stack...
  ✓ Detected stack: nextjs

Scanning project...
  ✓ Found package.json
  ○ No Tailwind detected
  ○ No Alpine.js detected
  ○ No bilingual patterns detected

Copying rules (conditional based on detection)...
  ✓ Copied accessibility.md
  ✓ Copied performance.md
  ✓ Copied nextjs-patterns.md
  ○ Skipped tailwind-css.md (not detected)
  ○ Skipped alpinejs.md (not detected)
  ○ Skipped bilingual-content.md (not detected)
```

### Discovery Mode for Unknown Stack:
```bash
Detecting stack...
  ○ No known stack detected
  ✓ Using discovery mode

Scanning project...
  ✓ Detected: React, TypeScript, Vite, Vue Router
  ✓ Detected: Tailwind CSS
  ✓ Found 15 technologies

Deploying base configuration...
  ✓ Created discovery prompt
  ✓ Deployed all AI assistant configs

Next: Open in Claude Code and run /project-discover
```

## Benefits

### Zero Configuration Required
- No need to remember stack names or specify `--stack`
- Just point to your project and go
- Works for 6+ known stacks automatically

### Cleaner Configuration
- No unnecessary rules cluttering the `.claude/rules/` directory
- Only relevant AI assistants and configurations deployed
- Easier for developers to focus on what's relevant

### Accurate Context
- AI assistants only see rules for technologies actually in use
- Reduces potential confusion from irrelevant coding standards
- Stack-specific agents only deployed when relevant

### Automatic Adaptation
- As project evolves and adds Tailwind/Alpine, run `--refresh` to update
- Script will re-detect stack and technologies automatically
- No need to remember what stack you originally specified

### Works Everywhere
- Supports known stacks (auto-detect)
- Supports unknown stacks (discovery mode)
- Gracefully handles edge cases

## Manual Override

If you want to force inclusion of a rule, you can:

1. **Copy manually** after setup:
   ```bash
   cp ~/.claude-config/projects/craftcms/rules/alpinejs.md /path/to/project/.claude/rules/
   ```

2. **Modify detection** in `setup-project.sh` to always return true for specific technologies

## Refresh Behavior

When using `--refresh`:
```bash
ai-config --refresh --project=/path/to/project
```

The script will:
- **Auto-detect the stack** from existing configuration (no `--stack` needed!)
- **Re-detect all technologies** (Tailwind, Alpine.js, etc.)
- **Re-deploy rules** based on current detection
- **Update all AI assistant configs** that were previously deployed

**Note:** This will re-run detection, so if you added Tailwind since initial setup, the rule will now be included automatically.

## Detection Improvements

Future enhancements could detect:
- **React/Vue** in Next.js projects
- **Sass/SCSS** vs PostCSS
- **Specific Craft plugins** (SEOmatic, etc.)
- **WordPress plugins** (ACF, etc.)
- **Testing frameworks** (Jest, Vitest, PHPUnit)

## Summary

**Before:** Manual `--stack` required + all rules copied blindly → cluttered configuration

**After:** Auto-detect stack + smart technology detection → clean, targeted configuration

The setup script is now fully automatic and respects what your project actually uses. 🎯

## Quick Reference

```bash
# Auto-detect everything (recommended)
ai-config --project=/path/to/project --with-all

# Discovery mode for unknown stacks
ai-config --project=/path/to/project --discover --with-all

# Manual stack (if auto-detect fails)
ai-config --stack=craftcms --project=/path/to/project --with-all

# Refresh (auto-detects stack from existing config)
ai-config --refresh --project=/path/to/project
```

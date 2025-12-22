# Conditional Rule Deployment

**Updated:** December 22, 2024

## Overview

The setup script now **intelligently detects** project technologies and only deploys relevant coding rules. This keeps the configuration clean and targeted to what the project actually uses.

## How It Works

When you run:
```bash
./setup-project.sh --stack=craftcms --project=/path/to/project
```

The script will:
1. **Scan the project** for technologies (Tailwind, Alpine.js, bilingual content, etc.)
2. **Always copy** core rules (accessibility, performance, stack-specific)
3. **Conditionally copy** optional rules based on detection
4. **Report** what was detected and what was skipped

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

### Project WITH Tailwind and Alpine.js:
```bash
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

### Project WITHOUT Tailwind:
```bash
Scanning project...
  ✓ Found DDEV config
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

## Benefits

### Cleaner Configuration
- No unnecessary rules cluttering the `.claude/rules/` directory
- Easier for developers to focus on what's relevant

### Accurate Context
- Claude only sees rules for technologies actually in use
- Reduces potential confusion from irrelevant coding standards

### Automatic Adaptation
- As project evolves and adds Tailwind/Alpine, run `--refresh` to update
- Script will detect new technologies and deploy appropriate rules

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
./setup-project.sh --stack=craftcms --project=/path/to/project --refresh
```

The script will:
- Re-detect all technologies
- Re-deploy rules based on current detection
- **Note:** This will re-run detection, so if you added Tailwind since initial setup, the rule will now be included

## Detection Improvements

Future enhancements could detect:
- **React/Vue** in Next.js projects
- **Sass/SCSS** vs PostCSS
- **Specific Craft plugins** (SEOmatic, etc.)
- **WordPress plugins** (ACF, etc.)
- **Testing frameworks** (Jest, Vitest, PHPUnit)

## Summary

**Before:** All rules copied blindly → cluttered configuration

**After:** Smart detection → clean, targeted configuration

The setup script is now more intelligent and respects what your project actually uses. 🎯

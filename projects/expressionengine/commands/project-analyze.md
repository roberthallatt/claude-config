---
description: Analyze this project and customize Claude configuration based on the actual codebase
---

# Project Analyzer

Scan the current project directory to detect tools, configurations, and patterns, then customize the Claude configuration files accordingly.

## When to Use

Run this command after initial setup with `setup-project.sh` to:
- Detect actual DDEV configuration and update CLAUDE.md
- Find the correct template directory structure
- Identify CSS framework and build tools
- Detect bilingual setup patterns
- Find custom add-ons and their purpose
- Update commands with project-specific paths

## Analysis Steps

### 1. DDEV Configuration
Read `.ddev/config.yaml` and extract:
- **name**: DDEV project name (for URLs like `https://{name}.ddev.site`)
- **docroot**: Document root path (public, web, html, etc.)
- **php_version**: PHP version in use
- **database.type/version**: Database engine and version
- **nodejs_version**: Node.js version
- **additional_hostnames**: Other hostnames (bilingual domains, etc.)
- **webserver_type**: Apache or Nginx

Update CLAUDE.md with correct:
- Local development URLs
- PHP version requirements
- Database commands

### 2. Template Structure
Scan `system/user/templates/` to find:
- Template group name (may not match project slug)
- Layout structure (_layouts, stash, etc.)
- Partial organization
- Bilingual patterns (language conditionals, separate templates)

Update CLAUDE.md directory structure section.

### 3. Frontend Build Tools
Check for build configuration:
- `public/package.json` or `package.json` - npm scripts
- `public/tailwind.config.js` - Tailwind configuration
- `public/postcss.config.js` - PostCSS setup
- `public/vite.config.js` - Vite (if used)
- `public/webpack.config.js` - Webpack (if used)
- `gulpfile.js` - Gulp (if used)

Update:
- CLAUDE.md build commands section
- `.claude/commands/tailwind-build.md` with correct paths

### 4. ExpressionEngine Add-ons
Scan `system/user/addons/` for:
- Stash (caching) - confirm version and usage
- Structure (navigation) - check if in use
- Low Variables - language variables
- Assets or other file management
- Custom add-ons specific to this project

Update:
- CLAUDE.md with add-on documentation
- Rules if add-ons have specific patterns

### 5. Brand Colors (if Tailwind)
Read `tailwind.config.js` to extract:
- Custom color definitions
- Brand color names and values

Update:
- `.claude/skills/tailwind-utility-finder/BRAND_COLORS.md`
- `.claude/rules/tailwind-css.md` with actual colors

### 6. Bilingual Detection
Look for patterns:
- Language conditionals in templates: `{if lang == 'en'}`
- Separate template groups per language
- Low Variables with `_en` / `_fr` suffixes
- Multiple domains in DDEV config

Update:
- `.claude/rules/bilingual-content.md` if patterns differ
- CLAUDE.md bilingual section

### 7. GitHub Workflows
Check `.github/workflows/` for:
- Deployment workflow (branch triggers, servers)
- Build steps
- Environment variables needed

Update CLAUDE.md deployment section.

## Output Format

After analysis, provide:

```markdown
## Project Analysis: {project-name}

### Detected Configuration

| Setting | Value |
|---------|-------|
| DDEV Name | {name} |
| Local URL | https://{name}.ddev.site |
| PHP Version | {php_version} |
| Database | {db_type} {db_version} |
| Node.js | {nodejs_version} |
| Docroot | {docroot} |

### Template Structure
- Template Group: `{group_name}`
- Layouts: `{layout_path}`
- Partials: `{partials_path}`

### Build Tools
- Package Manager: npm/yarn
- CSS Framework: Tailwind {version}
- Build Command: `{build_command}`

### Add-ons Detected
- Stash {version}
- Structure {version}
- {other add-ons}

### Bilingual Setup
- Pattern: {conditional/separate/none}
- Languages: EN, FR

### Recommended Updates

1. **CLAUDE.md**: Update local URLs, PHP version, build commands
2. **rules/tailwind-css.md**: Add brand colors: {colors}
3. **commands/ddev-helper.md**: Update project name references

### Files to Modify
{list of files with specific changes}
```

## Auto-Apply Option

After showing the analysis, ask:
1. Show the changes (diff view)
2. Apply all changes automatically
3. Apply changes interactively (one by one)
4. Save analysis report only

## Example Usage

```
User: /project-analyze

Claude: I'll scan this project to customize the configuration...

[Reads .ddev/config.yaml]
[Scans system/user/templates/]
[Reads public/tailwind.config.js]
[Checks system/user/addons/]

## Project Analysis: cpsp

### Detected Configuration
| Setting | Value |
|---------|-------|
| DDEV Name | cpsp |
| Local URL | https://cpsp.ddev.site |
| PHP Version | 8.2 |
| Database | MariaDB 10.11 |
...

Would you like me to:
1. Show the specific changes I'll make
2. Apply all changes automatically
3. Apply changes one by one
4. Save this report only
```

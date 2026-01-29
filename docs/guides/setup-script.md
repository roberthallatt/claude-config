# Setup Script Guide

Comprehensive guide to using the `ai-config` command (the global alias for `setup-project.sh`).

## Synopsis

```bash
ai-config [OPTIONS]
```

## Required Options

### --project=\<path>

Target project directory (absolute or relative path, use `.` for current directory).

**Required for all operations.**

## Stack Selection

### Auto-Detect (Recommended)

If you omit `--stack`, the script will automatically detect your project's stack:

```bash
ai-config --project=/path/to/project --with-all
```

**Detects:**
- ExpressionEngine 7.x
- Craft CMS
- WordPress/Bedrock
- Standard WordPress
- Next.js 14+
- Docusaurus 3+
- Coilpack (Laravel + EE hybrid)

### --stack=\<name>

Manually specify the technology stack template to use.

**Available stacks:**
- `expressionengine`
- `coilpack`
- `craftcms`
- `wordpress-roots`
- `wordpress`
- `nextjs`
- `docusaurus`
- `custom` (used with `--discover`)

**Example:**
```bash
ai-config --stack=expressionengine --project=/path/to/project
```

### --discover

AI-powered discovery mode for projects that don't match a known stack.

```bash
ai-config --discover --project=/path/to/project --with-all
```

This will:
1. Detect 50+ technologies (React, Vue, Laravel, Django, Express, etc.)
2. Deploy base configuration for all AI assistants
3. Deploy memory bank and token optimization
4. Generate a discovery prompt for AI analysis

Then open in Claude Code and run `/project-discover` to generate custom rules.

## Deployment Options

### --with-all

Deploy configurations for all 6 AI coding assistants.

**Recommended for maximum compatibility.**

Creates:
- Claude Code (always deployed) → `CLAUDE.md`, `MEMORY.md`, `.claude/`
- Gemini Code Assist → `GEMINI.md`, `.gemini/`
- GitHub Copilot → `.github/copilot-instructions.md`
- Cursor AI → `.cursorrules`
- Windsurf AI → `.windsurfrules`
- OpenAI Codex → `AGENTS.md`

**Template fallback:** For AI assistants without stack-specific templates, the script uses common fallback templates from `projects/common/`.

### --with-gemini

Deploy Gemini Code Assist configuration alongside Claude Code.

Creates:
- `GEMINI.md`
- `.gemini/` directory

### --with-copilot

Deploy GitHub Copilot configuration.

Creates:
- `.github/copilot-instructions.md`

### --with-cursor

Deploy Cursor AI configuration.

Creates:
- `.cursorrules`

### --with-windsurf

Deploy Windsurf AI configuration.

Creates:
- `.windsurfrules`

### --with-codex

Deploy OpenAI Codex configuration.

Creates:
- `AGENTS.md`

## Memory & Token Optimization

Every deployment includes the memory system:

- `MEMORY.md` - Persistent memory bank (preserved on refresh)
- `.claude/rules/memory-management.md` - Memory update protocols
- `.claude/rules/token-optimization.md` - Token efficiency rules
- `.claude/skills/superpowers/memory-management/` - Memory skill

See [Memory System Guide](memory-system.md) for details.

## Superpowers Skills

Superpowers workflow skills are enabled by default:

### Skill Options

| Flag | Description |
|------|-------------|
| `--no-superpowers` | Disable all Superpowers skills |
| `--superpowers-all` | Deploy all skills (default) |
| `--superpowers-core` | Deploy core skills only |
| `--superpowers-minimal` | Deploy bootstrap skill only |
| `--superpowers-skill=X` | Deploy specific skills (comma-separated) |

### Available Skills

| Skill | Purpose |
|-------|---------|
| `memory-management` | Persistent context across sessions |
| `brainstorming` | Structured idea generation |
| `writing-plans` | Implementation planning |
| `executing-plans` | Step-by-step execution |
| `systematic-debugging` | Root cause analysis |
| `test-driven-development` | TDD workflow |
| `dispatching-parallel-agents` | Multi-agent coordination |
| `using-git-worktrees` | Git worktree workflows |

## Update Options

### --refresh

Update configuration files while preserving customizations.

**Behavior:**
- Re-scans project for technology changes
- Updates `CLAUDE.md` and other config files
- **Preserves `MEMORY.md`** (never overwritten)
- Preserves `.claude/` customizations
- Updates Superpowers skills

**Example:**
```bash
ai-config --refresh --stack=custom --project=/path/to/project
```

**Note:** Specify `--stack` for refresh if auto-detection fails.

### --force

Overwrite existing files without prompting.

**Warning:** This will replace config files, but still preserves `MEMORY.md`.

### --clean

Remove all existing AI configuration before deploying.

Deletes:
- `CLAUDE.md`, `.claude/`
- `GEMINI.md`, `.gemini/`, `.geminiignore`
- `.github/copilot-instructions.md`
- `.cursorrules`
- `.windsurfrules`
- `AGENTS.md`

**Note:** `MEMORY.md` is NOT deleted by `--clean` to preserve project memory.

Use this for a complete fresh start.

## Advanced Options

### --dry-run

Preview changes without modifying any files.

**Output shows:**
- What would be created
- What would be overwritten
- Detected technologies
- Template variables

**Example:**
```bash
ai-config --dry-run --stack=expressionengine --project=.
```

### --skip-vscode

Skip VSCode configuration deployment.

Use this if you manage `.vscode/` settings separately or don't use VSCode.

### --with-mcp

Deploy `.mcp.json` for standalone MCP server integration.

**Note:** Most users should use `.vscode/settings.json` or `.gemini/settings.json` for MCP configuration instead.

### --analyze

Generate analysis prompt for Claude to customize configuration.

Outputs a prompt you can paste into Claude to get customization suggestions.

## Project Detection

The script automatically detects:

### DDEV Configuration
- Project name
- Document root
- PHP version
- Database type and version
- Primary URL

### Frontend Technologies
- **Tailwind CSS** - `tailwind.config.js` or npm dependency
- **Foundation** - npm dependency or CDN link
- **SCSS/Sass** - `.scss` files
- **Alpine.js** - `x-data` or `@click` attributes in templates
- **Vanilla JS** - `.js` files without framework imports

### Template Engines
- **ExpressionEngine** - `system/ee/` directory
- **Craft CMS** - `craft` executable
- **Blade** - `.blade.php` files
- **Twig** - `.twig` files

### Content Patterns
- **Bilingual** - French language strings or `lang:` tags
- **Stash add-on** - `exp:stash` tags (ExpressionEngine)
- **Structure add-on** - `exp:structure` tags (ExpressionEngine)

## Examples

### Auto-Detect Any Project (Recommended)

```bash
# Let the script detect your stack
ai-config --project=/Users/dev/myproject --with-all
```

### First-Time Setup (Manual Stack)

```bash
ai-config \
  --stack=expressionengine \
  --project=/Users/dev/myproject \
  --with-all
```

### Discovery Mode for Unknown Stack

```bash
# For Vue, Laravel, Django, etc.
ai-config --discover --project=/Users/dev/my-vue-app --with-all
```

### Current Directory Shortcut

```bash
cd /path/to/project
ai-config --project=. --with-all
```

### Update After Technology Changes

```bash
# Added Tailwind CSS to your project
ai-config --refresh --stack=custom --project=/Users/dev/myproject
```

### Force Clean Reinstall

```bash
ai-config \
  --clean \
  --force \
  --stack=craftcms \
  --project=.
```

### Preview Without Changes

```bash
ai-config \
  --dry-run \
  --project=../my-nextjs-app \
  --with-all
```

### Core Skills Only

```bash
ai-config \
  --project=. \
  --superpowers-core \
  --with-gemini
```

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | Invalid options or missing requirements |
| 2 | Project directory doesn't exist |
| 3 | Stack not found |

## Troubleshooting

### "Unknown option" Error

Make sure to use `=` syntax for values:
```bash
# Correct
--stack=expressionengine

# Incorrect
--stack expressionengine
```

### "Could not detect stack" Error

The script couldn't automatically identify your project's stack. Options:

1. **Specify manually:** Use `--stack=<name>` if it's a known stack
2. **Use discovery mode:** Run with `--discover` for unknown stacks
3. **Check project:** Ensure project has recognizable files (e.g., `system/ee/`, `craft`, `wp-config.php`, `next.config.js`)

### Technology Not Detected

Detection scans template files only (excluding `node_modules`, `vendor`). If technology isn't detected:
1. Ensure config files are in project root
2. Check template files contain the expected patterns
3. Use `--dry-run` to see detection results

## Next Steps

- **[Memory System](memory-system.md)** - Persistent context guide
- **[Installation](../getting-started/installation.md)** - Shell aliases and VSCode CLI setup
- **[Conditional Deployment](conditional-deployment.md)** - Detection logic
- **[Updating Projects](updating-projects.md)** - Update workflows

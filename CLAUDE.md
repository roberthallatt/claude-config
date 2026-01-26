# AI Configuration Repository

Universal AI coding assistant configuration for modern web development stacks.

## Project Overview

This repository provides automated configuration deployment for **6 AI coding assistants** across **8 technology stacks** with:
- Automatic stack detection
- Memory bank for persistent context
- Token optimization rules
- VSCode settings (formatters, Xdebug, tasks)
- 15 Superpowers workflow skills

**Repository Path:** `/Users/robert/data/business/_tools/claude-config`

## Supported AI Assistants

| Assistant | Config File | Template Location |
|-----------|-------------|-------------------|
| Claude Code | `CLAUDE.md`, `MEMORY.md`, `.claude/` | Stack-specific (all stacks) |
| Gemini Code Assist | `GEMINI.md`, `.gemini/` | Stack-specific (all stacks) |
| GitHub Copilot | `.github/copilot-instructions.md` | Common fallback |
| Cursor AI | `.cursorrules` | EE + common fallback |
| Windsurf AI | `.windsurfrules` | EE + common fallback |
| OpenAI Codex | `AGENTS.md` | EE + common fallback |

## Supported Stacks

| Stack ID | Framework | Template Engine |
|----------|-----------|-----------------|
| `expressionengine` | ExpressionEngine 7.x | EE Templates |
| `coilpack` | Laravel + EE | Blade/Twig/EE |
| `craftcms` | Craft CMS | Twig |
| `wordpress-roots` | WordPress/Bedrock | Blade (Sage) |
| `wordpress` | WordPress | PHP |
| `nextjs` | Next.js 14+ | React/TSX |
| `docusaurus` | Docusaurus 3+ | MDX |
| `custom` | Discovery mode | Any |

## Key Files

### Scripts
- `setup-project.sh` - Main deployment script (aliased as `ai-config`)
- `serve-docs.sh` - Local documentation server (aliased as `ai-config-docs`)

### Template Structure
```
projects/
├── common/                    # Global fallback templates
│   ├── copilot/              # GitHub Copilot
│   ├── cursor/               # Cursor AI
│   ├── windsurf/             # Windsurf AI
│   ├── openai/               # OpenAI Codex
│   ├── rules/                # Memory & token rules
│   └── MEMORY.md.template    # Memory bank template
├── expressionengine/         # Full stack config
├── coilpack/                 # Full stack config
├── craftcms/                 # Full stack config
├── wordpress-roots/          # Full stack config
├── wordpress/                # Full stack config
├── nextjs/                   # Full stack config
├── docusaurus/               # Full stack config
└── custom/                   # Discovery mode base

superpowers/
├── skills/                   # 15 workflow skills
│   ├── memory-management/
│   ├── brainstorming/
│   ├── writing-plans/
│   ├── systematic-debugging/
│   └── ...
├── commands/                 # Slash commands
└── hooks/                    # Session hooks
```

## Memory System

Every deployment includes persistent memory:

| Component | Purpose |
|-----------|---------|
| `MEMORY.md` | Project memory bank (preserved on refresh) |
| `memory-management.md` | Memory update protocols |
| `token-optimization.md` | Token efficiency rules |
| `memory-management/` | Memory skill in Superpowers |

See `docs/guides/memory-system.md` for full documentation.

## Usage

### Deploy to a Project
```bash
# Auto-detect stack and deploy all AI configs
ai-config --project=/path/to/project --with-all

# Specify stack manually
ai-config --stack=expressionengine --project=/path/to/project --with-all

# Discovery mode for unknown stacks
ai-config --discover --project=/path/to/project --with-all
```

### Update Existing Project
```bash
ai-config --refresh --stack=custom --project=/path/to/project
```

### View Documentation
```bash
ai-config-docs  # Opens at http://localhost:8000
```

## Template Fallback Logic

The setup script uses this priority for each AI assistant:

1. **Stack-specific template** - `projects/{stack}/{assistant}/`
2. **Common fallback** - `projects/common/{assistant}/`
3. **Error message** - Only if neither exists

### Current Coverage

| AI Assistant | Has Stack Templates | Has Common Fallback |
|--------------|---------------------|---------------------|
| Claude | All 8 stacks | Not needed |
| Gemini | All 8 stacks | Not needed |
| Copilot | None | Yes |
| Cursor | 2 stacks (EE, custom) | Yes |
| Windsurf | 2 stacks (EE, custom) | Yes |
| Codex | 2 stacks (EE, custom) | Yes |

## Superpowers Skills

15 workflow skills deployed by default:

| Skill | Purpose |
|-------|---------|
| `memory-management` | Persistent context |
| `brainstorming` | Idea generation |
| `writing-plans` | Implementation planning |
| `executing-plans` | Step-by-step execution |
| `systematic-debugging` | Root cause analysis |
| `test-driven-development` | TDD workflow |

Disable with `--no-superpowers`.

## Template Variables

Templates use `{{VARIABLE}}` syntax, replaced during deployment:

| Variable | Source |
|----------|--------|
| `{{PROJECT_NAME}}` | Directory name or `--name` flag |
| `{{PROJECT_SLUG}}` | Derived from name |
| `{{PROJECT_PATH}}` | Absolute path |
| `{{STACK}}` | Detected or specified stack |
| `{{DDEV_NAME}}` | `.ddev/config.yaml` |
| `{{DDEV_PRIMARY_URL}}` | `.ddev/config.yaml` |
| `{{DDEV_PHP}}` | `.ddev/config.yaml` |
| `{{DDEV_DB_TYPE}}` | `.ddev/config.yaml` |
| `{{DDEV_DB_VERSION}}` | `.ddev/config.yaml` |
| `{{DDEV_DOCROOT}}` | `.ddev/config.yaml` |
| `{{TEMPLATE_GROUP}}` | EE template directory |

## Development Guidelines

### Adding a New AI Assistant

1. Create common fallback template in `projects/common/{assistant}/`
2. Update `setup-project.sh` with deployment logic and fallback
3. Add command-line flag (`--with-{assistant}`)
4. Update documentation

### Adding Stack-Specific Templates

1. Create template in `projects/{stack}/{assistant}/`
2. Stack-specific automatically takes priority over common
3. No script changes needed

### Code Style (This Repository)

- Bash scripts: Use `set -e`, quote variables, meaningful names
- Markdown: ATX headings, fenced code blocks, reference links
- Templates: `{{UPPERCASE}}` for variables

## Documentation

- `docs/getting-started/` - Installation, quick start, configuration
- `docs/guides/` - Setup script, memory system
- `docs/reference/` - Stacks, file structure, commands
- `docs/development/` - Project status, contributing

## Recent Changes

- Added memory bank system (`MEMORY.md`, memory rules, memory skill)
- Added token optimization rules
- Added 15 Superpowers workflow skills
- Removed Aider support (not used)
- All stacks get configurations for all 6 AI assistants via `--with-all`

## Quick Reference

```bash
# Full deployment with all AI assistants
ai-config --project=. --with-all

# Discovery mode for unknown stacks
ai-config --discover --project=. --with-all

# Refresh (preserves MEMORY.md)
ai-config --refresh --stack=custom --project=.

# Preview without changes
ai-config --dry-run --project=. --with-all

# Force clean reinstall
ai-config --clean --force --project=. --with-all
```

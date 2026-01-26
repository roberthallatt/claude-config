# Quick Start

Deploy AI coding assistant configurations to your project in minutes.

## Basic Deployment

### Auto-Detect Stack (Recommended)

The script automatically detects your project's stack:

```bash
ai-config --project=/path/to/your/project --with-all
```

This will:
1. Auto-detect stack (ExpressionEngine, Craft CMS, WordPress, Next.js, Docusaurus, etc.)
2. Detect project technologies (Tailwind, Alpine.js, etc.)
3. Deploy configurations for all 6 AI assistants
4. Deploy memory bank and token optimization rules
5. Configure VSCode settings with syntax recognition

### New Project Setup (Manual Stack)

If you prefer to specify the stack manually:

```bash
ai-config \
  --stack=expressionengine \
  --project=/path/to/your/project \
  --with-all \
  --install-extensions
```

This will:
1. Use the specified stack template
2. Detect project technologies (Tailwind, Alpine.js, etc.)
3. Deploy configurations for all 6 AI assistants
4. Deploy memory bank (`MEMORY.md`) for persistent context
5. Configure VSCode settings with syntax recognition
6. Install recommended VSCode extensions

### Discovery Mode (Unknown Stacks)

For projects that don't match a known stack:

```bash
ai-config --project=/path/to/project --discover --with-all
```

This will:
1. Detect 50+ technologies (React, Vue, Laravel, Django, Express, etc.)
2. Deploy base configuration for all AI assistants
3. Deploy memory and token optimization system
4. Generate a discovery prompt for AI analysis

Then open in Claude Code and run `/project-discover` to generate stack-specific rules.

### Update Existing Project

The script can auto-detect your stack from existing configuration:

```bash
ai-config --refresh --stack=custom --project=/path/to/your/project
```

Note: For `--refresh`, specify `--stack` if auto-detection fails.

## Supported Stacks

| Stack | Description |
|-------|-------------|
| `expressionengine` | ExpressionEngine 7.x CMS |
| `coilpack` | Laravel + ExpressionEngine hybrid |
| `craftcms` | Craft CMS with Twig templates |
| `wordpress-roots` | WordPress with Roots/Bedrock |
| `wordpress` | Standard WordPress |
| `nextjs` | Next.js with TypeScript |
| `docusaurus` | Docusaurus documentation sites |
| `custom` | Discovery mode for any stack |

## Common Options

| Flag | Description |
|------|-------------|
| `--stack=<name>` | Technology stack (optional - auto-detected if omitted) |
| `--project=<path>` | Target project directory (required, use `.` for current) |
| `--discover` | AI-powered discovery mode for unknown stacks |
| `--with-all` | Deploy all 6 AI assistant configurations |
| `--with-gemini` | Deploy Gemini Code Assist configuration |
| `--with-copilot` | Deploy GitHub Copilot configuration |
| `--with-cursor` | Deploy Cursor AI configuration |
| `--with-windsurf` | Deploy Windsurf AI configuration |
| `--with-codex` | Deploy OpenAI Codex configuration |
| `--install-extensions` | Auto-install VSCode extensions |
| `--refresh` | Update existing configuration (specify --stack) |
| `--dry-run` | Preview changes without applying |
| `--force` | Overwrite without prompting |
| `--clean` | Remove existing config before deploying |

## What Gets Deployed

### Claude Code (Always)
- `CLAUDE.md` - Project context and overview
- `MEMORY.md` - Persistent memory bank
- `.claude/rules/` - Stack-specific coding rules
- `.claude/rules/memory-management.md` - Memory protocols
- `.claude/rules/token-optimization.md` - Token efficiency
- `.claude/agents/` - Custom agent personas
- `.claude/commands/` - Project-specific commands
- `.claude/skills/superpowers/` - Workflow skills

### Gemini Code Assist (`--with-gemini` or `--with-all`)
- `GEMINI.md` - Agent mode context
- `.gemini/settings.json` - MCP servers and settings
- `.gemini/config.yaml` - PR review configuration
- `.gemini/commands/` - Custom Gemini commands

### GitHub Copilot (`--with-copilot` or `--with-all`)
- `.github/copilot-instructions.md` - Custom instructions

### Cursor AI (`--with-cursor` or `--with-all`)
- `.cursorrules` - Project rules for Cursor

### Windsurf AI (`--with-windsurf` or `--with-all`)
- `.windsurfrules` - Project rules for Windsurf

### OpenAI Codex (`--with-codex` or `--with-all`)
- `AGENTS.md` - Agent instructions

### VSCode
- `.vscode/settings.json` - Editor settings with syntax recognition
- `.vscode/extensions.json` - Recommended extensions
- `.vscode/launch.json` - Xdebug debugging (PHP stacks)
- `.vscode/tasks.json` - Build and DDEV tasks

## Superpowers Skills (Enabled by Default)

The deployment includes workflow skills that auto-activate:

| Skill | Purpose |
|-------|---------|
| `memory-management` | Persistent context across sessions |
| `brainstorming` | Structured idea generation |
| `writing-plans` | Implementation planning |
| `executing-plans` | Step-by-step execution |
| `systematic-debugging` | Root cause analysis |
| `test-driven-development` | TDD workflow |

Disable with `--no-superpowers`.

## Next Steps

- **[Memory System Guide](../guides/memory-system.md)** - Persistent context
- **[Setup Script Guide](../guides/setup-script.md)** - Advanced usage
- **[Configuration](configuration.md)** - Customize your setup

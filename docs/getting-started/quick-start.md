# Quick Start

Deploy Claude Code and Gemini Code Assist configurations to your project in minutes.

## Basic Deployment

### New Project Setup

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/your/project \
  --with-gemini \
  --install-extensions
```

This will:
1. Detect project technologies (Tailwind, Alpine.js, etc.)
2. Deploy CLAUDE.md and .claude/ configuration
3. Deploy GEMINI.md and .gemini/ configuration
4. Configure VSCode settings with syntax recognition
5. Install recommended VSCode extensions

### Update Existing Project

The script can auto-detect your stack from existing configuration:

```bash
./setup-project.sh \
  --refresh \
  --project=/path/to/your/project \
  --install-extensions
```

## Supported Stacks

- `expressionengine` - ExpressionEngine 7.x CMS
- `coilpack` - Laravel + ExpressionEngine hybrid
- `craftcms` - Craft CMS with Twig templates
- `wordpress-roots` - WordPress with Roots/Bedrock
- `nextjs` - Next.js with TypeScript
- `docusaurus` - Docusaurus documentation sites

## Common Options

| Flag | Description |
|------|-------------|
| `--stack=<name>` | Technology stack (auto-detected with `--refresh`) |
| `--project=<path>` | Target project directory (required) |
| `--with-gemini` | Deploy Gemini Code Assist configuration |
| `--install-extensions` | Auto-install VSCode extensions |
| `--refresh` | Update existing configuration |
| `--dry-run` | Preview changes without applying |
| `--force` | Overwrite without prompting |

## What Gets Deployed

### Claude Code Configuration
- `CLAUDE.md` - Project context and overview
- `.claude/rules/` - Stack-specific coding rules
- `.claude/agents/` - Custom agent personas
- `.claude/commands/` - Project-specific commands

### Gemini Code Assist Configuration
- `GEMINI.md` - Agent mode context
- `.gemini/settings.json` - MCP servers and settings
- `.gemini/config.yaml` - PR review configuration
- `.gemini/commands/` - Custom Gemini commands

### VSCode Configuration
- `.vscode/settings.json` - Editor settings with syntax recognition
- `.vscode/extensions.json` - Recommended extensions
- `.vscode/launch.json` - Xdebug debugging
- `.vscode/tasks.json` - DDEV tasks

## Next Steps

- **[Setup Script Guide](../guides/setup-script.md)** - Advanced usage
- **[VSCode Extensions](../guides/vscode-extensions.md)** - Extension details
- **[Configuration](configuration.md)** - Customize your setup

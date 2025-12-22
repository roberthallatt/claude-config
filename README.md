# Claude + Gemini Configuration Repository

**Automated AI configuration for modern web development stacks.**

Deploy Claude Code and Gemini Code Assist configurations with automatic technology detection, VSCode integration, and stack-specific best practices.

[![Production Ready](https://img.shields.io/badge/status-production%20ready-success)]()
[![Stacks: 6](https://img.shields.io/badge/stacks-6-blue)]()
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)]()

---

## Features

- ✅ **6 Technology Stacks** - ExpressionEngine, Craft CMS, WordPress, Next.js, Docusaurus, Coilpack
- 🔍 **Automatic Detection** - Detects Tailwind, Alpine.js, SCSS, bilingual content, and more
- 🎨 **VSCode Integration** - Syntax recognition and automatic extension installation
- 🤖 **Dual AI Support** - Configurations for both Claude Code and Gemini Code Assist
- 🔌 **MCP Servers** - ExpressionEngine MCP + Context7 library documentation
- 📦 **One Command Deploy** - Setup complete configuration in seconds
- 🔄 **Easy Updates** - Refresh configurations with auto-detection

---

## Quick Start

### Deploy to New Project

```bash
git clone https://github.com/canadian-paediatric-society/claude-config-repo.git
cd claude-config-repo

./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/your/project \
  --with-gemini \
  --install-extensions
```

### Update Existing Project

```bash
./setup-project.sh --refresh --install-extensions --project=/path/to/your/project
```

The script auto-detects your stack from existing configuration.

---

## What Gets Deployed

### Claude Code
- **CLAUDE.md** - Project context with stack references
- **.claude/rules/** - Stack-specific coding standards
- **.claude/agents/** - Specialized AI personas
- **.claude/commands/** - Project-specific commands

### Gemini Code Assist
- **GEMINI.md** - Agent mode context
- **.gemini/settings.json** - MCP server configuration
- **.gemini/commands/** - Custom Gemini commands
- **.gemini/config.yaml** - PR review settings

### VSCode
- **File associations** - Automatic syntax recognition (EE, Twig, Blade)
- **Extensions** - Recommended and auto-installed
- **Debugging** - Xdebug configuration for PHP stacks
- **Tasks** - DDEV and build tasks

---

## Supported Stacks

| Stack | CMS/Framework | Template Engine | MCP Support |
|-------|--------------|-----------------|-------------|
| **expressionengine** | ExpressionEngine 7.x | EE Templates | ✅ EE + Context7 |
| **coilpack** | Laravel + EE | Blade/Twig/EE | ✅ EE + Context7 |
| **craftcms** | Craft CMS | Twig | Context7 only |
| **wordpress-roots** | WordPress/Bedrock | Blade (Sage) | Context7 only |
| **nextjs** | Next.js 14+ | React/TSX | Context7 only |
| **docusaurus** | Docusaurus 3+ | MDX | Context7 only |

[View detailed stack information →](docs/reference/stacks.md)

---

## Documentation

### Getting Started
- **[Installation](docs/getting-started/installation.md)** - Prerequisites and setup
- **[Quick Start](docs/getting-started/quick-start.md)** - Deploy your first project
- **[Configuration](docs/getting-started/configuration.md)** - Understand the structure

### Guides
- **[Setup Script](docs/guides/setup-script.md)** - Complete setup-project.sh reference
- **[VSCode Extensions](docs/guides/vscode-extensions.md)** - Automatic extension installation
- **[Conditional Deployment](docs/guides/conditional-deployment.md)** - Technology detection
- **[Updating Projects](docs/guides/updating-projects.md)** - Refresh workflows

### Reference
- **[Stacks](docs/reference/stacks.md)** - Stack-specific details
- **[File Structure](docs/reference/file-structure.md)** - Repository organization
- **[Commands](docs/reference/commands.md)** - Available commands and skills

### Development
- **[Project Status](docs/development/project-status.md)** - Implementation status
- **[Contributing](docs/development/contributing.md)** - How to contribute

[Browse all documentation →](docs/README.md)

---

## Technology Detection

The setup script automatically detects and configures:

**Frontend Frameworks:**
- Tailwind CSS → Adds Tailwind rules and VSCode support
- Alpine.js → Adds Alpine.js rules and component builders
- Foundation → Adds Foundation patterns
- SCSS/Sass → Adds SCSS best practices

**Content Patterns:**
- Bilingual (EN/FR) → Adds bilingual content rules
- ExpressionEngine Add-ons (Stash, Structure) → Adds specialized tools

**Development Environment:**
- DDEV → Extracts project name, URL, PHP version, database config
- Template engines → Configures syntax highlighting

[Learn more about detection →](docs/guides/conditional-deployment.md)

---

## Command Reference

**Setup:**
```bash
./setup-project.sh --stack=<stack> --project=<path> [options]
```

**Options:**
- `--with-gemini` - Deploy Gemini Code Assist configuration
- `--install-extensions` - Auto-install VSCode extensions
- `--refresh` - Update existing configuration (auto-detects stack)
- `--dry-run` - Preview without applying changes
- `--force` - Overwrite without prompts

**Extension Installer:**
```bash
./install-vscode-extensions.sh /path/to/project
```

[Full command reference →](docs/guides/setup-script.md)

---

## Examples

### ExpressionEngine with DDEV

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=~/Sites/myproject \
  --with-gemini \
  --install-extensions
```

Detects: Tailwind CSS, Alpine.js, Stash, bilingual content
Deploys: EE MCP, Context7 MCP, EE templates config, VSCode extensions

### Next.js Application

```bash
./setup-project.sh \
  --stack=nextjs \
  --project=~/projects/my-nextjs-app \
  --with-gemini \
  --install-extensions
```

Detects: Tailwind CSS, TypeScript patterns
Deploys: Next.js patterns, React best practices, VSCode extensions

### Update After Adding Tailwind

```bash
# You added Tailwind to your existing project
./setup-project.sh --refresh --project=~/Sites/myproject
```

Detects: New Tailwind installation
Adds: Tailwind rules, VSCode Tailwind extension, configuration updates

---

## Requirements

- **Bash** - macOS, Linux, or WSL on Windows
- **Git** - To clone the repository
- **VSCode** (optional) - For IDE integration
- **VSCode CLI** (optional) - For automatic extension installation
- **DDEV** (optional) - For ExpressionEngine/Coilpack MCP

[Installation guide →](docs/getting-started/installation.md)

---

## VSCode Extension Installation

### Automatic (Recommended)

```bash
# During setup
./setup-project.sh --install-extensions --project=/path/to/project

# Standalone
./install-vscode-extensions.sh /path/to/project
```

### Manual

1. Open project in VSCode
2. Click "Install Recommended Extensions" notification
3. Or press `Cmd+Shift+X` → search `@recommended`

**Extensions installed per stack:**
- **ExpressionEngine:** EE syntax, Tailwind, Intelephense
- **Craft CMS:** Twig, Tailwind, Intelephense
- **WordPress:** Blade, Tailwind, WordPress Toolbox
- **Next.js:** Tailwind, ESLint, Prettier
- **Docusaurus:** Markdown, ESLint, Prettier

[Extension guide →](docs/guides/vscode-extensions.md)

---

## MCP Integration

### ExpressionEngine MCP

For ExpressionEngine and Coilpack stacks, the EE MCP server is automatically configured.

**Configuration** (in `.vscode/settings.json` and `.gemini/settings.json`):
```json
"gemini.mcpServers": {
  "expressionengine": {
    "type": "stdio",
    "command": "ddev",
    "args": ["ee", "mcp:serve"],
    "cwd": "${workspaceFolder}"
  }
}
```

**Capabilities:**
- Database queries
- Template analysis
- Add-on management
- Cache operations

### Context7 MCP

All stacks include Context7 for up-to-date library documentation.

**Provides documentation for:**
- Tailwind CSS
- Alpine.js
- React/Next.js
- Vue
- And 100+ more libraries

---

## File Structure

```
your-project/
├── CLAUDE.md                 # AI context (Claude Code)
├── GEMINI.md                 # AI context (Gemini Code Assist)
├── .claude/
│   ├── rules/                # Coding standards
│   ├── agents/               # AI personas
│   ├── commands/             # Project commands
│   └── skills/               # Knowledge modules
├── .gemini/
│   ├── settings.json         # MCP servers
│   ├── commands/             # Gemini commands
│   └── config.yaml           # PR review config
└── .vscode/
    ├── settings.json         # Editor + syntax config
    ├── extensions.json       # Extension recommendations
    ├── launch.json           # Debugging
    └── tasks.json            # Build tasks
```

[Complete file structure →](docs/reference/file-structure.md)

---

## Version Control

Add to your project's `.gitignore`:

```gitignore
# AI Configuration (project-specific)
CLAUDE.md
.claude/
GEMINI.md
.gemini/
.geminiignore

# VSCode (optional - team preference)
.vscode/
```

These files are generated and customized per-developer.

---

## Contributing

Contributions welcome! See [Contributing Guide](docs/development/contributing.md).

**Ways to contribute:**
- Report bugs or suggest features
- Improve documentation
- Add new stack support
- Enhance detection logic
- Share your configuration improvements

---

## License

MIT License - See [LICENSE](LICENSE) file for details.

---

## Support

- **Documentation:** [docs/](docs/)
- **Issues:** [GitHub Issues](https://github.com/canadian-paediatric-society/claude-config-repo/issues)
- **Status:** [Project Status](docs/development/project-status.md)

---

**Made with ❤️ for developers using Claude Code and Gemini Code Assist**

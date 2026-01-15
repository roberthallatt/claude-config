# Universal AI Coding Assistant Configuration

**Automated AI configuration for modern web development stacks.**

Deploy configurations for **7 AI coding assistants** with automatic technology detection, VSCode integration, and stack-specific best practices.

[![Production Ready](https://img.shields.io/badge/status-production%20ready-success)]()
[![AI Assistants: 7](https://img.shields.io/badge/AI%20assistants-7-purple)]()
[![Stacks: 6](https://img.shields.io/badge/stacks-6-blue)]()
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)]()

---

## Features

- ✅ **6+ Technology Stacks** - ExpressionEngine, Craft CMS, WordPress, Next.js, Docusaurus, Coilpack + custom
- 🔍 **Auto Stack Detection** - Automatically identifies your project's framework
- 🧠 **Discovery Mode** - AI-powered analysis for any stack (React, Vue, Laravel, Django, etc.)
- 🎨 **VSCode Integration** - Syntax recognition and automatic extension installation
- 🤖 **7 AI Assistants** - Claude, Gemini, Copilot, Cursor, Windsurf, Codex, Aider
- 🔌 **MCP Servers** - ExpressionEngine MCP + Context7 library documentation
- 📦 **One Command Deploy** - Setup complete configuration in seconds
- 🔄 **Easy Updates** - Refresh configurations with auto-detection
- 🌐 **Global Install** - Run from anywhere with `ai-config` command

## Supported AI Assistants

| AI Assistant | Config File | Description |
|--------------|-------------|-------------|
| **Claude Code** | `CLAUDE.md`, `.claude/` | Anthropic's AI coding assistant |
| **Gemini Code Assist** | `GEMINI.md`, `.gemini/` | Google's AI coding assistant |
| **GitHub Copilot** | `.github/copilot-instructions.md` | GitHub's AI pair programmer |
| **Cursor AI** | `.cursorrules` | AI-first code editor |
| **Windsurf AI** | `.windsurfrules` | Codeium's AI IDE |
| **OpenAI Codex** | `AGENTS.md` | OpenAI's coding agent |
| **Aider** | `CONVENTIONS.md` | Terminal-based AI pair programming |

---

## Installation

### Global Install (Recommended)

Install once, use anywhere on your system:

```bash
# Clone the repository
git clone https://github.com/canadian-paediatric-society/claude-config-repo.git ~/ai-config

# Add aliases to your shell profile (~/.zshrc or ~/.bashrc)
cat >> ~/.zshrc << 'EOF'

# AI Config - Universal AI Coding Assistant Configuration
alias ai-config="~/ai-config/setup-project.sh"
alias ai-config-docs="~/ai-config/serve-docs.sh"
EOF

# Reload your shell
source ~/.zshrc
```

Now you can run from anywhere:

```bash
ai-config --project=. --with-all    # Deploy AI configs
ai-config-docs                       # View documentation
```

### Quick Install (One-liner)

```bash
git clone https://github.com/canadian-paediatric-society/claude-config-repo.git ~/ai-config && \
echo -e '\n# AI Config\nalias ai-config="~/ai-config/setup-project.sh"\nalias ai-config-docs="~/ai-config/serve-docs.sh"' >> ~/.zshrc && \
source ~/.zshrc
```

---

## Quick Start

### Auto-Detect Stack (Recommended)

```bash
# From anywhere on your system (after global install)
ai-config --project=/path/to/your/project --with-all
```

The script automatically detects: ExpressionEngine, Craft CMS, WordPress, Next.js, Docusaurus, and more.

### Discovery Mode (Any Stack)

For projects that don't match a known stack, use discovery mode:

```bash
ai-config --project=/path/to/project --discover --with-all
```

This will:
1. Detect 50+ technologies (React, Vue, Laravel, Django, Express, etc.)
2. Deploy a base configuration for all AI assistants
3. Generate a discovery prompt for AI to analyze and customize

Then open in Claude Code and run `/project-discover` to generate stack-specific rules.

### Manual Stack Selection

```bash
# Specify a known stack
ai-config --stack=expressionengine --project=/path/to/project --with-all

# Just Claude Code (always deployed)
ai-config --stack=nextjs --project=/path/to/project
```

### Update Existing Project

```bash
ai-config --refresh --project=/path/to/your/project
```

The script auto-detects your stack from existing configuration.

### Current Directory Shortcut

```bash
# Deploy to current directory
cd /path/to/your/project
ai-config --project=. --with-all

# Discovery mode in current directory
ai-config --project=. --discover --with-all
```

---

## What Gets Deployed

### Claude Code (Always)
- **CLAUDE.md** - Project context with stack references
- **.claude/rules/** - Stack-specific coding standards
- **.claude/agents/** - Specialized AI personas
- **.claude/commands/** - Project-specific commands

### Gemini Code Assist (`--with-gemini`)
- **GEMINI.md** - Agent mode context
- **.gemini/settings.json** - MCP server configuration
- **.gemini/commands/** - Custom Gemini commands
- **.gemini/config.yaml** - PR review settings

### GitHub Copilot (`--with-copilot`)
- **.github/copilot-instructions.md** - Custom instructions for Copilot

### Cursor AI (`--with-cursor`)
- **.cursorrules** - Project rules for Cursor

### Windsurf AI (`--with-windsurf`)
- **.windsurfrules** - Project rules for Windsurf

### OpenAI Codex (`--with-codex`)
- **AGENTS.md** - Agent instructions for Codex

### Aider (`--with-aider`)
- **CONVENTIONS.md** - Coding conventions for Aider

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
- **[Setup Script](docs/guides/setup-script.md)** - Complete ai-config command reference
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

**Basic Usage:**
```bash
ai-config --project=<path> [options]
```

**Stack Options:**
| Option | Description |
|--------|-------------|
| `--project=<path>` | Target project directory (required, use `.` for current) |
| `--stack=<name>` | Specify stack (auto-detected if omitted) |
| `--discover` | AI-powered discovery mode for unknown stacks |
| `--refresh` | Update existing config (auto-detects stack) |

**AI Assistant Options:**
| Option | Description |
|--------|-------------|
| `--with-all` | Deploy ALL AI assistant configurations |
| `--with-gemini` | Deploy Gemini Code Assist |
| `--with-copilot` | Deploy GitHub Copilot |
| `--with-cursor` | Deploy Cursor AI |
| `--with-windsurf` | Deploy Windsurf AI |
| `--with-codex` | Deploy OpenAI Codex |
| `--with-aider` | Deploy Aider |

**Other Options:**
| Option | Description |
|--------|-------------|
| `--install-extensions` | Auto-install VSCode extensions |
| `--dry-run` | Preview without applying changes |
| `--force` | Overwrite without prompts |
| `--clean` | Remove existing config before deploying |
| `--skip-vscode` | Skip VSCode settings |
| `--with-mcp` | Deploy MCP server configuration |
| `--name=<n>` | Human-readable project name |
| `--slug=<slug>` | Project slug for templates |

**Extension Installer:**
```bash
~/ai-config/install-vscode-extensions.sh /path/to/project
```

[Full command reference →](docs/guides/setup-script.md)

---

## Examples

### Auto-Detect Any Project

```bash
# Let the script figure out what stack you're using
ai-config --project=~/Sites/myproject --with-all
```

### ExpressionEngine with DDEV

```bash
ai-config \
  --project=~/Sites/myproject \
  --with-all \
  --install-extensions
```

Detects: ExpressionEngine, Tailwind CSS, Alpine.js, Stash, bilingual content
Deploys: All 7 AI configs, EE MCP, VSCode extensions

### Discovery Mode for Custom Stack

```bash
# For a Vue/Nuxt project not in the known stacks
ai-config --project=~/projects/my-vue-app --discover --with-all
```

Detects: Vue.js, Nuxt, TypeScript, Tailwind, Vite, etc.
Then run `/project-discover` in Claude Code to generate custom rules.

### Current Directory

```bash
cd ~/projects/my-nextjs-app
ai-config --project=. --with-all --install-extensions
```

### Update After Adding Tailwind

```bash
# You added Tailwind to your existing project
ai-config --refresh --project=~/Sites/myproject
```

Detects: New Tailwind installation
Adds: Tailwind rules, VSCode Tailwind extension, configuration updates

### Dry Run (Preview)

```bash
# See what would be deployed without making changes
ai-config --project=. --with-all --dry-run
```

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
ai-config --install-extensions --project=/path/to/project

# Standalone
~/ai-config/install-vscode-extensions.sh /path/to/project
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
├── CLAUDE.md                 # Claude Code context
├── GEMINI.md                 # Gemini Code Assist context
├── AGENTS.md                 # OpenAI Codex instructions
├── CONVENTIONS.md            # Aider coding conventions
├── .claude/
│   ├── rules/                # Coding standards
│   ├── agents/               # AI personas
│   ├── commands/             # Project commands
│   └── skills/               # Knowledge modules
├── .gemini/
│   ├── settings.json         # MCP servers
│   ├── commands/             # Gemini commands
│   └── config.yaml           # PR review config
├── .github/
│   └── copilot-instructions.md  # GitHub Copilot instructions
├── .cursorrules              # Cursor AI rules
├── .windsurfrules            # Windsurf AI rules
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
.github/copilot-instructions.md
.cursorrules
.cursor/
.windsurfrules
.windsurf/
AGENTS.md
CONVENTIONS.md

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
- **Local Docs Server:** Run `ai-config-docs` to view docs in browser
- **Issues:** [GitHub Issues](https://github.com/canadian-paediatric-society/claude-config-repo/issues)
- **Status:** [Project Status](docs/development/project-status.md)

### View Documentation Locally

```bash
# Start the docs server (after sourcing ~/.zshrc)
ai-config-docs

# Opens at http://localhost:8000
```

---

**Made with love for developers using AI coding assistants**

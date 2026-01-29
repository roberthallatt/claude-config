# AI Config

**One command to configure AI coding assistants for any project.**

```bash
ai-config --project=/path/to/your/project --with-all
```

Auto-detects your framework, deploys configurations for 6 AI assistants, and sets up VSCode.

[![Production Ready](https://img.shields.io/badge/status-production%20ready-success)]()
[![AI Assistants: 6](https://img.shields.io/badge/AI%20assistants-6-purple)]()
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)]()

---

## Quick Install

```bash
# Clone and install (one command)
git clone https://github.com/canadian-paediatric-society/claude-config-repo.git ~/.ai-config && \
~/.ai-config/install.sh
```

Now use `ai-config` from anywhere on your system.

<details>
<summary><strong>Manual Installation</strong></summary>

```bash
# Clone to your preferred location
git clone https://github.com/canadian-paediatric-society/claude-config-repo.git ~/path/to/ai-config

# Make scripts executable
chmod +x ~/path/to/ai-config/setup-project.sh
chmod +x ~/path/to/ai-config/serve-docs.sh

# Add to ~/.zshrc or ~/.bashrc
export AI_CONFIG_REPO="$HOME/path/to/ai-config"
alias ai-config="$AI_CONFIG_REPO/setup-project.sh"
alias ai-config-docs="$AI_CONFIG_REPO/serve-docs.sh"

# Reload shell
source ~/.zshrc
```

</details>

---

## Usage

### Configure Any Project

```bash
ai-config --project=/path/to/project --with-all
```

The script automatically:
- **Detects your framework** (WordPress, Next.js, Craft CMS, ExpressionEngine, etc.)
- **Detects technologies** (Tailwind, Alpine.js, SCSS, bilingual content, etc.)
- **Deploys optimized configurations** for all 6 AI assistants
- **Sets up VSCode** with syntax highlighting, debugging, and tasks

### Current Directory Shortcut

```bash
cd /path/to/project
ai-config --project=. --with-all
```

### Update Existing Project

```bash
ai-config --refresh --project=/path/to/project
```

Re-scans for new technologies and updates all configurations.

### Discovery Mode (Unknown Stacks)

For projects that don't match a known framework:

```bash
ai-config --project=/path/to/project --discover --with-all
```

This detects 50+ technologies (React, Vue, Laravel, Django, etc.), deploys base configurations, and generates a discovery prompt. Then run `/project-discover` in Claude Code to generate custom rules.

---

## What Gets Deployed

### AI Assistants

| Assistant | Config Files | Flag |
|-----------|--------------|------|
| **Claude Code** | `CLAUDE.md`, `MEMORY.md`, `.claude/` | Always deployed |
| **Gemini Code Assist** | `GEMINI.md`, `.gemini/` | `--with-gemini` |
| **GitHub Copilot** | `.github/copilot-instructions.md` | `--with-copilot` |
| **Cursor AI** | `.cursorrules` | `--with-cursor` |
| **Windsurf AI** | `.windsurfrules` | `--with-windsurf` |
| **OpenAI Codex** | `AGENTS.md` | `--with-codex` |

Use `--with-all` to deploy all assistants at once.

### Additional Features

- **Memory Bank** (`MEMORY.md`) - Persistent context across sessions
- **Superpowers Skills** - Workflow automation (planning, debugging, TDD)
- **VSCode Settings** - Syntax highlighting, Xdebug, DDEV tasks
- **MCP Integration** - ExpressionEngine MCP + Context7 library docs

---

## Auto-Detection

### Frameworks

| Framework | Detection |
|-----------|-----------|
| ExpressionEngine 7.x | `system/ee/` directory |
| Craft CMS | `craft` executable |
| WordPress (Roots/Bedrock) | `web/app/themes/` structure |
| WordPress | `wp-config.php` |
| Next.js 14+ | `next.config.js` or `.mjs` |
| Docusaurus 3+ | `docusaurus.config.js` |
| Coilpack (Laravel + EE) | Laravel + ExpressionEngine structure |

### Technologies

| Technology | Detection | Result |
|------------|-----------|--------|
| Tailwind CSS | `tailwind.config.*` or package.json | Adds Tailwind rules + VSCode support |
| Alpine.js | `x-data` attributes or package.json | Adds Alpine.js rules |
| Foundation | `foundation-sites` in package.json | Adds Foundation patterns |
| SCSS/Sass | `.scss` files or package.json | Adds SCSS best practices |
| Bilingual (EN/FR) | Language patterns in templates | Adds bilingual content rules |
| Stash (EE) | `exp:stash` tags | Adds Stash optimization tools |

---

## Command Reference

```bash
ai-config --project=<path> [options]
```

### Required

| Option | Description |
|--------|-------------|
| `--project=<path>` | Target directory (use `.` for current) |

### Deployment Options

| Option | Description |
|--------|-------------|
| `--with-all` | Deploy all 6 AI assistant configurations |
| `--with-gemini` | Deploy Gemini Code Assist |
| `--with-copilot` | Deploy GitHub Copilot |
| `--with-cursor` | Deploy Cursor AI |
| `--with-windsurf` | Deploy Windsurf AI |
| `--with-codex` | Deploy OpenAI Codex |

### Stack Options

| Option | Description |
|--------|-------------|
| `--stack=<name>` | Manually specify stack (auto-detected if omitted) |
| `--discover` | Discovery mode for unknown frameworks |

### Update Options

| Option | Description |
|--------|-------------|
| `--refresh` | Update existing configuration |
| `--force` | Overwrite without prompts |
| `--clean` | Remove existing config before deploying |

### Other Options

| Option | Description |
|--------|-------------|
| `--dry-run` | Preview without making changes |
| `--skip-vscode` | Skip VSCode settings deployment |
| `--with-mcp` | Deploy standalone `.mcp.json` |
| `--install-extensions` | Auto-install VSCode extensions |
| `--no-superpowers` | Disable Superpowers workflow skills |
| `--name=<name>` | Set project name (auto-detected from directory) |

### Available Stacks

`expressionengine`, `coilpack`, `craftcms`, `wordpress-roots`, `wordpress`, `nextjs`, `docusaurus`, `custom`

---

## Examples

```bash
# Auto-detect and configure with all AI assistants
ai-config --project=. --with-all

# Preview what would be deployed
ai-config --project=. --with-all --dry-run

# Update after adding Tailwind
ai-config --refresh --project=.

# Discovery mode for a Vue/Nuxt project
ai-config --project=~/my-vue-app --discover --with-all

# Just Claude and Gemini
ai-config --project=. --with-gemini

# Force clean reinstall
ai-config --project=. --with-all --clean --force

# Manually specify stack
ai-config --stack=craftcms --project=. --with-all
```

---

## VSCode Integration

### Automatic Extension Installation

```bash
ai-config --project=. --with-all --install-extensions
```

Or run standalone:
```bash
~/.ai-config/install-vscode-extensions.sh /path/to/project
```

### Extensions by Stack

| Stack | Extensions |
|-------|------------|
| ExpressionEngine | EE syntax, Tailwind, Intelephense, Xdebug |
| Craft CMS | Twig, Tailwind, Intelephense |
| WordPress | Blade, Tailwind, WordPress Toolbox |
| Next.js | Tailwind, ESLint, Prettier |

---

## MCP Integration

### ExpressionEngine MCP

Automatically configured for ExpressionEngine and Coilpack stacks:

```json
{
  "expressionengine": {
    "command": "ddev",
    "args": ["ee", "mcp:serve"]
  }
}
```

Provides: Database queries, template analysis, add-on management, cache operations.

### Context7 MCP

All stacks include Context7 for up-to-date library documentation (Tailwind, Alpine.js, React, Vue, 100+ more).

---

## File Structure

After running `ai-config --project=. --with-all`:

```
your-project/
├── CLAUDE.md                     # Claude Code context
├── MEMORY.md                     # Persistent memory bank
├── GEMINI.md                     # Gemini context
├── AGENTS.md                     # OpenAI Codex instructions
├── .claude/
│   ├── rules/                    # Coding standards
│   ├── agents/                   # AI personas
│   ├── commands/                 # Slash commands
│   ├── skills/superpowers/       # Workflow skills
│   └── hooks/                    # Session hooks
├── .gemini/
│   ├── settings.json             # MCP servers
│   ├── config.yaml               # PR review config
│   └── commands/                 # Gemini commands
├── .github/
│   └── copilot-instructions.md
├── .cursorrules
├── .windsurfrules
└── .vscode/
    ├── settings.json
    ├── launch.json
    └── tasks.json
```

---

## Add to .gitignore

These files are per-developer and shouldn't be committed:

```gitignore
# AI Configuration
CLAUDE.md
MEMORY.md
MEMORY-ARCHIVE.md
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
```

---

## Documentation

| Guide | Description |
|-------|-------------|
| [Installation](docs/getting-started/installation.md) | Manual setup options |
| [Quick Start](docs/getting-started/quick-start.md) | First-run guide |
| [Memory System](docs/guides/memory-system.md) | Persistent context |
| [Setup Script](docs/guides/setup-script.md) | Complete reference |
| [Conditional Deployment](docs/guides/conditional-deployment.md) | Detection logic |
| [Updating Projects](docs/guides/updating-projects.md) | Refresh workflows |
| [Stacks Reference](docs/reference/stacks.md) | Stack-specific details |

**Start docs server locally:**
```bash
ai-config-docs  # Opens http://localhost:8000
```

---

## Requirements

- **Bash** - macOS, Linux, or WSL on Windows
- **Git** - To clone the repository
- **VSCode** (optional) - For IDE integration
- **VSCode CLI** (optional) - For automatic extension installation (`code` command)
- **DDEV** (optional) - For ExpressionEngine/Coilpack MCP servers

---

## Contributing

Contributions welcome! See [Contributing Guide](docs/development/contributing.md).

- Report bugs or suggest features
- Improve documentation
- Add new stack support
- Enhance detection logic

---

## License

MIT License - See [LICENSE](LICENSE) file.

---

## Support

- **Documentation:** Run `ai-config-docs` or browse [docs/](docs/)
- **Issues:** [GitHub Issues](https://github.com/canadian-paediatric-society/claude-config-repo/issues)
- **Status:** [Project Status](docs/development/project-status.md)

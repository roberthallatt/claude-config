# Claude Code Configuration System

A standardized configuration deployment system for Claude Code and AI-assisted development across Canadian Paediatric Society projects.

## Overview

This repository provides:

1. **Global Configurations** — Shared coding standards, stack knowledge, and library references installed to `~/.claude/`
2. **Project Templates** — Complete per-project configurations with agents, commands, rules, and skills
3. **Automated Deployment** — A setup script that auto-detects project settings and deploys customized configurations
4. **MCP Integration** — Model Context Protocol servers for ExpressionEngine and Context7 documentation

The system supports multiple tech stacks (ExpressionEngine, Craft CMS, WordPress, Next.js, Docusaurus) while maintaining consistent development standards across all projects.

---

## Repository Structure

```
claude-config-repo/
├── install.sh                    # Installs global configs to ~/.claude/
├── setup-project.sh              # Deploys project-specific configs
├── README.md
│
├── global/                       # Global configuration files
│   └── CLAUDE.md                 # Universal coding preferences
│
├── stacks/                       # Stack-specific knowledge
│   ├── craftcms.md               # Craft CMS 5.x + Twig
│   ├── expressionengine.md       # ExpressionEngine 7.x
│   ├── nextjs.md                 # Next.js 14+ App Router
│   └── wordpress-roots.md        # Bedrock + Sage + Blade
│
├── libraries/                    # Library/framework references
│   ├── alpinejs.md               # Alpine.js patterns
│   ├── foundation.md             # Zurb Foundation 6.x
│   ├── html5.md                  # HTML5 semantics + a11y
│   ├── scss.md                   # SCSS/Sass conventions
│   ├── tailwind.md               # Tailwind CSS utilities
│   └── vanilla-js.md             # Modern vanilla JS
│
└── projects/                     # Project templates (per-stack)
    ├── expressionengine/         # EE 7.x complete config
    │   ├── CLAUDE.md.template    # Template with variables
    │   ├── .mcp.json             # MCP server config
    │   ├── settings.local.json   # Claude permissions
    │   ├── .vscode/              # VSCode settings
    │   │   ├── settings.json     # Editor + Emmet for EE
    │   │   ├── launch.json       # Xdebug configuration
    │   │   ├── tasks.json        # DDEV tasks
    │   │   └── tailwind.json     # Tailwind IntelliSense
    │   ├── agents/               # AI agent personas
    │   │   ├── ee-template-expert.md
    │   │   ├── frontend-architect.md
    │   │   └── performance-auditor.md
    │   ├── commands/             # Slash commands
    │   │   ├── alpine-component-gen.md
    │   │   ├── ddev-helper.md
    │   │   ├── ee-check-syntax.md
    │   │   ├── ee-template-scaffold.md
    │   │   ├── project-analyze.md
    │   │   ├── stash-optimize.md
    │   │   └── tailwind-build.md
    │   ├── rules/                # Always-on constraints
    │   │   ├── accessibility.md
    │   │   ├── alpinejs.md
    │   │   ├── bilingual-content.md
    │   │   ├── expressionengine-templates.md
    │   │   ├── mcp-workflow.md
    │   │   ├── performance.md
    │   │   └── tailwind-css.md
    │   └── skills/               # Knowledge modules
    │       ├── alpine-component-builder/
    │       ├── ee-stash-optimizer/
    │       ├── ee-template-assistant/
    │       └── tailwind-utility-finder/
    │
    ├── craftcms/                 # Craft CMS template (skeleton)
    ├── wordpress-roots/          # WordPress Bedrock template (skeleton)
    ├── nextjs/                   # Next.js template (skeleton)
    └── docusaurus/               # Docusaurus template (skeleton)
```

---

## How It Works

### 1. Global Installation (One-Time)

Install shared configurations to `~/.claude/`:

```bash
# One-liner
curl -fsSL https://raw.githubusercontent.com/canadian-paediatric-society/claude-config-repo/main/install.sh | bash

# Or clone and install
git clone https://github.com/canadian-paediatric-society/claude-config-repo.git ~/.claude-config
cd ~/.claude-config && ./install.sh
```

This creates:
```
~/.claude/
├── CLAUDE.md              # Global coding preferences
├── stacks/                # Stack knowledge files
└── libraries/             # Library reference files
```

### 2. Project Deployment

Deploy a complete configuration to any project:

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/project \
  --with-mcp
```

The script:
1. **Scans** the project for DDEV config, templates, Tailwind, add-ons
2. **Detects** PHP version, database, URLs, template groups
3. **Generates** CLAUDE.md with project-specific values
4. **Deploys** agents, commands, rules, skills, VSCode settings
5. **Creates** MCP configuration (if `--with-mcp`)

### 3. What Gets Deployed to Projects

```
project/
├── CLAUDE.md                 # Main AI instructions (auto-generated)
├── AGENTS.md → CLAUDE.md     # Symlink for Gemini/other AI
├── .mcp.json                 # MCP servers (with --with-mcp)
│
├── .vscode/                  # VSCode settings
│   ├── settings.json         # Editor + Emmet for EE templates
│   ├── launch.json           # Xdebug with DDEV path mappings
│   ├── tasks.json            # DDEV Xdebug on/off tasks
│   └── tailwind.json         # Tailwind CSS IntelliSense
│
└── .claude/                  # Claude Code configuration
    ├── settings.local.json   # Permissions config
    ├── agents/               # 3 specialized AI agents
    ├── commands/             # 7 slash commands
    ├── rules/                # 7 always-on constraint rules
    └── skills/               # 4 knowledge modules
```

---

## Setup Script Options

```bash
./setup-project.sh [options]
```

| Flag | Description |
|------|-------------|
| `--stack=<name>` | Stack template to use (required) |
| `--project=<path>` | Target project directory (required) |
| `--name="Name"` | Human-readable project name |
| `--slug=slug` | Project slug for templates |
| `--dry-run` | Preview changes without applying |
| `--force` | Overwrite existing config without prompting |
| `--clean` | Remove existing config before deploying |
| `--refresh` | Re-scan and regenerate CLAUDE.md only (preserves .claude/) |
| `--skip-vscode` | Don't copy VSCode settings |
| `--with-mcp` | Deploy MCP configuration (EE + Context7) |
| `--analyze` | Generate analysis prompt for Claude |

### Available Stacks

| Stack | Description |
|-------|-------------|
| `expressionengine` | EE 7.x + DDEV + Tailwind + Stash |
| `craftcms` | Craft CMS 5.x + Twig (template) |
| `wordpress-roots` | Bedrock + Sage + Blade (template) |
| `nextjs` | Next.js 14+ App Router (template) |
| `docusaurus` | Docusaurus + React (template) |

---

## Auto-Detection

The setup script automatically detects from `.ddev/config.yaml`:

| Setting | Detection |
|---------|-----------|
| **DDEV Name** | `name:` field |
| **Docroot** | `docroot:` field |
| **PHP Version** | `php_version:` field |
| **Database** | `database.type:` + `database.version:` |
| **TLD** | `project_tld:` field (default: `ddev.site`) |
| **Primary URL** | `additional_fqdns:` matching DDEV name, or `{name}.{tld}` |
| **Template Group** | First non-underscore directory in `system/user/templates/` |
| **Tailwind** | Presence of `tailwind.config.js` |
| **Stash Add-on** | Presence of `system/user/addons/stash/` |

### Template Variables

The CLAUDE.md.template uses these auto-detected variables:

| Variable | Example Value |
|----------|---------------|
| `{{PROJECT_NAME}}` | `cpsp` |
| `{{PROJECT_SLUG}}` | `cpsp` |
| `{{DDEV_NAME}}` | `cpsp` |
| `{{DDEV_DOCROOT}}` | `public` |
| `{{DDEV_PHP}}` | `8.2` |
| `{{DDEV_DB_TYPE}}` | `MariaDB` |
| `{{DDEV_DB_VERSION}}` | `10.11` |
| `{{DDEV_TLD}}` | `cps.test` |
| `{{DDEV_PRIMARY_URL}}` | `https://www.cpsp.cps.test` |
| `{{TEMPLATE_GROUP}}` | `cpsp` |

---

## MCP Integration

With `--with-mcp`, the script deploys `.mcp.json`:

```json
{
  "mcpServers": {
    "expressionengine": {
      "type": "stdio",
      "command": "ddev",
      "args": ["ee", "mcp:serve"]
    },
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

### ExpressionEngine MCP Tools

| Tool | Description |
|------|-------------|
| `database_query` | Execute read-only SQL queries |
| `database_schema` | Get database schema information |
| `clear_cache` | Clear EE caches |
| `backup_database` | Backup the database |
| `eecli` | Execute EE CLI commands |
| `get_field_template_tags` | Get field template tag info |

### ExpressionEngine MCP Resources

| Resource | Description |
|----------|-------------|
| `ee://channels` | Access channel information |
| `ee://channels/{id}` | Get specific channel |
| `ee://fields` | Access custom fields |
| `ee://templates` | Access templates |
| `ee://system/info` | System information |

### Context7 Usage

For up-to-date library documentation:

```
1. resolve-library-id("tailwindcss")
   → Returns: /tailwindcss/tailwindcss

2. get-library-docs("/tailwindcss/tailwindcss", topic="configuration")
   → Returns: Current documentation
```

---

## Common Workflows

### New Project Setup

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/project \
  --with-mcp \
  --clean
```

Then in Claude Code: `/project-analyze`

### Refresh After DDEV Changes

Changed PHP version or database? Refresh CLAUDE.md:

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/project \
  --refresh
```

### Add MCP to Existing Project

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/project \
  --refresh \
  --with-mcp
```

### Preview Changes (Dry Run)

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/project \
  --dry-run
```

---

## Gitignore Setup

Add to each project's `.gitignore`:

```gitignore
# Claude Code / AI configuration (local dev only)
CLAUDE.md
AGENTS.md
.claude/
```

---

## CPS Project Status

| Project | Stack | Status | URL |
|---------|-------|--------|-----|
| cyntc | ExpressionEngine | ✅ Gold Standard | `https://www.kidsnewtocanada.test` |
| cpsp | ExpressionEngine | ✅ Configured | `https://www.cpsp.cps.test` |
| cps | ExpressionEngine | ✅ Configured | `https://www.cps.test` |
| cfk | ExpressionEngine | ⏳ Pending | |
| diabetes | Laravel + Coilpack | ⏳ Pending | |
| healthy-screen-use | Craft CMS | ⏳ Pending | |
| docs | Docusaurus | ⏳ Pending | |
| membercentre | WordPress Bedrock | ⏳ Pending | |
| intranet-frontend | Next.js | ⏳ Pending | |
| intranet-backend | Laravel | ⏳ Pending | |

---

## Team Onboarding

Add to your project README:

```markdown
## Claude Code Setup

1. Install global configs (one-time):
   ```bash
   curl -fsSL https://raw.githubusercontent.com/canadian-paediatric-society/claude-config-repo/main/install.sh | bash
   ```

2. Deploy project configuration:
   ```bash
   cd ~/.claude-config
   ./setup-project.sh --stack=expressionengine --project=/path/to/this/project --with-mcp
   ```

3. Restart Claude Code to activate MCP tools

4. Run `/project-analyze` for project-specific customization
```

---

## Updating

```bash
# Pull latest and reinstall globals
cd ~/.claude-config && git pull && ./install.sh

# Refresh project configs
./setup-project.sh --stack=expressionengine --project=/path/to/project --refresh
```

---

## License

MIT — Use and modify freely.

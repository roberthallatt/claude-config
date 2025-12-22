# File Structure

Complete reference for the configuration repository structure.

## Repository Structure

```
claude-config-repo/
├── setup-project.sh              # Main deployment script
├── install-vscode-extensions.sh  # Extension installer
├── README.md                     # Overview and quick links
├── CLAUDE.md                     # Repository context
│
├── docs/                         # Documentation
│   ├── getting-started/
│   ├── guides/
│   ├── reference/
│   └── development/
│
├── global/                       # Global configs (legacy)
│   └── CLAUDE.md
│
├── stacks/                       # Stack knowledge (legacy)
│   ├── expressionengine.md
│   ├── craftcms.md
│   └── ...
│
├── libraries/                    # Library references (legacy)
│   ├── tailwind.md
│   ├── alpinejs.md
│   └── ...
│
└── projects/                     # Stack templates
    ├── expressionengine/
    ├── coilpack/
    ├── craftcms/
    ├── wordpress-roots/
    ├── nextjs/
    └── docusaurus/
```

## Project Template Structure

Each stack in `projects/{stack}/` contains:

```
projects/expressionengine/
├── CLAUDE.md.template            # Project context template
├── GEMINI.md.template            # Gemini context template
│
├── .claude/                      # Claude configuration
│   ├── rules/                    # Coding rules
│   │   ├── accessibility.md
│   │   ├── expressionengine-templates.md
│   │   ├── performance.md
│   │   ├── tailwind-css.md       # Conditional
│   │   ├── alpinejs.md           # Conditional
│   │   └── bilingual-content.md  # Conditional
│   │
│   ├── agents/                   # Agent personas
│   │   ├── code-quality-specialist.md
│   │   └── security-expert.md
│   │
│   ├── commands/                 # Slash commands
│   │   ├── project-analyze.md
│   │   └── sync-configs.md
│   │
│   └── skills/                   # Knowledge modules
│       ├── alpine-component-builder/
│       ├── ee-stash-optimizer/
│       ├── ee-template-assistant/
│       └── tailwind-utility-finder/
│
├── .gemini/                      # Gemini configuration
│   ├── settings.json.template    # MCP servers
│   ├── config.yaml               # PR review config
│   ├── styleguide.md             # Code review guide
│   │
│   └── commands/                 # Gemini commands (TOML)
│       ├── project-analyze.toml
│       └── config-sync.toml
│
└── .vscode/                      # VSCode configuration
    ├── settings.json             # Editor settings
    ├── extensions.json           # Extension recommendations
    ├── launch.json               # Debug config
    ├── tasks.json                # Tasks
    └── tailwind.json             # Tailwind IntelliSense
```

## Deployed Project Structure

After running `setup-project.sh`, your project will have:

```
your-project/
├── CLAUDE.md                     # Generated from template
├── GEMINI.md                     # If --with-gemini used
│
├── .claude/
│   ├── rules/
│   ├── agents/
│   ├── commands/
│   └── skills/                   # If stack has skills
│
├── .gemini/                      # If --with-gemini used
│   ├── settings.json
│   ├── config.yaml
│   ├── styleguide.md
│   └── commands/
│
├── .vscode/                      # If not --skip-vscode
│   ├── settings.json
│   ├── extensions.json
│   ├── launch.json
│   ├── tasks.json
│   └── tailwind.json
│
├── .mcp.json                     # If --with-mcp used (rare)
├── .geminiignore                 # If --with-gemini used
│
└── (your existing project files)
```

## File Types

### Templates (.template)

Files with `.template` extension contain template variables that get replaced during deployment.

**Variables:**
- `{{PROJECT_NAME}}` - Human-readable project name
- `{{PROJECT_SLUG}}` - URL-safe identifier
- `{{PROJECT_PATH}}` - Absolute path to project
- `{{DDEV_NAME}}` - DDEV project name
- `{{DDEV_PRIMARY_URL}}` - Primary URL
- `{{DDEV_DOCROOT}}` - Document root
- `{{DDEV_PHP}}` - PHP version
- `{{DDEV_DB_TYPE}}` - Database type
- `{{DDEV_DB_VERSION}}` - Database version

### Markdown (.md)

Documentation and configuration files:
- `CLAUDE.md` - Project context
- `GEMINI.md` - Agent mode context
- Rules, agents, commands, skills

### JSON

Configuration files:
- `.vscode/settings.json` - VSCode settings
- `.vscode/extensions.json` - Extension recommendations
- `.gemini/settings.json` - MCP servers
- `.mcp.json` - Standalone MCP config

### YAML

Configuration files:
- `.gemini/config.yaml` - Gemini PR review settings

### TOML

Gemini command definitions:
- `.gemini/commands/*.toml`

## File Permissions

Scripts should be executable:
```bash
chmod +x setup-project.sh
chmod +x install-vscode-extensions.sh
```

## Ignored Files

Recommended `.gitignore` for projects:

```gitignore
# AI Configuration (project-specific, not committed)
CLAUDE.md
.claude/
GEMINI.md
.gemini/
.geminiignore

# VSCode (optional - some teams commit these)
.vscode/
```

Configuration repository `.gitignore`:

```gitignore
# OS
.DS_Store
Thumbs.db

# Editors
*.swp
*.swo
*~

# Test projects
test-*/
```

## Legacy Directories

### global/

Contains `CLAUDE.md` with universal coding preferences. Previously installed to `~/.claude/`.

**Status:** Deprecated - not currently used by setup script.

### stacks/

Stack-specific knowledge files (e.g., `expressionengine.md`).

**Status:** Referenced in deployed `CLAUDE.md` via:
```markdown
@~/.claude/stacks/expressionengine.md
```

But installation step is not included in current workflow.

### libraries/

Framework/library reference files (e.g., `tailwind.md`, `alpinejs.md`).

**Status:** Referenced but not actively installed.

## File Naming Conventions

- **Templates:** `{filename}.template`
- **Rules:** `kebab-case.md` (e.g., `expressionengine-templates.md`)
- **Agents:** `kebab-case.md` (e.g., `code-quality-specialist.md`)
- **Commands:** `kebab-case.md` or `.toml`
- **Skills:** `kebab-case/` directory with `skill.json`
- **VSCode:** Standard VSCode naming

## Next Steps

- **[Stacks Reference](stacks.md)** - Stack-specific details
- **[Configuration](../getting-started/configuration.md)** - Configuration guide
- **[Commands Reference](commands.md)** - Available commands

# File Structure

Complete reference for the configuration repository structure.

## Repository Structure

```
claude-config/
├── setup-project.sh              # Main deployment script
├── serve-docs.sh                 # Documentation server
├── README.md                     # Overview and quick links
├── CLAUDE.md                     # Repository context for Claude
│
├── docs/                         # Documentation
│   ├── getting-started/
│   ├── guides/
│   ├── reference/
│   └── development/
│
├── superpowers/                  # Workflow skills system
│   ├── skills/                   # All available skills
│   │   ├── memory-management/
│   │   ├── brainstorming/
│   │   ├── writing-plans/
│   │   ├── executing-plans/
│   │   ├── systematic-debugging/
│   │   ├── test-driven-development/
│   │   └── ...
│   ├── commands/                 # Slash commands
│   └── hooks/                    # Session hooks
│
└── projects/                     # Stack templates
    ├── common/                   # Global fallback templates
    │   ├── copilot/
    │   ├── openai/
    │   ├── rules/                # Common rules
    │   │   ├── memory-management.md
    │   │   └── token-optimization.md
    │   └── MEMORY.md.template    # Memory bank template
    ├── expressionengine/
    ├── coilpack/
    ├── craftcms/
    ├── wordpress-roots/
    ├── wordpress/
    ├── nextjs/
    ├── docusaurus/
    └── custom/
```

## Common Fallback Templates

The `projects/common/` directory contains global fallback templates used when a stack doesn't have its own template.

```
projects/common/
├── copilot/
│   └── copilot-instructions.md.template
├── openai/
│   └── .template
├── rules/
│   ├── memory-management.md      # Memory protocols
│   └── token-optimization.md     # Token efficiency
└── MEMORY.md.template            # Project memory bank
```

**Fallback priority:**
1. Stack-specific template (e.g., `projects/expressionengine/copilot/`)
2. Common fallback (e.g., `projects/common/copilot/`)

## Superpowers Skills Structure

```
superpowers/
├── skills/
│   ├── memory-management/
│   │   └── SKILL.md
│   ├── brainstorming/
│   │   └── SKILL.md
│   ├── writing-plans/
│   │   └── SKILL.md
│   ├── executing-plans/
│   │   └── SKILL.md
│   ├── systematic-debugging/
│   │   └── SKILL.md
│   ├── test-driven-development/
│   │   └── SKILL.md
│   ├── dispatching-parallel-agents/
│   │   └── SKILL.md
│   └── using-superpowers/
│       └── SKILL.md
├── commands/
│   ├── brainstorm.md
│   ├── write-plan.md
│   └── execute-plan.md
└── hooks/
    ├── hooks.json.template
    └── session-start.sh
```

## Project Template Structure

Each stack in `projects/{stack}/` contains:

```
projects/expressionengine/
├── CLAUDE.md.template            # Project context template
├── .template            # Gemini context template
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
├──                       # Gemini configuration
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
    ├── launch.json               # Debug config
    └── tasks.json                # Tasks
```

## Deployed Project Structure

After running `ai-config --project=. `, your project will have:

```
your-project/
├── CLAUDE.md                     # Generated from template
├── MEMORY.md                     # Persistent memory bank
├──                      # If  or 
├──                      # If  or 
│
├── .claude/
│   ├── rules/
│   │   ├── memory-management.md  # Memory protocols
│   │   ├── token-optimization.md # Token efficiency
│   │   └── ...                   # Stack-specific rules
│   ├── agents/
│   ├── commands/
│   │   ├── brainstorm.md         # Superpowers commands
│   │   ├── write-plan.md
│   │   └── execute-plan.md
│   ├── skills/
│   │   └── superpowers/          # Workflow skills
│   │       ├── memory-management/
│   │       ├── brainstorming/
│   │       ├── writing-plans/
│   │       └── ...
│   └── hooks/                    # Session hooks
│       ├── hooks.json
│       └── session-start.sh
│
├──                       # If  or 
│   ├── settings.json
│   ├── config.yaml
│   ├── styleguide.md
│   └── commands/
│
├── .github/                      # If  or 
│   └── copilot-instructions.md
│
├── .vscode/                      # If not --skip-vscode
│   ├── settings.json
│   ├── launch.json
│   └── tasks.json
│
├── .geminiignore                 # If  or 
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
- `{{STACK}}` - Detected or specified stack name
- `{{DDEV_NAME}}` - DDEV project name
- `{{DDEV_PRIMARY_URL}}` - Primary URL
- `{{DDEV_DOCROOT}}` - Document root
- `{{DDEV_PHP}}` - PHP version
- `{{DDEV_DB_TYPE}}` - Database type
- `{{DDEV_DB_VERSION}}` - Database version

### Markdown (.md)

Documentation and configuration files:
- `CLAUDE.md` - Project context
- `MEMORY.md` - Persistent memory bank
- `` - Agent mode context
- Rules, agents, commands, skills

### JSON

Configuration files:
- `.vscode/settings.json` - VSCode settings
- `settings.json` - Gemini settings
- `.claude/hooks/hooks.json` - Session hooks

### YAML

Configuration files:
- `config.yaml` - Gemini PR review settings

### TOML

Gemini command definitions:
- `commands/*.toml`

## File Permissions

Scripts should be executable:
```bash
chmod +x setup-project.sh
chmod +x serve-docs.sh
chmod +x .claude/hooks/session-start.sh
```

## Ignored Files

Recommended `.gitignore` for projects:

```gitignore
# AI Configuration (project-specific, not committed)
CLAUDE.md
MEMORY.md
MEMORY-ARCHIVE.md
.claude/


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

## File Naming Conventions

- **Templates:** `{filename}.template`
- **Rules:** `kebab-case.md` (e.g., `memory-management.md`)
- **Agents:** `kebab-case.md` (e.g., `code-quality-specialist.md`)
- **Commands:** `kebab-case.md` or `.toml`
- **Skills:** `kebab-case/` directory with `SKILL.md`
- **VSCode:** Standard VSCode naming

## Next Steps

- **[Stacks Reference](stacks.md)** - Stack-specific details
- **[Memory System](../guides/memory-system.md)** - Memory bank guide
- **[Commands Reference](commands.md)** - Available commands

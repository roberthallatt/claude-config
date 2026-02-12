# Configuration

Understanding the Claude Code configuration structure.

## Configuration Files

### CLAUDE.md

Main project context file for Claude Code. Contains:
- Project overview and description
- Technology stack references
- Available commands and workflows
- Custom instructions

**Location:** `{project-root}/CLAUDE.md`

**Generated from:** `projects/{stack}/CLAUDE.md.template`

### .claude/ Directory

Detailed configuration and rules:

```
.claude/
├── rules/              # Stack-specific rules
│   ├── accessibility.md
│   ├── tailwind-css.md
│   ├── performance.md
│   └── ...
├── agents/             # Custom agent personas
│   ├── code-quality-specialist.md
│   └── security-expert.md
└── commands/           # Project-specific commands
    ├── project-analyze.md
    └── ...
```


### .vscode/ Directory

VSCode IDE configuration:

```
.vscode/
├── settings.json       # Editor settings + file associations
├── launch.json         # Debug configuration
└── tasks.json          # Build/run tasks
```

## Template Variables

Templates support variable substitution:

| Variable | Description | Example |
|----------|-------------|---------|
| `{{PROJECT_NAME}}` | Human-readable name | "My Project" |
| `{{PROJECT_SLUG}}` | URL-safe identifier | "my-project" |
| `{{PROJECT_PATH}}` | Absolute path | "/Users/dev/project" |
| `{{DDEV_NAME}}` | DDEV project name | "myproject" |
| `{{DDEV_PRIMARY_URL}}` | Primary URL | "https://myproject.ddev.site" |

## Conditional Deployment

Rules and configurations are deployed based on detected technologies:

### Always Deployed
- `accessibility.md`
- `performance.md`
- Base stack rules (EE templates, Craft templates, etc.)

### Conditionally Deployed
- `tailwind-css.md` - When Tailwind CSS detected
- `alpinejs.md` - When Alpine.js detected
- `bilingual-content.md` - When French/English patterns detected
- Stack-specific add-ons (Stash, Structure for EE)

See **[Conditional Deployment Guide](../guides/conditional-deployment.md)** for detection logic.

## Customization

### Modifying Templates

1. Edit templates in `projects/{stack}/`
2. Test changes with `--dry-run`
3. Re-deploy to projects

### Project-Specific Rules

Add custom rules to `.claude/rules/` in your project. They won't be overwritten by `--refresh`.

### Version Control

**Recommended .gitignore:**
```
# Claude Code
CLAUDE.md
MEMORY.md
MEMORY-ARCHIVE.md
.claude/

# Other AI Assistants


```

These files are project-specific and shouldn't be committed. See [File Structure](../reference/file-structure.md#ignored-files) for complete details.

## Next Steps

- **[Conditional Deployment](../guides/conditional-deployment.md)** - How detection works
- **[Updating Projects](../guides/updating-projects.md)** - Refresh workflows
- **[Stacks Reference](../reference/stacks.md)** - Stack-specific details

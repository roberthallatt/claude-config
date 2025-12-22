# Claude + Gemini Configuration Repository - Status Report

## Executive Summary

**Status: ✅ PRODUCTION READY**

All 6 technology stacks have complete Claude Code and Gemini Code Assist configurations with:
- Full template systems (CLAUDE.md + GEMINI.md)
- Technology-specific coding rules (4-7 rules per stack)
- Specialized agents and commands
- Bi-directional config sync capabilities

The setup script (`setup-project.sh`) correctly deploys both Claude and Gemini configurations when the appropriate flags are used.

---

## Stack Coverage

All stacks have complete configurations:

| Stack | Claude Template | Rules | Skills | Gemini Config | Commands | Status |
|-------|----------------|-------|--------|---------------|----------|--------|
| **coilpack** | ✅ | 7 rules | Ready | ✅ | 6 commands | ✅ Complete |
| **craftcms** | ✅ | 6 rules | Ready | ✅ | 5 commands | ✅ Complete |
| **docusaurus** | ✅ | 4 rules | Ready | ✅ | 4 commands | ✅ Complete |
| **expressionengine** | ✅ | 7 rules | 4 skills | ✅ | 5 commands | ✅ Complete |
| **nextjs** | ✅ | 4 rules | Ready | ✅ | 4 commands | ✅ Complete |
| **wordpress-roots** | ✅ | 6 rules | Ready | ✅ | 4 commands | ✅ Complete |

### Detailed Rules Breakdown

**Coilpack (Laravel + EE) - 7 rules:**
- accessibility.md, alpinejs.md, bilingual-content.md
- laravel-patterns.md, mcp-workflow.md, performance.md, tailwind-css.md

**Craft CMS - 6 rules:**
- accessibility.md, alpinejs.md, bilingual-content.md
- craft-templates.md, performance.md, tailwind-css.md

**Docusaurus - 4 rules:**
- accessibility.md, markdown-content.md, performance.md, tailwind-css.md

**ExpressionEngine - 7 rules + 4 skills:**
- accessibility.md, alpinejs.md, bilingual-content.md
- expressionengine-templates.md, mcp-workflow.md, performance.md, tailwind-css.md
- Skills: alpine-component-builder, ee-stash-optimizer, ee-template-assistant, tailwind-utility-finder

**Next.js - 4 rules:**
- accessibility.md, nextjs-patterns.md, performance.md, tailwind-css.md

**WordPress/Roots - 6 rules:**
- accessibility.md, alpinejs.md, bilingual-content.md
- blade-templates.md, performance.md, tailwind-css.md

---

## Configuration Structure Per Stack

Each stack in `projects/` contains:

### Claude Code Configuration
```
projects/{stack}/
├── CLAUDE.md.template          # Main AI context (templated with project vars)
├── agents/                     # Specialized AI agents
├── commands/                   # Claude slash commands
│   ├── project-analyze.md
│   ├── sync-configs.md         # Syncs Claude & Gemini configs
│   └── {stack}-specific.md
├── rules/                      # Always-on coding constraints
├── skills/                     # Knowledge modules
├── settings.local.json         # Claude permissions
├── .vscode/                    # VSCode settings
└── .mcp.json                   # MCP server config (if applicable)
```

### Gemini Code Assist Configuration
```
projects/{stack}/gemini/
├── GEMINI.md.template          # Main Gemini context (templated)
├── settings.json.template      # Gemini settings + MCP config
├── config.yaml                 # PR review settings
├── styleguide.md               # Code review guidelines
├── geminiignore.template       # File exclusion patterns
├── instructions.md             # Additional Gemini instructions
└── commands/                   # Custom Gemini commands (TOML)
    ├── project-analyze.toml
    ├── config-sync.toml        # Syncs with Claude config
    └── {stack}-specific.toml
```

---

## Setup Script Behavior

### Initial Setup Command

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/project \
  --with-mcp \
  --with-gemini
```

**What Gets Deployed:**

#### Claude Configuration
1. `CLAUDE.md` - Generated from template with project-specific values
2. `AGENTS.md` - Symlink to CLAUDE.md
3. `.claude/` directory with:
   - `agents/` - AI agent personas
   - `commands/` - Slash commands
   - `rules/` - Coding constraints
   - `skills/` - Knowledge modules
   - `settings.local.json` - Permissions
4. `.vscode/` - Editor settings
5. `.mcp.json` - MCP server config (if `--with-mcp`)

#### Gemini Configuration (if `--with-gemini`)
1. `GEMINI.md` - Generated from template
2. `AGENT.md` - Symlink to GEMINI.md
3. `.gemini/` directory with:
   - `config.yaml` - PR review settings
   - `styleguide.md` - Code review style guide
   - `settings.json` - Generated from template (includes MCP)
   - `commands/*.toml` - Custom Gemini commands
4. `.geminiignore` - File exclusion patterns

### Refresh Command

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/project \
  --refresh \
  --with-gemini
```

**What Gets Updated:**

- ✅ Regenerates `CLAUDE.md` with current project values
- ✅ Regenerates `GEMINI.md` with current project values (if `--with-gemini`)
- ✅ Updates `.gemini/settings.json` from template
- ✅ Redeploys Gemini commands
- ✅ Redeploys `.mcp.json` if `--with-mcp`
- ⏸️ **Preserves** `.claude/` customizations (agents, commands, rules, skills)
- ⏸️ **Preserves** `.vscode/` settings

---

## Template Variable Substitution

Both `CLAUDE.md.template` and `GEMINI.md.template` support these auto-detected variables:

| Variable | Example | Detection Source |
|----------|---------|------------------|
| `{{PROJECT_NAME}}` | `myproject` | Directory name or `--name` |
| `{{PROJECT_SLUG}}` | `myproject` | Derived from name |
| `{{DDEV_NAME}}` | `myproject` | `.ddev/config.yaml` |
| `{{DDEV_DOCROOT}}` | `public` | `.ddev/config.yaml` |
| `{{DDEV_PHP}}` | `8.2` | `.ddev/config.yaml` |
| `{{DDEV_DB_TYPE}}` | `MariaDB` | `.ddev/config.yaml` |
| `{{DDEV_DB_VERSION}}` | `10.11` | `.ddev/config.yaml` |
| `{{DDEV_PRIMARY_URL}}` | `https://myproject.ddev.site` | `.ddev/config.yaml` |
| `{{TEMPLATE_GROUP}}` | `myproject` | `system/user/templates/` (EE) |

---

## Sync Between Claude and Gemini

Both systems include a config sync mechanism:

### Claude Command
**File:** `.claude/commands/sync-configs.md`
- Invoked as: `/sync-configs`
- Compares CLAUDE.md ↔ GEMINI.md
- Syncs coding standards and project info

### Gemini Command
**File:** `.gemini/commands/config-sync.toml`
- Invoked as: `/config:sync` (in Gemini)
- Compares GEMINI.md ↔ CLAUDE.md
- Ensures consistency across both AI assistants

---

## Verification Checklist

### ✅ All Stacks Have:
- [x] CLAUDE.md.template with variable substitution
- [x] Complete `.claude/` structure (agents, commands, rules, skills)
- [x] GEMINI.md.template with variable substitution
- [x] Complete `.gemini/` structure (config, styleguide, commands)
- [x] settings.json.template for Gemini MCP integration
- [x] geminiignore.template
- [x] Project-specific Gemini commands (TOML format)
- [x] Sync commands in both Claude and Gemini

### ✅ Setup Script Handles:
- [x] `--with-gemini` flag to deploy Gemini config
- [x] `--refresh` mode regenerates both CLAUDE.md and GEMINI.md
- [x] Template variable substitution for both
- [x] Symlink creation (AGENTS.md → CLAUDE.md, AGENT.md → GEMINI.md)
- [x] Preserves customizations during refresh
- [x] Deploys Gemini commands from source

---

## Usage Examples

### Setup New Project with Both

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/my-ee-site \
  --with-mcp \
  --with-gemini \
  --clean
```

**Result:**
- Full Claude configuration deployed
- Full Gemini configuration deployed
- Both use same project detection values
- MCP servers configured for both

### Refresh After DDEV Changes

```bash
# Changed PHP version or database?
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/my-ee-site \
  --refresh \
  --with-gemini
```

**Result:**
- CLAUDE.md regenerated with new values
- GEMINI.md regenerated with new values
- Custom agents/commands/rules preserved

### Add Gemini to Existing Claude-Only Project

```bash
./setup-project.sh \
  --stack=craftcms \
  --project=/path/to/my-craft-site \
  --refresh \
  --with-gemini
```

**Result:**
- Existing Claude config untouched
- Gemini config added
- Both synchronized

---

## Recent Additions (Git Status)

Based on recent commits, the following files were added across all stacks:

### New Agent Files
- `agents/code-quality-specialist.md` (all 6 stacks)
- `agents/security-expert.md` (all 6 stacks)

### New Command Files
- `commands/sync-configs.md` (all 6 stacks)
- `gemini/commands/config-sync.toml` (all 6 stacks)

### Modified Files
- `commands/project-analyze.md` (all 6 stacks) - Updated to support config sync

---

## Next Steps

### For Repository
1. ✅ **COMPLETE** - All stacks have full Claude + Gemini configurations
2. Consider: Update README.md to document `--with-gemini` flag usage
3. Consider: Add example .gitignore entries for Gemini files

### For Projects Being Configured
When deploying to actual projects, add to `.gitignore`:

```gitignore
# Claude Code / AI configuration (local dev only)
CLAUDE.md
AGENTS.md
.claude/

# Gemini Code Assist configuration (local dev only)
GEMINI.md
AGENT.md
.gemini/
.geminiignore
```

---

## Summary

✅ **Repository Status: Production Ready**

All 6 technology stacks have complete, synchronized configurations for both Claude Code and Gemini Code Assist. The setup script correctly deploys both when invoked with appropriate flags.

**Key Features Working:**
- Template-based generation with auto-detection
- Dual AI support (Claude + Gemini)
- Configuration sync commands
- Refresh mode preserves customizations
- MCP integration for both platforms
- Project-specific commands for each stack

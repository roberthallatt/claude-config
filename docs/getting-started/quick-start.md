# Quick Start

Configure AI coding assistants for your project in under a minute.

## 1. Install (One Time)

```bash
git clone https://github.com/canadian-paediatric-society/claude-config-repo.git ~/.ai-config && \
~/.ai-config/install.sh && \
source ~/.zshrc
```

## 2. Configure Your Project

```bash
ai-config --project=/path/to/your/project --with-all
```

That's it! The script auto-detects your framework and technologies.

---

## What Happens

When you run `ai-config --project=. --with-all`:

1. **Framework Detection** - Identifies ExpressionEngine, Craft CMS, WordPress, Next.js, etc.
2. **Technology Detection** - Finds Tailwind, Alpine.js, SCSS, bilingual content, etc.
3. **AI Configuration** - Deploys optimized configs for 6 AI assistants
4. **Memory System** - Sets up persistent context (`MEMORY.md`)
5. **VSCode Setup** - Configures syntax highlighting, debugging, tasks

---

## Common Commands

### Current Directory

```bash
cd /path/to/your/project
ai-config --project=. --with-all
```

### Preview First

```bash
ai-config --project=. --with-all --dry-run
```

### Update After Changes

```bash
ai-config --refresh --project=.
```

### Discovery Mode (Unknown Framework)

```bash
ai-config --project=. --discover --with-all
```

Then run `/project-discover` in Claude Code.

---

## Deployed Files

| AI Assistant | Files |
|--------------|-------|
| Claude Code | `CLAUDE.md`, `MEMORY.md`, `.claude/` |
| Gemini Code Assist | `GEMINI.md`, `.gemini/` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Cursor AI | `.cursorrules` |
| Windsurf AI | `.windsurfrules` |
| OpenAI Codex | `AGENTS.md` |
| VSCode | `.vscode/settings.json`, `launch.json`, `tasks.json` |

---

## Auto-Detected Frameworks

| Framework | Detection |
|-----------|-----------|
| ExpressionEngine | `system/ee/` directory |
| Craft CMS | `craft` executable |
| WordPress (Roots) | `web/app/themes/` |
| WordPress | `wp-config.php` |
| Next.js | `next.config.js` |
| Docusaurus | `docusaurus.config.js` |
| Coilpack | Laravel + EE structure |

---

## Auto-Detected Technologies

| Technology | Result |
|------------|--------|
| Tailwind CSS | Adds rules + VSCode Tailwind support |
| Alpine.js | Adds Alpine.js rules |
| Foundation | Adds Foundation patterns |
| SCSS/Sass | Adds SCSS best practices |
| Bilingual (EN/FR) | Adds bilingual content rules |
| DDEV | Extracts project config |

---

## Individual AI Assistants

Don't need all 6? Use specific flags:

```bash
# Just Claude (always included)
ai-config --project=.

# Claude + Gemini
ai-config --project=. --with-gemini

# Claude + Copilot + Cursor
ai-config --project=. --with-copilot --with-cursor
```

---

## Superpowers Skills

Workflow skills are deployed by default:

| Skill | Purpose |
|-------|---------|
| `memory-management` | Persistent context |
| `brainstorming` | Idea generation |
| `writing-plans` | Implementation planning |
| `executing-plans` | Step-by-step execution |
| `systematic-debugging` | Root cause analysis |
| `test-driven-development` | TDD workflow |

Disable with `--no-superpowers`.

---

## Next Steps

- **[Memory System](../guides/memory-system.md)** - Persistent context guide
- **[Setup Script](../guides/setup-script.md)** - All options
- **[Configuration](configuration.md)** - What gets deployed

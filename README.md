# Claude Code Configuration

Shared Claude Code configuration files for consistent coding standards across projects.

## Quick Install

### Option 1: One-line install (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/roberthallatt/claude-config/main/install.sh | bash
```

> **Note:** Replace `YOURUSERNAME` with your actual GitHub username/organization.

### Option 2: Clone and install

```bash
git clone https://github.com/roberthallatt/claude-config.git ~/.claude-config
cd ~/.claude-config
./install.sh
```

This option makes updates easier:
```bash
cd ~/.claude-config && git pull && ./install.sh
```

## What's Included

### Global Configuration
- **CLAUDE.md** — Universal coding preferences (indentation, naming, security, accessibility, etc.)

### Stack Configurations (`stacks/`)
| File | Description |
|------|-------------|
| `craftcms.md` | Craft CMS 5.x + Twig templating |
| `wordpress-roots.md` | Bedrock + Sage + Blade templating |
| `expressionengine.md` | ExpressionEngine 7.x templates |
| `nextjs.md` | Next.js 14+ App Router + TypeScript |

### Library Configurations (`libraries/`)
| File | Description |
|------|-------------|
| `html5.md` | HTML5 semantics, accessibility, SEO |
| `tailwind.md` | Tailwind CSS utilities and patterns |
| `foundation.md` | Zurb Foundation 6.x |
| `alpinejs.md` | Alpine.js patterns and directives |
| `scss.md` | SCSS/Sass conventions and mixins |
| `vanilla-js.md` | Modern vanilla JavaScript patterns |

## Usage

After installation, import the relevant configs in your project's `CLAUDE.md`:

### Example: Craft CMS Project

```markdown
# Project: Client Website

## Stack
@~/.claude/stacks/craftcms.md
@~/.claude/libraries/tailwind.md
@~/.claude/libraries/alpinejs.md

## Local Development
- Environment: DDEV
- `ddev start` — Start containers
- `npm run dev` — Vite dev server

## Project-Specific Notes
- Forms handled by Freeform plugin
- Image transforms in config/image-transforms.php
```

### Example: WordPress (Roots) Project

```markdown
# Project: Corporate Site

## Stack
@~/.claude/stacks/wordpress-roots.md
@~/.claude/libraries/foundation.md
@~/.claude/libraries/scss.md

## Local Development
- `npm run dev` — Development build with HMR
- `npm run build` — Production build

## Project-Specific Notes
- Theme: web/app/themes/theme-name
- ACF Pro for flexible content
```

### Example: Next.js Project

```markdown
# Project: Marketing Site

## Stack
@~/.claude/stacks/nextjs.md
@~/.claude/libraries/tailwind.md
@~/.claude/libraries/html5.md

## Commands
- `npm run dev` — Start dev server
- `npm run build` — Production build

## Project-Specific Notes
- CMS: Sanity (headless)
- Deployment: Vercel
```

## Updating

To get the latest configurations:

```bash
# If you cloned the repo
cd ~/.claude-config && git pull && ./install.sh

# Or re-run the one-liner
curl -fsSL https://raw.githubusercontent.com/roberthallatt/claude-config/main/install.sh | bash
```

## Customization

### Global Preferences
Edit `~/.claude/CLAUDE.md` to customize your personal preferences. This file won't be overwritten by updates.

### Project-Specific Overrides
Add project-specific rules directly in your project's `CLAUDE.md` — they take precedence over imported files.

### Adding New Configs
1. Fork this repo
2. Add your files to `stacks/` or `libraries/`
3. Update your install script URL
4. Share with your team

## File Locations After Install

```
~/.claude/
├── CLAUDE.md              # Global preferences
├── stacks/
│   ├── craftcms.md
│   ├── expressionengine.md
│   ├── nextjs.md
│   └── wordpress-roots.md
└── libraries/
    ├── alpinejs.md
    ├── foundation.md
    ├── html5.md
    ├── scss.md
    ├── tailwind.md
    └── vanilla-js.md
```

## Team Onboarding

Add this to your project's README:

```markdown
## Development Setup

### Claude Code Configuration

Install shared Claude Code configs (one-time setup):

\`\`\`bash
curl -fsSL https://raw.githubusercontent.com/roberthallatt/claude-config/main/install.sh | bash
\`\`\`
```

## License

MIT — Use and modify freely.

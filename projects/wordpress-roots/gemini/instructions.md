# Project Instructions

## Tech Stack

This is a **WordPress** project using the Roots stack:
- **Bedrock** - WordPress boilerplate
- **Sage** - Modern WordPress theme
- **Blade** - Laravel templating
- **Tailwind CSS** - Utility-first CSS
- **Alpine.js** - JavaScript framework
- **DDEV** - Local development

## Project Structure

```
project-root/
├── config/           # WordPress config
├── web/
│   ├── app/         # wp-content
│   │   ├── themes/
│   │   ├── plugins/
│   │   └── uploads/
│   └── wp/          # WordPress core
└── .ddev/           # DDEV config
```

## Development

```bash
ddev start           # Start environment
ddev wp [command]    # WP-CLI
ddev composer        # Composer

# Theme (in theme directory)
ddev npm run dev     # Development
ddev npm run build   # Production
```

## Conventions

1. Use `ddev` prefix for all CLI commands
2. Blade templates over raw PHP
3. Composer for plugin management
4. Never edit web/wp/ directory
5. Environment variables in .env

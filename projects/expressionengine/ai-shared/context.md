# Project: {{PROJECT_NAME}}

## Overview

This is an **ExpressionEngine 7.x** CMS website using native EE templates.

- **CMS**: ExpressionEngine 7.x
- **CSS Framework**: Tailwind CSS (via PostCSS)
- **JavaScript**: Alpine.js for interactivity
- **Environment**: DDEV (Docker-based local development)
- **Database**: {{DDEV_DB_TYPE}} {{DDEV_DB_VERSION}}
- **PHP**: {{DDEV_PHP}}+

## Local Development URLs

- **Primary**: {{DDEV_PRIMARY_URL}}
- **Control Panel**: {{DDEV_PRIMARY_URL}}/eecp.php

## Directory Structure

```
{{PROJECT_SLUG}}/
├── {{DDEV_DOCROOT}}/              # Document root
│   ├── assets/                    # Compiled CSS/JS
│   ├── images/                    # Static images
│   ├── uploads/                   # User uploads
│   ├── themes/                    # EE themes
│   ├── src/                       # Source CSS/JS
│   ├── tailwind.config.js         # Tailwind configuration
│   ├── postcss.config.js          # PostCSS configuration
│   ├── package.json               # Frontend dependencies
│   ├── index.php                  # Frontend entry
│   └── eecp.php                   # Control panel entry
├── system/
│   ├── ee/                        # EE core (don't modify)
│   └── user/
│       ├── addons/                # Third-party and custom add-ons
│       ├── config/                # EE configuration
│       │   └── config.php
│       └── templates/{{TEMPLATE_GROUP}}/  # Site templates
│           ├── _layouts/          # Base layouts
│           ├── _partials/         # Reusable partials
│           ├── stash/             # Stash template partials
│           └── [groups]/          # Page template groups
├── .ddev/                         # DDEV configuration
├── .env.php                       # Environment variables
└── .github/workflows/             # CI/CD pipelines
```

## Common Commands

### Local Development
```bash
ddev start                     # Start DDEV containers
ddev stop                      # Stop DDEV containers
ddev ssh                       # SSH into web container
ddev describe                  # Show project info and URLs
```

### Frontend Build
```bash
cd {{DDEV_DOCROOT}}
npm install                    # Install dependencies
npm run dev                    # Development build with watch
npm run build                  # Production build
```

### ExpressionEngine CLI
```bash
ddev ee cache:clear             # Clear all caches
ddev ee cache:clear/tag         # Clear template caches
ddev ee update                  # Run EE updates
ddev ee list                    # List all available commands
ddev ee backup:database         # Backup database
```

### Database
```bash
ddev export-db > backup.sql.gz   # Export database
ddev import-db < backup.sql.gz   # Import database
ddev mysql                       # MySQL CLI
```

## Template Patterns

### Layouts
Templates use Stash-based layouts. Base layout in `stash/_layouts/`.

### Partials
Reusable components in `stash/partials/`. Include with:
```html
{exp:stash:embed name="partials:component-name"}
```

### Channel Entries
```html
{exp:channel:entries
    channel="resources"
    limit="10"
    dynamic="no"
    disable="categories|member_data"
}
    {!-- entry content --}
{/exp:channel:entries}
```

## Bilingual Considerations

This site may have bilingual content (EN/FR). When working with templates:
- Check for language-specific variables (`{lv_*_en}` / `{lv_*_fr}`)
- Domain-based language detection may be in use
- Respect existing translation patterns

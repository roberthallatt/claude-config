# Project Instructions

## Tech Stack

This is a **Craft CMS** project using:
- **Craft CMS** - Content management system
- **Twig** - Template engine
- **Tailwind CSS** - Utility-first CSS framework
- **Alpine.js** - Lightweight JavaScript framework
- **Vite** - Frontend build tool
- **DDEV** - Local development environment

## Project Structure

```
project-root/
├── config/                 # Craft configuration
│   ├── general.php        # General settings
│   ├── db.php             # Database config
│   └── project/           # Project config (YAML)
├── modules/               # Custom Yii modules
├── storage/               # Runtime files
├── templates/             # Twig templates
│   ├── _layouts/          # Base layouts
│   ├── _partials/         # Reusable partials
│   └── _components/       # UI components
├── web/                   # Web root
├── src/                   # Frontend source
│   ├── css/
│   └── js/
└── .ddev/                 # DDEV configuration
```

## Development Environment

### Starting the Environment
```bash
ddev start
```

### Common Commands
```bash
# Craft CLI
ddev craft [command]
ddev craft clear-caches/all
ddev craft project-config/apply
ddev craft migrate/all
ddev craft resave/entries

# Package managers
ddev composer [command]
ddev npm [command]

# Frontend Build
ddev npm run dev      # Development with HMR
ddev npm run build    # Production build

# Database
ddev mysql            # MySQL shell
ddev sequelace        # Open in Sequel Ace
```

## Template Patterns

### Entry Queries
```twig
{% set entries = craft.entries()
    .section('blog')
    .with(['featuredImage', 'author'])
    .orderBy('postDate desc')
    .limit(10)
    .all() %}
```

### Assets
```twig
{% set image = entry.featuredImage.one() %}
{% if image %}
    <img src="{{ image.url }}" alt="{{ image.alt }}">
{% endif %}
```

## Important Conventions

1. **Use DDEV commands** - Always prefix with `ddev`
2. **Eager loading** - Use `.with()` to prevent N+1 queries
3. **Project Config** - Changes sync via `config/project/`
4. **Escape output** - Use `|raw` only when necessary
5. **Mobile-first** - Design for mobile, enhance for desktop

## Debugging

```twig
{{ dump(variable) }}
```

```php
Craft::info($message, __METHOD__);
Craft::error($message, __METHOD__);
```

# Craft CMS Development Standards

## Stack Overview
- CMS: Craft CMS 5.x
- Templating: Twig
- Database: MySQL/MariaDB or PostgreSQL
- PHP 8.2+

## Directory Structure
```
project/
├── config/
│   ├── app.php
│   ├── general.php
│   ├── db.php
│   ├── custom.php
│   └── project/           # Project config (version controlled)
├── modules/
│   └── sitemodule/        # Custom module
├── templates/
│   ├── _layouts/          # Base layouts
│   ├── _partials/         # Reusable components
│   ├── _macros/           # Twig macros
│   └── [sections]/        # Section templates
├── web/
│   ├── assets/            # Compiled assets
│   └── uploads/           # User uploads (usually gitignored)
├── storage/               # Craft runtime files (gitignored)
└── vendor/                # Composer dependencies (gitignored)
```

## Common CLI Commands
- `./craft migrate/all` — Run pending migrations
- `./craft project-config/apply` — Apply project config changes
- `./craft clear-caches/all` — Clear all caches
- `./craft resave/entries --section=<handle>` — Resave entries
- `./craft index-assets/all` — Reindex asset volumes
- `./craft gc` — Run garbage collection
- `ddev start` / `ddev stop` — Local environment (if using DDEV)

## Twig Conventions

### Template Naming
- Layouts: `_layouts/base.twig`, `_layouts/site.twig`
- Partials: `_partials/header.twig`, `_partials/card.twig`
- Macros: `_macros/forms.twig`, `_macros/helpers.twig`
- Section templates match section handle: `news/_entry.twig`

### Common Patterns
```twig
{# Extend layouts #}
{% extends '_layouts/site' %}

{# Include partials #}
{% include '_partials/card' with { entry: entry } only %}

{# Import and use macros #}
{% import '_macros/forms' as forms %}
{{ forms.input('email', 'Email Address', { required: true }) }}

{# Entry queries - always set limits #}
{% set news = craft.entries()
    .section('news')
    .orderBy('postDate DESC')
    .limit(10)
    .all() %}

{# Eager loading to prevent N+1 #}
{% set entries = craft.entries()
    .section('projects')
    .with(['featuredImage', 'categories'])
    .all() %}

{# Check for empty before looping #}
{% if entries|length %}
    {% for entry in entries %}
        {# ... #}
    {% endfor %}
{% else %}
    <p>No entries found.</p>
{% endif %}

{# Safe image output #}
{% if entry.featuredImage.one() %}
    {% set image = entry.featuredImage.one() %}
    {{ image.getImg({ class: 'w-full' }) }}
{% endif %}

{# Matrix/entry blocks #}
{% for block in entry.contentBlocks.all() %}
    {% switch block.type.handle %}
        {% case 'text' %}
            {{ block.body }}
        {% case 'image' %}
            {% include '_partials/blocks/image' with { block: block } only %}
        {% default %}
            {# Unknown block type #}
    {% endswitch %}
{% endfor %}
```

### Twig Best Practices
- Use `only` keyword with includes to limit scope
- Always eager-load related elements (assets, categories, entries)
- Cache expensive queries with `{% cache %}` tags
- Use `|raw` filter sparingly and only for trusted HTML
- Prefer `entry.url` over building URLs manually
- Use `{% minify %}` in production for inline CSS/JS

## Plugin Conventions
- Check plugin compatibility before Craft upgrades
- Store plugin settings in project config when available
- Prefer official/verified plugins from the Plugin Store

## Database
- Never modify the database directly in production
- Use migrations for schema changes
- Content changes go through the control panel or element API

## Environment Configuration
- Use `.env` for environment-specific values
- Never commit `.env` files
- Use `App::env()` or `getenv()` to read environment variables
- Multi-environment config in `config/general.php`:
```php
return GeneralConfig::create()
    ->devMode(App::env('DEV_MODE') ?? false)
    ->allowAdminChanges(App::env('ALLOW_ADMIN_CHANGES') ?? false)
```

## Performance
- Enable Craft's built-in static caching for production
- Use image transforms with webp format
- Implement lazy loading for images below fold
- Review query counts in debug toolbar during development

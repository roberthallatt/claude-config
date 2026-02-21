# Craft CMS Helper Command

Provides assistance with Craft CMS CLI commands, content modeling, and template development.

## Craft CLI Commands

### Cache Management
```bash
# Clear all caches
ddev craft clear-caches/all

# Clear specific caches
ddev craft clear-caches/compiled-templates
ddev craft clear-caches/data
ddev craft clear-caches/asset-indexing-data
ddev craft clear-caches/template-caches
```

### Project Config
```bash
# Apply project config changes
ddev craft project-config/apply

# Rebuild project config
ddev craft project-config/rebuild

# Write current state to files
ddev craft project-config/write
```

### Database & Migrations
```bash
# Run all migrations
ddev craft migrate/all

# Run pending migrations
ddev craft migrate/up

# Create new migration
ddev craft migrate/create migration_name
```

### Content Resaving
```bash
# Resave all entries
ddev craft resave/entries

# Resave specific section
ddev craft resave/entries --section=blog

# Update search indexes
ddev craft resave/entries --update-search-index

# Resave assets
ddev craft resave/assets
```

### Utilities
```bash
# Fix project config
ddev craft project-config/rebuild

# Clear data caches
ddev craft invalidate-tags/all

# Index assets
ddev craft index-assets/all

# GC (garbage collection)
ddev craft gc

# Update Craft
ddev craft update
```

## Content Structure

### Elements
| Element | Description |
|---------|-------------|
| Entries | Content entries (pages, posts, etc.) |
| Assets | Files and images |
| Categories | Taxonomy/categorization |
| Tags | Flat tagging |
| Users | User accounts |
| Globals | Site-wide content |
| Matrix | Nested content blocks |

### Entry Queries in Twig
```twig
{# Basic query #}
{% set entries = craft.entries()
    .section('blog')
    .orderBy('postDate desc')
    .limit(10)
    .all() %}

{# With eager loading #}
{% set entries = craft.entries()
    .section('blog')
    .with(['featuredImage', 'categories'])
    .all() %}

{# Filter by category #}
{% set entries = craft.entries()
    .section('blog')
    .relatedTo(category)
    .all() %}

{# Single entry #}
{% set entry = craft.entries()
    .section('pages')
    .slug('about')
    .one() %}
```

### Asset Queries
```twig
{# From asset field #}
{% set image = entry.myImageField.one() %}

{# Transform on the fly #}
{% set thumb = image.url({ width: 300, height: 200 }) %}

{# With transforms #}
{% set image = entry.image.transform('thumbnail').one() %}
```

### Categories
```twig
{% set categories = craft.categories()
    .group('topics')
    .all() %}

{% for cat in categories %}
    <a href="{{ cat.url }}">{{ cat.title }}</a>
{% endfor %}
```

## Template Organization

```
templates/
├── _layouts/
│   ├── base.twig           # Main HTML structure
│   └── page.twig           # Page layout
├── _partials/
│   ├── header.twig
│   ├── footer.twig
│   └── nav.twig
├── _components/
│   ├── card.twig
│   ├── button.twig
│   └── hero.twig
├── _blocks/                 # Matrix block templates
│   ├── text.twig
│   ├── image.twig
│   └── video.twig
├── index.twig              # Homepage
├── blog/
│   ├── _entry.twig         # Single blog post
│   └── index.twig          # Blog listing
└── pages/
    └── _entry.twig         # Generic page
```

## GraphQL (if enabled)

```bash
# Test GraphQL endpoint
curl -X POST {{DDEV_PRIMARY_URL}}/api \
  -H "Content-Type: application/json" \
  -d '{"query": "{ entries { title } }"}'
```

## Prompt

When I ask for Craft help, provide:
1. The correct `ddev craft` command syntax
2. Twig template patterns for the use case
3. Control panel location for configuration
4. Best practices for the specific task
5. Performance considerations (eager loading, caching)

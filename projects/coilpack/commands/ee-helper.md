# ExpressionEngine Helper Command

Provides assistance with ExpressionEngine CLI commands, add-ons, and content management in Coilpack projects.

## EE CLI Commands

### Cache Management
```bash
# Clear all caches
ddev ee cache:clear

# Clear specific caches
ddev ee cache:clear --type=page
ddev ee cache:clear --type=tag
ddev ee cache:clear --type=db
```

### Add-on Management
```bash
# List all add-ons
ddev ee addons:list

# Install an add-on
ddev ee addons:install addon_name

# Uninstall an add-on
ddev ee addons:uninstall addon_name

# Update an add-on
ddev ee addons:update addon_name
```

### Database & Sync
```bash
# Sync file-based templates to database
ddev ee sync:template

# Export templates to files
ddev ee sync:template --export

# Update file sync
ddev ee update:file-sync
```

### Channel Management
```bash
# List channels
ddev ee channel:list

# Create channel entry (interactive)
ddev ee channel:create-entry channel_name
```

### Member Management
```bash
# List members
ddev ee member:list

# Create member
ddev ee member:create

# Reset password
ddev ee member:reset-password username
```

### Utilities
```bash
# Run update
ddev ee update

# Check version
ddev ee --version

# List all available commands
ddev ee list
```

## Content Structure

### Channels
Channels are the primary content containers in EE.

```
Channels → Field Groups → Fields
                       → Categories
                       → Statuses
```

**Common Channel Configuration:**
- `channel_name` - Short name (used in code)
- `channel_title` - Display name
- `field_group` - Associated field group
- `cat_group` - Associated category groups
- `status_group` - Status options

### Field Types
| Type | Use Case |
|------|----------|
| `text` | Single line text |
| `textarea` | Multi-line text |
| `rte` | Rich text editor |
| `file` | File/image uploads |
| `grid` | Repeating row data |
| `fluid` | Flexible content blocks |
| `relationship` | Entry relationships |
| `toggle` | Boolean on/off |
| `select` | Dropdown options |
| `checkboxes` | Multiple selections |
| `date` | Date picker |
| `url` | URL field |
| `email` | Email field |

### Accessing in Twig (Coilpack)

```twig
{# Channel entries #}
{% for entry in exp.channel.entries({channel: 'blog'}) %}
    {{ entry.title }}
    {{ entry.custom_field }}
{% endfor %}

{# Categories #}
{% for cat in exp.category.entries({group_id: 1}) %}
    {{ cat.cat_name }}
{% endfor %}

{# Global variables #}
{{ global.site_name }}

{# Snippets (as Twig includes) #}
{% include '_snippets/my_snippet.html.twig' %}
```

## Add-on Locations

```
ee/system/user/addons/          # Third-party & custom add-ons
ee/system/ee/ExpressionEngine/  # Core EE
```

### Creating a Custom Add-on
```bash
# Basic structure
ee/system/user/addons/my_addon/
├── addon.setup.php      # Add-on configuration
├── mod.my_addon.php     # Module class (frontend)
├── mcp.my_addon.php     # Control panel class
├── upd.my_addon.php     # Installer/updater
├── ext.my_addon.php     # Extension hooks
└── language/
    └── english/
        └── my_addon_lang.php
```

## File Uploads

### Upload Directories
Configured in: **CP → Files → Upload Directories**

```twig
{# Access file field #}
{{ entry.my_file_field.url }}
{{ entry.my_file_field.path }}
{{ entry.my_file_field.filename }}
{{ entry.my_file_field.title }}
{{ entry.my_file_field.width }}
{{ entry.my_file_field.height }}

{# Image manipulations (if configured) #}
{{ entry.my_image.manipulations.thumbnail.url }}
```

## Categories

### Category Groups
```twig
{# All categories in a group #}
{% for cat in exp.category.entries({group_id: 1}) %}
    {{ cat.cat_id }}
    {{ cat.cat_name }}
    {{ cat.cat_url_title }}
    {{ cat.cat_description }}
    {{ cat.parent_id }}
{% endfor %}

{# Entry's categories #}
{% for cat in entry.categories %}
    {{ cat.cat_name }}
{% endfor %}

{# Filter entries by category #}
{% for entry in exp.channel.entries({
    channel: 'blog',
    category: 5
}) %}
{% endfor %}
```

## Status Management

### Default Statuses
- `open` - Published/visible
- `closed` - Unpublished/hidden

### Filtering by Status
```twig
{# Only open entries (default) #}
{% for entry in exp.channel.entries({channel: 'blog'}) %}

{# Include closed entries #}
{% for entry in exp.channel.entries({
    channel: 'blog',
    status: 'open|closed'
}) %}

{# Custom status #}
{% for entry in exp.channel.entries({
    channel: 'blog',
    status: 'featured'
}) %}
```

## Member Data

```twig
{# Current logged-in member #}
{% if logged_in %}
    {{ member.screen_name }}
    {{ member.email }}
    {{ member.member_id }}
    {{ member.group_id }}
{% endif %}

{# Check member group #}
{% if member.group_id == 1 %}
    {# Super Admin #}
{% endif %}
```

## URL Segments

```twig
{{ segment_1 }}  {# First URL segment #}
{{ segment_2 }}  {# Second URL segment #}
{{ segment_3 }}  {# Third URL segment #}

{# Common pattern for single entries #}
{% set entry = exp.channel.entries({
    channel: 'blog',
    url_title: segment_2,
    limit: 1
}).first() %}
```

## Search

```twig
{# Basic search #}
{% for entry in exp.channel.entries({
    channel: 'blog',
    search:title: 'keyword',
    search:body: 'keyword'
}) %}
{% endfor %}
```

## Pagination

```twig
{% set entries = exp.channel.entries({
    channel: 'blog',
    limit: 10,
    paginate: true
}) %}

{% for entry in entries %}
    {# Entry content #}
{% endfor %}

{# Pagination links #}
{{ entries.pagination.links }}
```

## Prompt

When I ask for EE help, provide:
1. The correct `ddev ee` command syntax
2. Twig/Coilpack patterns for accessing data
3. Control panel location for configuration
4. Bilingual considerations where applicable
5. Integration with Laravel features when relevant

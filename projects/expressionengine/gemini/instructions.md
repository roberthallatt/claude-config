# Project Instructions

## Tech Stack

This is an **ExpressionEngine** project using:
- **ExpressionEngine** - Content management system with native templates
- **DDEV** - Local development environment
- **Tailwind CSS** - Utility-first CSS framework
- **Alpine.js** - Lightweight JavaScript framework
- **PostCSS/Vite** - Frontend build tool
- **Stash** - Template caching add-on

## Project Structure

```
project-root/
├── system/
│   ├── ee/                    # EE core (don't modify)
│   └── user/
│       ├── addons/            # Third-party & custom add-ons
│       ├── cache/             # Template cache
│       ├── config/            # Configuration files
│       └── templates/         # EE templates
│           └── default_site/
│               ├── _layouts/   # Layout templates
│               ├── _partials/  # Reusable components
│               └── [groups]/   # Template groups
├── public/                    # Web root
│   ├── index.php             # Front controller
│   └── themes/               # EE themes
├── src/                      # Source CSS/JS
└── package.json              # Frontend dependencies
```

## Development Environment

### Starting the Environment
```bash
ddev start
```

### Common Commands
```bash
# ExpressionEngine CLI
ddev ee [command]
ddev ee cache:clear       # Clear all caches
ddev ee sync:template     # Sync templates to files
ddev ee addons:list       # List installed add-ons

# Frontend Build
ddev npm run dev          # Development build with watch
ddev npm run build        # Production build

# Database
ddev mysql                # MySQL CLI
ddev sequelace            # Open Sequel Ace (macOS)
```

## Template Patterns

### Templates Location
```
system/user/templates/default_site/
```

### Layout Pattern
```ee
{!-- Page template uses layout --}
{layout="_layouts/main"}

{layout:set name="title"}{title} | {site_name}{/layout:set}
{layout:set name="content"}
    {!-- Page content --}
{/layout:set}
```

### Channel Entries
```ee
{exp:channel:entries channel="blog" limit="10" status="open" orderby="entry_date" sort="desc"}
    <article>
        <h2>{title}</h2>
        {body}
    </article>
{/exp:channel:entries}
```

### Single Entry by URL
```ee
{exp:channel:entries channel="pages" url_title="{segment_2}" limit="1" require_entry="yes"}
    <h1>{title}</h1>
    {page_content}
{if no_results}
    {redirect="404"}
{/if}
{/exp:channel:entries}
```

### Categories
```ee
{exp:channel:categories channel="blog" style="linear"}
    <li><a href="{path='blog/category/{category_url_title}'}">{category_name}</a></li>
{/exp:channel:categories}
```

### Stash Caching
```ee
{!-- Cache navigation for 60 minutes --}
{exp:stash:set name="main_nav" save="yes" refresh="60" scope="site"}
    {exp:channel:entries channel="navigation"}
        <a href="{page_url}">{title}</a>
    {/exp:channel:entries}
{/exp:stash:set}

{!-- Later, retrieve cached navigation --}
{exp:stash:get name="main_nav" scope="site"}
```

## Bilingual Support

This project supports **English** and **French**.

### Language Detection
```ee
{if segment_1 == "fr"}
    {!-- French content --}
{if:else}
    {!-- English content --}
{/if}
```

### Multi-language Entries
```ee
{exp:channel:entries channel="pages" url_title="{segment_2}"}
    {if "{segment_1}" == "fr"}
        {title_fr}
        {body_fr}
    {if:else}
        {title}
        {body}
    {/if}
{/exp:channel:entries}
```

## Important Conventions

1. **Use DDEV commands** - Prefix with `ddev` (e.g., `ddev ee`, `ddev npm`)
2. **Cache expensive queries** - Use Stash for repeated data
3. **No hardcoded strings** - Support bilingual content
4. **Accessibility first** - WCAG 2.1 AA compliance required
5. **Mobile-first** - Design for mobile, enhance for desktop

## Debugging

### Template Debugging
```ee
{!-- Temporarily show variable contents --}
<pre>{exp:stash:get name="debug_var"}</pre>

{!-- Show segment values --}
Segment 1: {segment_1}
Segment 2: {segment_2}
```

### PHP Debugging
Enable template debugging in CP: **Settings → Debugging & Output**

### Xdebug (DDEV)
Xdebug is available via DDEV. Use VS Code with PHP Debug extension.

## Control Panel Access

Admin CP: `https://[site-url]/admin.php` or custom CP URL

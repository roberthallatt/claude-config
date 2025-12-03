# ExpressionEngine Development Standards

## Stack Overview
- CMS: ExpressionEngine 7.x
- Templating: Native EE Template Language
- Database: MySQL/MariaDB
- PHP 8.1+

## Directory Structure
```
project/
├── system/
│   ├── ee/                # EE core (don't modify)
│   ├── user/
│   │   ├── addons/        # Third-party and custom add-ons
│   │   ├── config/
│   │   │   └── config.php
│   │   ├── cache/
│   │   ├── templates/     # File-based templates
│   │   │   └── default_site/
│   │   │       ├── _partials.group/
│   │   │       ├── _layouts.group/
│   │   │       └── site.group/
│   │   └── language/
│   └── index.php
├── public/                # Document root
│   ├── themes/            # Frontend themes
│   ├── images/
│   │   └── uploads/       # User uploads
│   ├── admin.php          # Control panel entry
│   └── index.php          # Frontend entry
└── .env.php               # Environment config
```

## Template Organization
```
templates/default_site/
├── _partials.group/       # Hidden group (underscore prefix)
│   ├── header.html
│   ├── footer.html
│   ├── navigation.html
│   └── card.html
├── _layouts.group/        # Base layouts
│   ├── base.html
│   └── site.html
├── site.group/            # General pages
│   ├── index.html         # Homepage
│   └── about.html
├── news.group/            # News section
│   ├── index.html         # Listing
│   └── detail.html        # Single entry
└── _errors.group/         # Error pages
    └── 404.html
```

## Common Patterns

### Layouts and Embeds
```html
{!-- _layouts.group/site.html --}
{layout="layouts/base"}

{layout:set name="body_class"}page-{segment_1}{/layout:set}

<main class="main-content">
    {layout:contents}
</main>

{!-- Page template using layout --}
{layout="layouts/site"}

<h1>{title}</h1>
{page_body}
```

### Embed Partials
```html
{!-- Include partial --}
{embed="_partials/card" entry_id="{entry_id}"}

{!-- Partial with variables --}
{embed="_partials/header" show_search="yes"}

{!-- Inside _partials/header.html --}
{if embed:show_search == "yes"}
    {!-- search form --}
{/if}
```

### Channel Entries
```html
{!-- Basic entry loop --}
{exp:channel:entries
    channel="news"
    limit="10"
    orderby="date"
    sort="desc"
    dynamic="no"
}
    {if no_results}
        <p>No entries found.</p>
    {/if}

    <article>
        <h2><a href="{url_title_path='news/detail'}">{title}</a></h2>
        <time datetime="{entry_date format='%Y-%m-%d'}">{entry_date format='%F %j, %Y'}</time>
        {summary}
    </article>
{/exp:channel:entries}

{!-- Single entry --}
{exp:channel:entries
    channel="news"
    url_title="{segment_2}"
    limit="1"
    require_entry="yes"
}
    <article>
        <h1>{title}</h1>
        {body}
    </article>
{/exp:channel:entries}

{!-- Related entries via Playa/Relationship --}
{exp:channel:entries channel="projects" entry_id="{entry_id}"}
    {related_entries}
        <a href="{url_title_path='projects/detail'}">{title}</a>
    {/related_entries}
{/exp:channel:entries}
```

### Conditionals
```html
{!-- Simple conditional --}
{if logged_in}Welcome back!{/if}

{!-- Field conditionals --}
{if featured_image}
    <img src="{featured_image}" alt="{title}">
{/if}

{!-- Advanced conditionals --}
{if segment_1 == "news" AND segment_2 != ""}
    {!-- Single news entry --}
{if:elseif segment_1 == "news"}
    {!-- News listing --}
{if:else}
    {!-- Default --}
{/if}

{!-- Check for empty --}
{if summary != ""}
    {summary}
{if:else}
    {body characters="200"}...
{/if}
```

### Categories
```html
{exp:channel:categories
    channel="news"
    style="linear"
}
    <a href="{path='news/category'}/{category_url_title}">{category_name}</a>
{/exp:channel:categories}

{!-- Filter by category --}
{exp:channel:entries
    channel="news"
    category_url_title="{segment_3}"
}
```

### Pagination
```html
{exp:channel:entries channel="news" limit="10" paginate="bottom"}
    {!-- entries --}

    {paginate}
        <nav class="pagination">
            {pagination_links}
                {first_page}<a href="{pagination_url}">First</a>{/first_page}
                {previous_page}<a href="{pagination_url}">Prev</a>{/previous_page}
                {page}
                    <a href="{pagination_url}" {if current_page}class="active"{/if}>{pagination_page_number}</a>
                {/page}
                {next_page}<a href="{pagination_url}">Next</a>{/next_page}
                {last_page}<a href="{pagination_url}">Last</a>{/last_page}
            {/pagination_links}
        </nav>
    {/paginate}
{/exp:channel:entries}
```

## Add-on Conventions
- Store custom add-ons in `system/user/addons/`
- Follow EE add-on structure and naming conventions
- Use add-on settings for configurable options
- Document required add-ons in README

## Performance
- Use `disable="categories|member_data|pagination"` when not needed
- Cache heavy queries with `{exp:ce_cache}` or native caching
- Use `dynamic="no"` when URL segments shouldn't affect queries
- Enable template caching in production
- Use `{preload_replace}` for repeated values

## Environment Configuration (.env.php)
```php
<?php
$env_config = [
    'base_url' => 'https://example.com',
    'database' => [
        'hostname' => 'localhost',
        'database' => 'ee_database',
        'username' => 'db_user',
        'password' => 'db_password',
    ],
    'show_profiler' => false,
    'debug' => 0,
];
return $env_config;
```

## Common Add-ons
- Low Search — Advanced search functionality
- Bloqs — Modular content blocks
- Assets — Enhanced file management
- SEO Lite — Meta tags and SEO
- Freeform — Form builder

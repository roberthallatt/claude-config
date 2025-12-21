# Twig Template Helper Command

Scaffolds and assists with Twig templates in Coilpack/ExpressionEngine projects.

## Template Locations

```
ee/system/user/templates/default_site/
├── _layouts/              # Base layouts
│   └── default.html.twig
├── _partials/             # Reusable partials
│   ├── header.html.twig
│   ├── footer.html.twig
│   └── nav.html.twig
├── _components/           # UI components
├── pages/                 # Page templates
│   └── index.html.twig
├── blog/                  # Blog templates
│   ├── index.html.twig
│   └── _entry.html.twig
└── errors/                # Error pages
    └── 404.html.twig
```

## Layout Pattern

### Base Layout (`_layouts/default.html.twig`)
```twig
<!DOCTYPE html>
<html lang="{{ app.getLocale() }}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}{{ global.site_name }}{% endblock %}</title>
    {% block meta %}{% endblock %}
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body>
    {% include '_partials/header.html.twig' %}
    
    <main>
        {% block content %}{% endblock %}
    </main>
    
    {% include '_partials/footer.html.twig' %}
    
    {% block scripts %}{% endblock %}
</body>
</html>
```

### Page Template
```twig
{% extends '_layouts/default.html.twig' %}

{% block title %}Page Title | {{ parent() }}{% endblock %}

{% block content %}
    <h1>{{ entry.title }}</h1>
    {{ entry.body }}
{% endblock %}
```

## Accessing EE Data

### Channel Entries
```twig
{# Basic entry loop #}
{% for entry in exp.channel.entries({channel: 'blog', limit: 10}) %}
    <article>
        <h2>{{ entry.title }}</h2>
        <p>{{ entry.blog_summary }}</p>
        <a href="{{ entry.url }}">Read more</a>
    </article>
{% endfor %}

{# Single entry by URL title #}
{% set entry = exp.channel.entries({
    channel: 'pages',
    url_title: segment_2,
    limit: 1
}).first() %}

{# With categories #}
{% for entry in exp.channel.entries({
    channel: 'news',
    category: '3|5',
    orderby: 'date',
    sort: 'desc'
}) %}
{% endfor %}
```

### Categories
```twig
{% for cat in exp.category.entries({group_id: 1}) %}
    <li>{{ cat.cat_name }}</li>
{% endfor %}
```

### Global Variables
```twig
{{ global.site_name }}
{{ global.site_url }}
{{ global.webmaster_email }}
{# Custom global variables #}
{{ global.custom_var_name }}
```

### File Fields
```twig
{# Single file #}
<img src="{{ entry.hero_image.url }}" alt="{{ entry.hero_image.title }}">

{# File field with manipulations #}
<img src="{{ entry.hero_image.url }}" 
     width="{{ entry.hero_image.width }}"
     height="{{ entry.hero_image.height }}">
```

### Grid Fields
```twig
{% for row in entry.my_grid_field %}
    <div>
        {{ row.column_one }}
        {{ row.column_two }}
    </div>
{% endfor %}
```

### Fluid Fields
```twig
{% for field in entry.my_fluid_field %}
    {% if field.type == 'text' %}
        <p>{{ field.content }}</p>
    {% elseif field.type == 'image' %}
        <img src="{{ field.content.url }}">
    {% endif %}
{% endfor %}
```

### Relationships
```twig
{% for related in entry.related_entries %}
    <a href="{{ related.url }}">{{ related.title }}</a>
{% endfor %}
```

## Bilingual Patterns

### Using Laravel Translations
```twig
{# In template #}
{{ __('messages.welcome') }}
{{ trans_choice('messages.items', count) }}

{# With parameters #}
{{ __('messages.greeting', {name: user.name}) }}
```

### Language Files (`lang/en/messages.php`, `lang/fr/messages.php`)
```php
// lang/en/messages.php
return [
    'welcome' => 'Welcome',
    'read_more' => 'Read more',
];

// lang/fr/messages.php
return [
    'welcome' => 'Bienvenue',
    'read_more' => 'Lire la suite',
];
```

### Locale-Based Content
```twig
{% if app.getLocale() == 'fr' %}
    {{ entry.body_fr }}
{% else %}
    {{ entry.body_en }}
{% endif %}

{# Or with null coalescing #}
{{ entry['body_' ~ app.getLocale()] ?? entry.body_en }}
```

## Common Twig Syntax

### Control Structures
```twig
{# Conditionals #}
{% if condition %}
{% elseif other %}
{% else %}
{% endif %}

{# Loops #}
{% for item in items %}
    {{ loop.index }}    {# 1-indexed #}
    {{ loop.index0 }}   {# 0-indexed #}
    {{ loop.first }}    {# boolean #}
    {{ loop.last }}     {# boolean #}
{% else %}
    No items found.
{% endfor %}

{# Set variables #}
{% set myVar = 'value' %}
{% set myArray = ['a', 'b', 'c'] %}
```

### Filters
```twig
{{ text|upper }}
{{ text|lower }}
{{ text|title }}
{{ text|trim }}
{{ text|striptags }}
{{ text|nl2br }}
{{ text|raw }}           {# Output unescaped HTML #}
{{ date|date('F j, Y') }}
{{ number|number_format(2, '.', ',') }}
{{ array|join(', ') }}
{{ text|slice(0, 100) ~ '...' }}
{{ text|default('No content') }}
```

### Including Partials
```twig
{% include '_partials/card.html.twig' %}

{# With variables #}
{% include '_partials/card.html.twig' with {
    title: entry.title,
    image: entry.thumbnail
} %}

{# Only passed variables available #}
{% include '_partials/card.html.twig' with {title: 'Test'} only %}
```

### Macros
```twig
{# Define macro #}
{% macro button(text, url, class) %}
    <a href="{{ url }}" class="btn {{ class|default('btn-primary') }}">
        {{ text }}
    </a>
{% endmacro %}

{# Import and use #}
{% from '_macros/ui.html.twig' import button %}
{{ button('Click me', '/path', 'btn-secondary') }}
```

## Prompt

When I ask to create a Twig template:
1. Use Coilpack conventions (layouts, partials structure)
2. Include proper EE data access patterns
3. Add bilingual support with Laravel translations
4. Follow the project's existing patterns
5. Use Tailwind CSS classes for styling

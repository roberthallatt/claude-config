# Twig Template Scaffold Command

Scaffolds new Twig templates for Coilpack/ExpressionEngine projects.

## Template Types

### 1. Layout Template
Creates a base layout with common structure.

**Location:** `ee/system/user/templates/default_site/_layouts/`

```twig
{# _layouts/default.html.twig #}
<!DOCTYPE html>
<html lang="{{ app.getLocale() }}" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="{% block meta_description %}{{ global.site_description|default('') }}{% endblock %}">
    
    <title>{% block title %}{{ global.site_name }}{% endblock %}</title>
    
    {# Favicon #}
    <link rel="icon" href="/favicon.ico">
    
    {# Preconnect #}
    <link rel="preconnect" href="https://fonts.googleapis.com">
    
    {% block head %}{% endblock %}
    
    {# Vite assets #}
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="{% block body_class %}{% endblock %}">
    <a href="#main-content" class="sr-only focus:not-sr-only">
        {{ __('accessibility.skip_to_content') }}
    </a>

    {% include '_partials/header.html.twig' %}

    <main id="main-content">
        {% block content %}{% endblock %}
    </main>

    {% include '_partials/footer.html.twig' %}

    {% block scripts %}{% endblock %}
</body>
</html>
```

### 2. Page Template
Creates a standard page template extending the layout.

**Location:** `ee/system/user/templates/default_site/pages/`

```twig
{# pages/index.html.twig #}
{% extends '_layouts/default.html.twig' %}

{% set entry = exp.channel.entries({
    channel: 'pages',
    url_title: segment_2|default('homepage'),
    limit: 1,
    status: 'open'
}).first() %}

{% block title %}{{ entry.title }} | {{ parent() }}{% endblock %}

{% block meta_description %}{{ entry.meta_description|default(entry.page_summary|striptags|slice(0, 160)) }}{% endblock %}

{% block content %}
<article class="page">
    <div class="container mx-auto px-4 py-8">
        <header class="mb-8">
            <h1 class="text-4xl font-bold">{{ entry.title }}</h1>
        </header>

        <div class="prose max-w-none">
            {{ entry.page_body|raw }}
        </div>
    </div>
</article>
{% endblock %}
```

### 3. Listing Template
Creates a template for listing entries (blog, news, etc.).

**Location:** `ee/system/user/templates/default_site/{channel}/`

```twig
{# blog/index.html.twig #}
{% extends '_layouts/default.html.twig' %}

{% block title %}{{ __('blog.title') }} | {{ parent() }}{% endblock %}

{% block content %}
<section class="listing-page">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-4xl font-bold mb-8">{{ __('blog.title') }}</h1>

        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {% for entry in exp.channel.entries({
                channel: 'blog',
                limit: 12,
                orderby: 'date',
                sort: 'desc',
                status: 'open'
            }) %}
                {% include '_components/entry-card.html.twig' with {entry: entry} %}
            {% else %}
                <p class="col-span-full text-gray-500">
                    {{ __('blog.no_entries') }}
                </p>
            {% endfor %}
        </div>

        {# Pagination would go here #}
    </div>
</section>
{% endblock %}
```

### 4. Single Entry Template
Creates a template for displaying a single entry.

```twig
{# blog/_entry.html.twig #}
{% extends '_layouts/default.html.twig' %}

{% set entry = exp.channel.entries({
    channel: 'blog',
    url_title: segment_2,
    limit: 1,
    status: 'open'
}).first() %}

{% if not entry %}
    {% include 'errors/404.html.twig' %}
{% else %}

{% block title %}{{ entry.title }} | {{ parent() }}{% endblock %}

{% block meta_description %}{{ entry.blog_summary|striptags|slice(0, 160) }}{% endblock %}

{% block content %}
<article class="single-entry">
    <div class="container mx-auto px-4 py-8">
        <header class="mb-8">
            <h1 class="text-4xl font-bold mb-4">{{ entry.title }}</h1>
            <div class="text-gray-600">
                <time datetime="{{ entry.entry_date|date('Y-m-d') }}">
                    {{ entry.entry_date|date('F j, Y') }}
                </time>
                {% if entry.author %}
                    <span class="mx-2">|</span>
                    <span>{{ entry.author.screen_name }}</span>
                {% endif %}
            </div>
        </header>

        {% if entry.hero_image.url %}
            <figure class="mb-8">
                <img src="{{ entry.hero_image.url }}" 
                     alt="{{ entry.hero_image.title }}"
                     class="w-full rounded-lg">
            </figure>
        {% endif %}

        <div class="prose max-w-none">
            {{ entry.blog_body|raw }}
        </div>

        {# Related entries #}
        {% set related = exp.channel.entries({
            channel: 'blog',
            limit: 3,
            not_entry_id: entry.entry_id,
            orderby: 'date',
            sort: 'desc'
        }) %}
        
        {% if related|length > 0 %}
            <aside class="mt-12 pt-8 border-t">
                <h2 class="text-2xl font-bold mb-6">{{ __('blog.related') }}</h2>
                <div class="grid md:grid-cols-3 gap-6">
                    {% for item in related %}
                        {% include '_components/entry-card.html.twig' with {entry: item} %}
                    {% endfor %}
                </div>
            </aside>
        {% endif %}
    </div>
</article>
{% endif %}
{% endblock %}
```

### 5. Partial Template
Creates reusable partial components.

**Location:** `ee/system/user/templates/default_site/_partials/`

```twig
{# _partials/header.html.twig #}
<header class="site-header bg-white shadow-sm">
    <div class="container mx-auto px-4">
        <div class="flex items-center justify-between h-16">
            <a href="/" class="flex-shrink-0">
                <img src="/images/logo.svg" alt="{{ global.site_name }}" class="h-8">
            </a>

            <nav class="hidden md:flex space-x-8">
                {% for item in exp.channel.entries({channel: 'navigation', orderby: 'entry_order'}) %}
                    <a href="{{ item.nav_url }}" 
                       class="text-gray-700 hover:text-blue-600 {{ segment_1 == item.url_title ? 'text-blue-600 font-medium' : '' }}">
                        {{ item.title }}
                    </a>
                {% endfor %}
            </nav>

            {# Language switcher #}
            <div class="flex items-center space-x-4">
                {% if app.getLocale() == 'en' %}
                    <a href="/fr{{ path }}" class="text-sm text-gray-600 hover:text-blue-600">FR</a>
                {% else %}
                    <a href="/en{{ path }}" class="text-sm text-gray-600 hover:text-blue-600">EN</a>
                {% endif %}
            </div>
        </div>
    </div>
</header>
```

### 6. Component Template
Creates reusable UI components.

**Location:** `ee/system/user/templates/default_site/_components/`

```twig
{# _components/entry-card.html.twig #}
<article class="entry-card bg-white rounded-lg shadow-sm overflow-hidden hover:shadow-md transition-shadow">
    {% if entry.thumbnail.url %}
        <a href="{{ entry.url }}">
            <img src="{{ entry.thumbnail.url }}" 
                 alt="{{ entry.thumbnail.title }}"
                 class="w-full h-48 object-cover">
        </a>
    {% endif %}
    
    <div class="p-4">
        <h3 class="text-lg font-semibold mb-2">
            <a href="{{ entry.url }}" class="hover:text-blue-600">
                {{ entry.title }}
            </a>
        </h3>
        
        {% if entry.blog_summary is defined %}
            <p class="text-gray-600 text-sm mb-4">
                {{ entry.blog_summary|striptags|slice(0, 120) }}...
            </p>
        {% endif %}
        
        <div class="flex items-center justify-between text-sm text-gray-500">
            <time datetime="{{ entry.entry_date|date('Y-m-d') }}">
                {{ entry.entry_date|date('M j, Y') }}
            </time>
            <a href="{{ entry.url }}" class="text-blue-600 hover:underline">
                {{ __('common.read_more') }}
            </a>
        </div>
    </div>
</article>
```

## Prompt

When scaffolding a Twig template, ask:
1. What type of template? (layout, page, listing, single, partial, component)
2. What channel/content type is it for?
3. What fields need to be displayed?
4. Should it include bilingual support?
5. Are there any related entries or special features needed?

Then create the template following Coilpack conventions with:
- Proper layout inheritance
- EE data access patterns
- Bilingual translation keys
- Tailwind CSS styling
- Accessibility considerations

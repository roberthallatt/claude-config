# Project Instructions

## Tech Stack

This is a **Coilpack** project combining:
- **ExpressionEngine** - Content management system
- **Laravel** - PHP framework for application logic
- **Twig** - Template engine (replacing EE's native templates)
- **Livewire** - Dynamic UI components (if installed)
- **Tailwind CSS** - Utility-first CSS framework
- **Alpine.js** - Lightweight JavaScript framework
- **Vite** - Frontend build tool
- **DDEV** - Local development environment

## Project Structure

```
project-root/
├── app/                    # Laravel application code
│   ├── Http/Controllers/   # Controllers
│   ├── Models/             # Eloquent models
│   ├── Livewire/          # Livewire components
│   └── Services/          # Business logic
├── ee/                     # ExpressionEngine
│   └── system/user/
│       ├── addons/        # EE add-ons
│       └── templates/     # Twig templates
├── resources/
│   ├── views/             # Blade/Livewire views
│   ├── css/               # Source CSS
│   ├── js/                # Source JavaScript
│   └── lang/              # Translation files
├── routes/                # Laravel routes
├── public/                # Web root
└── config/                # Configuration files
```

## Development Environment

### Starting the Environment
```bash
ddev start
```

### Common Commands
```bash
# Laravel/Artisan
ddev artisan [command]
ddev artisan migrate
ddev artisan cache:clear
ddev artisan make:livewire ComponentName

# ExpressionEngine CLI
ddev ee [command]
ddev ee cache:clear
ddev ee sync:template

# Frontend Build
ddev npm run dev      # Development with HMR
ddev npm run build    # Production build

# Database
ddev mysql            # MySQL shell
ddev sequelace        # Open in Sequel Ace (macOS)
```

## Template Patterns

### Twig Templates Location
```
ee/system/user/templates/default_site/
```

### Layout Pattern
```twig
{# _layouts/base.html.twig #}
<!DOCTYPE html>
<html lang="{{ app.getLocale() }}">
<head>{% block head %}{% endblock %}</head>
<body>
    {% block content %}{% endblock %}
</body>
</html>
```

### Accessing EE Data
```twig
{% for entry in exp.channel.entries({channel: 'pages', url_title: segment_2}) %}
    {{ entry.title }}
    {{ entry.custom_field }}
{% endfor %}
```

## Bilingual Support

This project supports **English** and **French**.

### Translation Files
```
resources/lang/
├── en/
│   └── messages.php
└── fr/
    └── messages.php
```

### Usage in Twig
```twig
{{ __('messages.welcome') }}
```

### Current Locale
```twig
{{ app.getLocale() }}  {# 'en' or 'fr' #}
```

## Important Conventions

1. **Never hardcode strings** - Use translation files
2. **Use DDEV commands** - Prefix with `ddev` (e.g., `ddev artisan`, `ddev ee`)
3. **Follow PSR-12** - PHP coding standards
4. **Accessibility first** - WCAG 2.1 AA compliance required
5. **Mobile-first** - Design for mobile, enhance for desktop
6. **Cache appropriately** - Use Laravel/EE caching for performance

## Testing

```bash
# Run PHP tests
ddev exec ./vendor/bin/phpunit

# Run specific test
ddev exec ./vendor/bin/phpunit --filter TestName
```

## Debugging

### Xdebug (DDEV)
Xdebug is available via DDEV. Use VS Code with PHP Debug extension.

### Twig Debug
```twig
{{ dump(variable) }}
```

### Laravel Debug
```php
dd($variable);      // Dump and die
dump($variable);    // Dump without dying
logger($message);   // Log to storage/logs/laravel.log
```

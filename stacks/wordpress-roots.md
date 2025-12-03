# WordPress Development Standards (Bedrock + Sage)

## Stack Overview
- WordPress managed via Bedrock
- Theme: Sage 10 with Blade templating
- Package management: Composer (PHP), npm/Yarn (assets)
- Build: Bud (Sage 10) or Webpack
- PHP 8.1+

## Directory Structure (Bedrock)
```
project/
├── config/
│   ├── application.php    # Primary config
│   └── environments/      # Environment-specific config
├── web/                   # Document root
│   ├── app/               # wp-content equivalent
│   │   ├── themes/
│   │   │   └── theme-name/  # Sage theme
│   │   ├── plugins/
│   │   ├── mu-plugins/    # Must-use plugins
│   │   └── uploads/       # Media (gitignored)
│   ├── wp/                # WordPress core (gitignored)
│   └── index.php
├── vendor/                # Composer deps (gitignored)
├── composer.json
└── .env                   # Environment config (gitignored)
```

## Sage Theme Structure
```
theme-name/
├── app/
│   ├── Providers/         # Service providers
│   ├── View/
│   │   ├── Composers/     # View composers
│   │   └── Components/    # Blade components
│   ├── filters.php        # WordPress filters
│   ├── setup.php          # Theme setup
│   └── helpers.php        # Helper functions
├── config/                # Theme configuration
├── resources/
│   ├── views/             # Blade templates
│   │   ├── layouts/
│   │   ├── partials/
│   │   ├── components/
│   │   └── sections/
│   ├── scripts/           # JavaScript
│   └── styles/            # CSS/SCSS
├── public/                # Compiled assets (gitignored)
├── bud.config.js          # Build configuration
└── composer.json
```

## Common CLI Commands
```bash
# Composer (run from project root)
composer install
composer update
composer require wpackagist-plugin/plugin-name

# Theme development (run from theme directory)
npm install              # or yarn
npm run dev              # Development build with HMR
npm run build            # Production build

# WP-CLI (if available)
wp cache flush
wp search-replace 'old-domain.com' 'new-domain.com'
wp plugin list
wp acorn optimize        # Sage/Acorn optimization
```

## Blade Templating

### Template Hierarchy
```
resources/views/
├── layouts/
│   └── app.blade.php        # Main layout
├── partials/
│   ├── header.blade.php
│   ├── footer.blade.php
│   └── navigation.blade.php
├── components/
│   ├── button.blade.php
│   └── card.blade.php
├── sections/               # ACF Flexible Content / Blocks
│   ├── hero.blade.php
│   └── text-image.blade.php
├── single.blade.php
├── page.blade.php
├── index.blade.php
├── 404.blade.php
└── front-page.blade.php
```

### Common Patterns
```blade
{{-- Extend layout --}}
@extends('layouts.app')

@section('content')
    <article>
        <h1>{{ $title }}</h1>
        {!! $content !!}
    </article>
@endsection

{{-- Include partials --}}
@include('partials.header')
@include('partials.card', ['post' => $post])

{{-- Components --}}
<x-button href="{{ $url }}" variant="primary">
    {{ $label }}
</x-button>

{{-- Loops --}}
@if($posts->isNotEmpty())
    @foreach($posts as $post)
        @include('partials.card', ['post' => $post])
    @endforeach
@else
    <p>No posts found.</p>
@endif

{{-- ACF Fields --}}
@if($image = get_field('featured_image'))
    <img src="{{ $image['url'] }}" alt="{{ $image['alt'] }}">
@endif

{{-- Flexible Content --}}
@if(have_rows('content_blocks'))
    @while(have_rows('content_blocks')) @php(the_row())
        @includeFirst([
            'sections.' . get_row_layout(),
            'sections.fallback'
        ])
    @endwhile
@endif
```

### View Composers (app/View/Composers/)
```php
namespace App\View\Composers;

use Roots\Acorn\View\Composer;

class Navigation extends Composer
{
    protected static $views = ['partials.navigation'];

    public function with(): array
    {
        return [
            'primary_nav' => wp_get_nav_menu_items('primary-menu') ?: [],
        ];
    }
}
```

## ACF Best Practices
- Use Local JSON for version control (`acf-json/` directory)
- Group fields logically
- Use meaningful field names (snake_case)
- Set appropriate conditional logic
- Consider ACF Blocks for Gutenberg integration

## Plugin Management
- Install plugins via Composer when available (wpackagist)
- Premium plugins: use private repository or commit to `mu-plugins`
- Keep plugins minimal — question every plugin's necessity
- Document required plugins in README

## Environment Configuration
```php
// config/application.php uses DotEnv
// Access via: env('VAR_NAME') or Config::get('key')

// .env example
WP_ENV=development
WP_HOME=https://example.test
WP_SITEURL=${WP_HOME}/wp
DB_NAME=database_name
DB_USER=database_user
DB_PASSWORD=database_password
```

## Security
- Salts/keys in `.env`, never committed
- Disable file editing: `DISALLOW_FILE_EDIT=true`
- Move wp-content: already handled by Bedrock structure
- Use `mu-plugins` for critical functionality

## Deployment
- Run `composer install --no-dev` for production
- Run `npm run build` in theme directory
- Ensure `web/app/uploads` is writable
- Set `WP_ENV=production`

# WordPress Development Standards (Standard/Classic)

## Stack Overview
- WordPress: Standard installation (not Bedrock)
- Theme: Classic PHP templates or Block themes
- Package management: npm (assets), optional Composer
- Build: Vite, Webpack, or Gulp for assets
- PHP 8.0+
- Local development: DDEV recommended

## Directory Structure (Standard WordPress)
```
project/
├── public/                    # Document root (or web/)
│   ├── wp-admin/
│   ├── wp-content/
│   │   ├── themes/
│   │   │   └── theme-name/    # Active theme
│   │   ├── plugins/
│   │   ├── mu-plugins/        # Must-use plugins
│   │   └── uploads/           # Media (gitignored)
│   ├── wp-includes/
│   └── wp-config.php
├── .ddev/                     # DDEV configuration
│   └── config.yaml
├── .gitignore
└── README.md
```

## Theme Structure (Classic Theme)
```
theme-name/
├── assets/
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   └── main.js
│   ├── images/
│   └── fonts/
├── inc/
│   ├── custom-post-types.php  # CPT registrations
│   ├── taxonomies.php         # Custom taxonomies
│   ├── acf-fields.php         # ACF configuration
│   ├── shortcodes.php         # Custom shortcodes
│   └── widgets.php            # Widget registrations
├── template-parts/
│   ├── header/
│   ├── footer/
│   ├── content/
│   │   ├── content.php
│   │   ├── content-page.php
│   │   └── content-none.php
│   └── components/
│       ├── card.php
│       └── button.php
├── templates/
│   ├── template-full-width.php
│   └── template-sidebar.php
├── acf-json/                  # ACF Local JSON
├── style.css                  # Theme header
├── functions.php              # Theme setup
├── index.php
├── header.php
├── footer.php
├── sidebar.php
├── single.php
├── page.php
├── archive.php
├── search.php
├── 404.php
├── front-page.php
├── package.json               # Build tools (optional)
└── screenshot.png
```

## Template Hierarchy

```
Request
   │
   ├── Is Front Page? ─────────────────────────────> front-page.php
   │                                                       │
   ├── Is Home (Blog)? ────────────────────────────> home.php
   │                                                       │
   ├── Is Single Post? ────> single-{post-type}.php > single.php
   │                                                       │
   ├── Is Page? ───────────> page-{slug}.php ──────> page.php
   │                                                       │
   ├── Is Archive? ────────> archive-{post-type}.php > archive.php
   │                                                       │
   ├── Is Category? ───────> category-{slug}.php ──> category.php > archive.php
   │                                                       │
   ├── Is Tag? ────────────> tag-{slug}.php ───────> tag.php > archive.php
   │                                                       │
   ├── Is Search? ─────────────────────────────────> search.php
   │                                                       │
   ├── Is 404? ────────────────────────────────────> 404.php
   │                                                       │
   └── Default ────────────────────────────────────> index.php
```

## Common CLI Commands
```bash
# DDEV Commands
ddev start                    # Start environment
ddev stop                     # Stop environment
ddev ssh                      # SSH into container
ddev xdebug on                # Enable Xdebug
ddev xdebug off               # Disable Xdebug

# WP-CLI (via DDEV)
ddev wp cache flush           # Clear cache
ddev wp rewrite flush         # Flush permalinks
ddev wp plugin list           # List plugins
ddev wp plugin activate name  # Activate plugin
ddev wp theme activate name   # Activate theme
ddev wp db export backup.sql  # Export database
ddev wp db import backup.sql  # Import database
ddev wp search-replace 'old.com' 'new.com'

# Theme Development
npm install                   # Install dependencies
npm run dev                   # Development build
npm run build                 # Production build
npm run watch                 # Watch for changes
```

## WP_Query Patterns

### Basic Query
```php
$args = [
    'post_type'      => 'post',
    'posts_per_page' => 10,
    'orderby'        => 'date',
    'order'          => 'DESC',
];
$query = new WP_Query($args);

if ($query->have_posts()) :
    while ($query->have_posts()) : $query->the_post();
        get_template_part('template-parts/content', get_post_type());
    endwhile;
    wp_reset_postdata();
else :
    get_template_part('template-parts/content', 'none');
endif;
```

### Custom Post Type Query
```php
$args = [
    'post_type'      => 'portfolio',
    'posts_per_page' => -1,
    'meta_key'       => 'featured',
    'meta_value'     => '1',
    'tax_query'      => [
        [
            'taxonomy' => 'portfolio_category',
            'field'    => 'slug',
            'terms'    => 'web-design',
        ],
    ],
];
```

### Pagination
```php
$paged = get_query_var('paged') ?: 1;
$args = [
    'post_type'      => 'post',
    'posts_per_page' => 12,
    'paged'          => $paged,
];
$query = new WP_Query($args);

// After loop
the_posts_pagination([
    'mid_size'  => 2,
    'prev_text' => '&laquo; Previous',
    'next_text' => 'Next &raquo;',
]);
```

## Hooks and Filters

### Action Hooks
```php
// Theme setup
add_action('after_setup_theme', function() {
    add_theme_support('title-tag');
    add_theme_support('post-thumbnails');
    add_theme_support('html5', ['search-form', 'gallery', 'caption']);
    register_nav_menus([
        'primary'   => __('Primary Menu', 'theme'),
        'footer'    => __('Footer Menu', 'theme'),
    ]);
});

// Enqueue assets
add_action('wp_enqueue_scripts', function() {
    $theme = wp_get_theme();
    $version = $theme->get('Version');

    wp_enqueue_style('theme-style', get_stylesheet_uri(), [], $version);
    wp_enqueue_script('theme-script', get_template_directory_uri() . '/assets/js/main.js', [], $version, true);

    // Localize for AJAX
    wp_localize_script('theme-script', 'themeData', [
        'ajaxUrl' => admin_url('admin-ajax.php'),
        'nonce'   => wp_create_nonce('theme_nonce'),
    ]);
});

// Register widgets
add_action('widgets_init', function() {
    register_sidebar([
        'name'          => __('Primary Sidebar', 'theme'),
        'id'            => 'sidebar-primary',
        'before_widget' => '<div id="%1$s" class="widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h3 class="widget-title">',
        'after_title'   => '</h3>',
    ]);
});
```

### Filter Hooks
```php
// Modify excerpt length
add_filter('excerpt_length', fn() => 30);

// Custom excerpt ending
add_filter('excerpt_more', fn() => '&hellip;');

// Add custom body classes
add_filter('body_class', function($classes) {
    if (is_front_page()) {
        $classes[] = 'is-home';
    }
    return $classes;
});

// Modify main query
add_action('pre_get_posts', function($query) {
    if (!is_admin() && $query->is_main_query()) {
        if ($query->is_search()) {
            $query->set('post_type', ['post', 'page', 'portfolio']);
        }
    }
});
```

## Custom Post Types
```php
add_action('init', function() {
    register_post_type('portfolio', [
        'labels' => [
            'name'          => __('Portfolio', 'theme'),
            'singular_name' => __('Portfolio Item', 'theme'),
        ],
        'public'       => true,
        'has_archive'  => true,
        'menu_icon'    => 'dashicons-portfolio',
        'supports'     => ['title', 'editor', 'thumbnail', 'excerpt'],
        'rewrite'      => ['slug' => 'portfolio'],
        'show_in_rest' => true,
    ]);

    register_taxonomy('portfolio_category', 'portfolio', [
        'labels' => [
            'name'          => __('Categories', 'theme'),
            'singular_name' => __('Category', 'theme'),
        ],
        'hierarchical' => true,
        'rewrite'      => ['slug' => 'portfolio-category'],
        'show_in_rest' => true,
    ]);
});
```

## ACF Integration

### Field Access
```php
// Single field
$value = get_field('field_name');

// Sub-field in group
$group = get_field('settings_group');
$color = $group['brand_color'];

// Repeater
if (have_rows('team_members')) :
    while (have_rows('team_members')) : the_row();
        $name = get_sub_field('name');
        $role = get_sub_field('role');
    endwhile;
endif;

// Flexible Content
if (have_rows('content_blocks')) :
    while (have_rows('content_blocks')) : the_row();
        $layout = get_row_layout();
        get_template_part('template-parts/blocks/' . $layout);
    endwhile;
endif;
```

### Options Page
```php
if (function_exists('acf_add_options_page')) {
    acf_add_options_page([
        'page_title' => 'Theme Settings',
        'menu_title' => 'Theme Settings',
        'menu_slug'  => 'theme-settings',
        'capability' => 'edit_posts',
    ]);
}

// Access options
$logo = get_field('site_logo', 'option');
```

## Security Best Practices
- **Escape output**: `esc_html()`, `esc_attr()`, `esc_url()`
- **Sanitize input**: `sanitize_text_field()`, `sanitize_email()`, `absint()`
- **Verify nonces**: `wp_verify_nonce()`, `check_ajax_referer()`
- **Check capabilities**: `current_user_can()`
- **Prepared statements**: `$wpdb->prepare()`

See [wordpress-security.md](../projects/wordpress/rules/wordpress-security.md) for complete security guidelines.

## Performance Optimization
- Use transients for expensive queries
- Implement lazy loading for images
- Minimize database queries in templates
- Cache external API responses
- Use `wp_enqueue_script` with proper dependencies

```php
// Transient caching example
function get_featured_posts() {
    $cached = get_transient('featured_posts');
    if ($cached !== false) {
        return $cached;
    }

    $posts = new WP_Query([
        'post_type'      => 'post',
        'posts_per_page' => 6,
        'meta_key'       => 'featured',
        'meta_value'     => '1',
    ]);

    set_transient('featured_posts', $posts, HOUR_IN_SECONDS);
    return $posts;
}
```

## DDEV Configuration
```yaml
# .ddev/config.yaml
name: project-name
type: wordpress
docroot: public
php_version: "8.2"
webserver_type: nginx-fpm
database:
  type: mariadb
  version: "10.6"

hooks:
  post-start:
    - exec: wp cache flush || true
```

## Deployment Checklist
- [ ] Run production build for assets
- [ ] Verify all plugins are updated
- [ ] Test on staging environment
- [ ] Check error logging is disabled
- [ ] Verify `WP_DEBUG` is false
- [ ] Test forms and functionality
- [ ] Verify SSL certificate
- [ ] Check redirects and permalinks
- [ ] Test caching configuration

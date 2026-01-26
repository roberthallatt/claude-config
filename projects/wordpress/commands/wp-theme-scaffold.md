# /wp-theme-scaffold

Generate WordPress theme files and components.

## Usage

```
/wp-theme-scaffold [component] [name]
```

## Components

### Template Files
- `template <name>` - Create a page template
- `archive <post-type>` - Create archive template for CPT
- `single <post-type>` - Create single template for CPT
- `taxonomy <taxonomy>` - Create taxonomy archive template

### Template Parts
- `part <name>` - Create a template part
- `card <name>` - Create a card component
- `section <name>` - Create a page section

### Custom Post Types
- `cpt <name>` - Register a custom post type
- `taxonomy <name>` - Register a custom taxonomy

### ACF Fields
- `acf-group <name>` - Create ACF field group registration
- `acf-block <name>` - Create ACF Gutenberg block

## Template Examples

### Page Template
```php
<?php
/**
 * Template Name: Custom Template
 * Template Post Type: page
 *
 * @package Theme_Name
 */

get_header();
?>

<main id="primary" class="site-main">
    <?php
    while (have_posts()) :
        the_post();
        ?>
        <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
            <header class="entry-header">
                <?php the_title('<h1 class="entry-title">', '</h1>'); ?>
            </header>

            <div class="entry-content">
                <?php the_content(); ?>
            </div>
        </article>
        <?php
    endwhile;
    ?>
</main>

<?php
get_sidebar();
get_footer();
```

### Custom Post Type
```php
add_action('init', function() {
    register_post_type('project', [
        'labels' => [
            'name'               => _x('Projects', 'post type general name', 'theme'),
            'singular_name'      => _x('Project', 'post type singular name', 'theme'),
            'menu_name'          => _x('Projects', 'admin menu', 'theme'),
            'add_new'            => _x('Add New', 'project', 'theme'),
            'add_new_item'       => __('Add New Project', 'theme'),
            'edit_item'          => __('Edit Project', 'theme'),
            'new_item'           => __('New Project', 'theme'),
            'view_item'          => __('View Project', 'theme'),
            'search_items'       => __('Search Projects', 'theme'),
            'not_found'          => __('No projects found.', 'theme'),
            'not_found_in_trash' => __('No projects found in Trash.', 'theme'),
        ],
        'public'             => true,
        'publicly_queryable' => true,
        'show_ui'            => true,
        'show_in_menu'       => true,
        'show_in_rest'       => true,
        'query_var'          => true,
        'rewrite'            => ['slug' => 'projects'],
        'capability_type'    => 'post',
        'has_archive'        => true,
        'hierarchical'       => false,
        'menu_position'      => 5,
        'menu_icon'          => 'dashicons-portfolio',
        'supports'           => ['title', 'editor', 'thumbnail', 'excerpt', 'custom-fields'],
    ]);
});
```

### Template Part (Card)
```php
<?php
/**
 * Template part for displaying a post card.
 *
 * @package Theme_Name
 */

$classes = ['card'];
if (!empty($args['class'])) {
    $classes[] = $args['class'];
}
?>

<article <?php post_class($classes); ?>>
    <?php if (has_post_thumbnail()) : ?>
        <div class="card__image">
            <?php the_post_thumbnail('card-thumbnail'); ?>
        </div>
    <?php endif; ?>

    <div class="card__content">
        <h3 class="card__title">
            <a href="<?php the_permalink(); ?>">
                <?php the_title(); ?>
            </a>
        </h3>

        <div class="card__excerpt">
            <?php the_excerpt(); ?>
        </div>

        <a href="<?php the_permalink(); ?>" class="card__link">
            <?php esc_html_e('Read More', 'theme'); ?>
        </a>
    </div>
</article>
```

## Your Task

Generate the requested WordPress theme component with proper structure, escaping, and WordPress coding standards.

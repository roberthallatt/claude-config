# WordPress Helper Command

Provides assistance with WP-CLI commands and WordPress development.

## WP-CLI Commands

### Cache Management
```bash
# Flush cache
ddev wp cache flush

# Delete transients
ddev wp transient delete --all

# Clear object cache
ddev wp cache delete
```

### Plugin Management
```bash
# List plugins
ddev wp plugin list

# Install plugin
ddev wp plugin install plugin-name --activate

# Update plugins
ddev wp plugin update --all

# Deactivate plugin
ddev wp plugin deactivate plugin-name
```

### Theme Management
```bash
# List themes
ddev wp theme list

# Activate theme
ddev wp theme activate theme-name

# Update themes
ddev wp theme update --all
```

### Database Operations
```bash
# Export database
ddev wp db export backup.sql

# Import database
ddev wp db import backup.sql

# Run query
ddev wp db query "SELECT * FROM wp_posts LIMIT 5"

# Search and replace
ddev wp search-replace 'https://old.com' 'https://new.com' --all-tables
```

### Content Management
```bash
# Create post
ddev wp post create --post_type=page --post_title="New Page" --post_status=publish

# List posts
ddev wp post list --post_type=post --posts_per_page=10

# Delete post
ddev wp post delete 123 --force
```

### User Management
```bash
# Create user
ddev wp user create username email@example.com --role=editor

# List users
ddev wp user list

# Update user
ddev wp user update 1 --user_pass=newpassword
```

## Sage/Acorn Commands

```bash
# Clear Blade cache
ddev wp acorn view:clear

# Clear all Acorn caches
ddev wp acorn optimize:clear

# Publish vendor assets
ddev wp acorn vendor:publish
```

## Theme Development (Sage)

```bash
# Navigate to theme directory first
cd web/app/themes/theme-name

# Development with hot reload
ddev npm run dev

# Production build
ddev npm run build

# Install dependencies
ddev composer install
ddev npm install
```

## Bedrock Structure

```
project-root/
├── config/
│   ├── application.php    # Main WordPress config
│   └── environments/      # Per-environment config
├── web/
│   ├── app/               # wp-content equivalent
│   │   ├── themes/
│   │   ├── plugins/
│   │   └── uploads/
│   └── wp/                # WordPress core
├── vendor/                # Composer packages
└── composer.json          # Dependencies
```

## Environment Variables

```bash
# .env file
WP_ENV=development
WP_HOME=https://site.test
WP_SITEURL=${WP_HOME}/wp

DB_NAME=wordpress
DB_USER=db
DB_PASSWORD=db
DB_HOST=db
```

## Prompt

When I ask for WordPress help, provide:
1. The correct WP-CLI command with `ddev wp` prefix
2. Blade template patterns for Sage themes
3. Best practices for the task
4. Security considerations

# /wp-helper

WordPress development helper command.

## Usage

```
/wp-helper [task]
```

## Available Tasks

### Database Operations
- `backup` - Export database via WP-CLI
- `import` - Import database backup
- `search-replace <old> <new>` - Search and replace in database

### Plugin Management
- `list-plugins` - List all installed plugins
- `install <plugin>` - Install a plugin
- `activate <plugin>` - Activate a plugin
- `deactivate <plugin>` - Deactivate a plugin

### Theme Operations
- `list-themes` - List installed themes
- `activate <theme>` - Activate a theme

### Cache Operations
- `flush-cache` - Clear all WordPress caches
- `flush-rewrite` - Flush rewrite rules

### User Management
- `list-users` - List all users
- `create-admin <username> <email>` - Create admin user

## Example Commands

```bash
# Backup database
ddev wp db export backup-$(date +%Y%m%d).sql

# Search and replace (dry run first)
ddev wp search-replace 'https://old-domain.com' 'https://new-domain.com' --dry-run
ddev wp search-replace 'https://old-domain.com' 'https://new-domain.com'

# Flush all caches
ddev wp cache flush && ddev wp rewrite flush

# List plugins with status
ddev wp plugin list --status=active

# Install and activate plugin
ddev wp plugin install advanced-custom-fields --activate

# Create test admin
ddev wp user create testadmin test@example.com --role=administrator --user_pass=password
```

## Common WP-CLI Commands

```bash
# Core
ddev wp core version
ddev wp core update
ddev wp core update-db

# Posts
ddev wp post list --post_type=page
ddev wp post delete 123 --force
ddev wp post generate --count=10

# Options
ddev wp option get siteurl
ddev wp option update blogname "New Site Name"

# Transients
ddev wp transient delete --all

# Cron
ddev wp cron event list
ddev wp cron event run --due-now
```

## Your Task

Provide the requested WordPress CLI help or execute the specified operation.

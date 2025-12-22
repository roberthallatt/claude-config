# DDEV Helper Command

Provides assistance with DDEV commands for Craft CMS local development.

## Starting/Stopping

```bash
ddev start          # Start the environment
ddev stop           # Stop the environment
ddev restart        # Restart services
ddev poweroff       # Stop all DDEV projects
```

## Container Access

```bash
ddev ssh            # Access web container shell
ddev ssh -s db      # Access database container
ddev describe       # Show project URLs and services
```

## Craft CLI

```bash
# All Craft commands via DDEV
ddev craft [command]

# Common commands
ddev craft clear-caches/all
ddev craft project-config/apply
ddev craft migrate/all
ddev craft resave/entries
ddev craft update
```

## Package Managers

```bash
# Composer
ddev composer install
ddev composer require vendor/package
ddev composer update

# NPM
ddev npm install
ddev npm run dev
ddev npm run build
```

## Database

```bash
# MySQL shell
ddev mysql

# Export database
ddev export-db > backup.sql.gz

# Import database
ddev import-db < backup.sql.gz

# Open in Sequel Ace (macOS)
ddev sequelace

# Open in TablePlus
ddev tableplus
```

## Logs & Debugging

```bash
# View logs
ddev logs           # Web server logs
ddev logs -s db     # Database logs
ddev logs -f        # Follow logs

# Xdebug
ddev xdebug on
ddev xdebug off
ddev xdebug status
```

## Configuration

```bash
# DDEV config file
.ddev/config.yaml

# Common settings
name: project-name
type: craftcms
docroot: web
php_version: "8.2"
database:
  type: mysql
  version: "8.0"
```

## Troubleshooting

```bash
# Restart with fresh state
ddev restart

# Full rebuild
ddev delete -O && ddev start

# Fix permissions
ddev exec chmod -R 777 storage
ddev exec chmod -R 777 web/cpresources

# Check DDEV status
ddev status
ddev debug
```

## Prompt

When I ask for DDEV help, show the exact commands and explain what they do.
Always use `ddev` prefix - never suggest running php/composer/npm directly.

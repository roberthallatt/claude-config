# DDEV Helper Command

Provides assistance with DDEV commands for WordPress (Bedrock) development.

## Starting/Stopping

```bash
ddev start          # Start environment
ddev stop           # Stop environment
ddev restart        # Restart services
ddev poweroff       # Stop all DDEV projects
```

## Container Access

```bash
ddev ssh            # Access web container
ddev ssh -s db      # Access database container
ddev describe       # Show project info and URLs
```

## WordPress CLI

```bash
ddev wp [command]   # Run WP-CLI command
ddev wp plugin list
ddev wp cache flush
ddev wp db export
```

## Package Managers

```bash
# Composer (project root)
ddev composer install
ddev composer require vendor/package

# NPM (theme directory)
cd web/app/themes/theme-name
ddev npm install
ddev npm run dev
ddev npm run build
```

## Database

```bash
ddev mysql                    # MySQL shell
ddev wp db export backup.sql  # Export database
ddev wp db import backup.sql  # Import database
ddev sequelace                # Open in Sequel Ace
```

## Logs & Debugging

```bash
ddev logs           # Web server logs
ddev logs -f        # Follow logs
ddev xdebug on      # Enable Xdebug
ddev xdebug off     # Disable Xdebug
```

## Prompt

Always use `ddev` prefix for commands. Never suggest running wp/php/composer directly.

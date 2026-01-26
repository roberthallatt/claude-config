---
description: Manage DDEV local development environment for ExpressionEngine
---

# DDEV Helper

Manage your DDEV Docker-based development environment for ExpressionEngine projects.

## Available Operations

1. **start** - Start DDEV environment
2. **stop** - Stop DDEV environment
3. **restart** - Restart DDEV environment
4. **status** - Show DDEV project status
5. **ssh** - SSH into DDEV web container
6. **logs** - View DDEV logs
7. **db-import** - Import database
8. **db-export** - Export database
9. **ee-cli** - Access ExpressionEngine CLI
10. **addon-create** - Create new ExpressionEngine add-on skeleton
11. **composer** - Run Composer commands
12. **npm** - Run npm commands inside DDEV

## Instructions

When the user invokes this command:
1. Ask which operation they want to perform
2. Execute the appropriate DDEV command
3. Show the output
4. Provide next steps if needed

## Common DDEV Commands

### Start/Stop/Restart

**Start DDEV:**
```bash
ddev start
```
- Starts Docker containers
- Initializes database
- Sets up routing
- Shows project URLs

**Stop DDEV:**
```bash
ddev stop
```
- Stops containers (preserves data)
- Frees up system resources

**Restart DDEV:**
```bash
ddev restart
```
- Clean restart of all services
- Useful after config changes

**Check Status:**
```bash
ddev describe
```
- Shows project information
- Container status
- URLs and ports
- Database credentials

### SSH Access

**SSH into Web Container:**
```bash
ddev ssh
```
- Access bash shell inside container
- Run commands in project context
- Navigate to `/var/www/html` (project root)

**Run Single Command:**
```bash
ddev exec [command]
```
- Execute command without SSH session
- Example: `ddev exec ls -la`

### Database Operations

**Import Database:**
```bash
ddev import-db --src=/path/to/backup.sql.gz
```
- Imports database from file
- Supports .sql, .sql.gz, .sql.zip
- Replaces existing database

**Export Database:**
```bash
ddev export-db --file=/path/to/backup.sql.gz
```
- Exports current database
- Creates compressed backup
- Good for backups before changes

**Access MySQL CLI:**
```bash
ddev mysql
```
- Direct MySQL command line access
- Useful for queries and debugging

### ExpressionEngine CLI

**Access EE CLI:**
```bash
ddev ee
```
- Access ExpressionEngine command line
- Run EE management commands

**List Available EE Commands:**
```bash
ddev ee list
```

**Common EE CLI Commands:**
```bash
# Clear caches
ddev ee cache:clear

# Update database
ddev ee update

# Backup database
ddev ee backup:database

# Run migrations
ddev ee migrate
```

### Create Add-on Skeleton

**Generate New Add-on:**
```bash
ddev ee make:addon
```
- Interactive prompts for add-on details
- Creates directory structure
- Generates boilerplate files

**Add-on Creation Process:**
1. Run the command
2. Provide add-on name (e.g., "custom_module")
3. Choose add-on type:
   - Module (most common)
   - Plugin
   - Extension
   - Fieldtype
4. Skeleton created in `system/user/addons/[addon_name]/`

**Example Add-on Structure:**
```
system/user/addons/custom_module/
├── addon.setup.php          # Add-on metadata
├── mcp.custom_module.php    # Control panel
├── mod.custom_module.php    # Module tags
├── upd.custom_module.php    # Installer/updater
└── views/                   # Control panel views
```

### Composer Operations

**Install Dependencies:**
```bash
ddev composer install
```

**Update Dependencies:**
```bash
ddev composer update
```

**Require Package:**
```bash
ddev composer require vendor/package
```

### npm Operations

**Install npm Packages:**
```bash
ddev npm install
```

**Run Build Commands:**
```bash
ddev npm run dev
ddev npm run build
```

**Note:** For projects with package.json in the docroot (e.g., `public/`), you may need to run npm commands from the host for Browser-Sync network access.

### View Logs

**Web Server Logs:**
```bash
ddev logs
```
- Shows Apache/nginx logs
- PHP error logs
- Useful for debugging

**Follow Logs (Live):**
```bash
ddev logs -f
```
- Real-time log viewing
- Press Ctrl+C to exit

**Database Logs:**
```bash
ddev logs -s db
```
- MySQL/MariaDB logs

## Quick Reference

### Daily Workflow

**Morning Start:**
```bash
ddev start
# Wait for containers to start
# Visit your project URL (shown in output)
```

**Work Session:**
```bash
# Make changes to templates/code
# Changes reflect immediately (no restart needed)

# If needed, clear EE cache:
ddev ee cache:clear
```

**End of Day:**
```bash
ddev stop
# Or leave running if you prefer
```

### Database Management

**Backup Before Major Changes:**
```bash
ddev export-db --file=backup-$(date +%Y%m%d).sql.gz
```

**Import Fresh Database:**
```bash
ddev import-db --src=/path/to/production-backup.sql.gz
ddev ee cache:clear
```

### Troubleshooting

**DDEV Not Responding:**
```bash
ddev restart
```

**Port Conflicts:**
```bash
ddev stop
ddev start
# Or change ports in .ddev/config.yaml
```

**Database Connection Issues:**
```bash
ddev restart
ddev describe  # Check database credentials
```

**Clear All Caches:**
```bash
# EE cache
ddev ee cache:clear

# Template cache (if using file-based)
ddev exec rm -rf system/user/cache/*
```

## DDEV Configuration

DDEV configuration is in `.ddev/config.yaml`:

```yaml
name: projectname
type: php
docroot: public
php_version: "8.2"
database:
  type: mariadb
  version: "10.11"
```

## Common Issues

### Issue: "Cannot connect to database"
**Solution:**
```bash
ddev restart
# Or check credentials:
ddev describe
```

### Issue: "Changes not reflecting"
**Solution:**
```bash
# Clear EE cache
ddev ee cache:clear

# Clear browser cache
# Hard reload in browser (Cmd+Shift+R or Ctrl+Shift+R)
```

### Issue: "DDEV commands not found"
**Solution:**
```bash
# Install DDEV: https://ddev.readthedocs.io/en/stable/users/install/
# Or ensure DDEV is in your PATH
```

### Issue: "Port 80/443 already in use"
**Solution:**
```bash
# Stop conflicting services:
sudo apachectl stop  # macOS
sudo service apache2 stop  # Linux

# Or change DDEV ports in .ddev/config.yaml
```

## Best Practices

1. **Always backup database before major changes**
   ```bash
   ddev export-db --file=backup-$(date +%Y%m%d).sql.gz
   ```

2. **Keep DDEV updated**
   ```bash
   ddev version  # Check current version
   # Update via: brew upgrade ddev (macOS) or your package manager
   ```

3. **Use DDEV for all server commands**
   - Don't mix local PHP and DDEV PHP
   - Run EE CLI through `ddev ee`
   - Use `ddev composer` not local composer

4. **Monitor logs when debugging**
   ```bash
   ddev logs -f
   ```

5. **Clear caches after template changes**
   ```bash
   ddev ee cache:clear
   ```

## Project URLs

After `ddev start`, your project is available at the URLs shown in output.

Check URLs anytime with:
```bash
ddev describe
```

Common services:
- **Web**: https://projectname.ddev.site (or custom domain)
- **Database**: Direct connection via `ddev mysql`
- **Mailpit**: https://projectname.ddev.site:8026 (catches all emails)
- **PHPMyAdmin**: Add via `ddev get ddev/ddev-phpmyadmin`

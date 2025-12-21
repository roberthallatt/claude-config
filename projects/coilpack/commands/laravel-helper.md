# Laravel Helper Command

Provides assistance with Laravel commands and patterns in Coilpack projects.

## Common Artisan Commands

### Cache & Config
```bash
# Clear all caches
ddev artisan cache:clear
ddev artisan config:clear
ddev artisan route:clear
ddev artisan view:clear

# Cache for production
ddev artisan config:cache
ddev artisan route:cache
ddev artisan view:cache
```

### Database
```bash
# Migrations
ddev artisan migrate
ddev artisan migrate:status
ddev artisan migrate:rollback
ddev artisan migrate:fresh --seed

# Create migration
ddev artisan make:migration create_tablename_table
ddev artisan make:migration add_column_to_tablename_table
```

### Make Commands
```bash
# Controllers
ddev artisan make:controller ControllerName
ddev artisan make:controller ControllerName --resource
ddev artisan make:controller ControllerName --api

# Models
ddev artisan make:model ModelName
ddev artisan make:model ModelName -mfc  # with migration, factory, controller

# Other
ddev artisan make:middleware MiddlewareName
ddev artisan make:request RequestName
ddev artisan make:command CommandName
ddev artisan make:event EventName
ddev artisan make:listener ListenerName
ddev artisan make:job JobName
ddev artisan make:mail MailName
ddev artisan make:notification NotificationName
```

### Livewire (if installed)
```bash
ddev artisan make:livewire ComponentName
ddev artisan make:livewire Forms/ContactForm
ddev artisan livewire:publish --config
```

### Routes & Info
```bash
# List routes
ddev artisan route:list
ddev artisan route:list --name=api
ddev artisan route:list --path=admin

# Application info
ddev artisan about
ddev artisan env
```

### Queues & Scheduling
```bash
# Queue worker
ddev artisan queue:work
ddev artisan queue:listen
ddev artisan queue:failed
ddev artisan queue:retry all

# Scheduler
ddev artisan schedule:list
ddev artisan schedule:run
```

## Coilpack-Specific

### EE + Laravel Bridge
```bash
# Run EE CLI through Laravel
ddev artisan ee [command]

# Or directly
ddev ee [command]
```

### Environment
- `.env` - Laravel environment config
- `config/` - Laravel configuration files
- `config/coilpack.php` - Coilpack-specific settings

## Directory Structure

```
app/
├── Console/Commands/     # Custom artisan commands
├── Http/
│   ├── Controllers/      # Laravel controllers
│   ├── Middleware/       # HTTP middleware
│   └── Requests/         # Form requests
├── Livewire/            # Livewire components
├── Models/              # Eloquent models
├── Providers/           # Service providers
└── Services/            # Business logic services

routes/
├── web.php              # Web routes
├── api.php              # API routes
└── console.php          # Console routes

lang/
├── en/                  # English translations
└── fr/                  # French translations
```

## Prompt

When I ask for Laravel help, provide:
1. The correct `ddev artisan` command syntax
2. Relevant file locations in Coilpack structure
3. Integration considerations with ExpressionEngine
4. Bilingual support patterns where applicable

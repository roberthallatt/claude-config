# Sensitive File Protection

## Purpose

Prevent accidental exposure of secrets, credentials, and sensitive configuration data during AI-assisted development.

## Files You MUST NEVER Read

The following files and patterns contain sensitive information. **NEVER read, open, display, or include their contents in responses.**

### Environment Files
- `.env`
- `.env.*` (`.env.local`, `.env.production`, `.env.staging`, etc.)
- `.env.example` is safe to read (contains placeholder values only)

### Database & Configuration
- `config/database.php`
- `wp-config.php`
- `system/user/config/config.php` (ExpressionEngine)
- `craft/config/db.php`
- `.ddev/db_snapshots/`
- Any file containing database connection strings

### Authentication & Keys
- `*.key`
- `*.pem`
- `*.p12`
- `*.pfx`
- `*.crt` (private certificates)
- `auth.json` (Composer)
- `.npmrc` (may contain auth tokens)
- `.pypirc`
- `credentials.json`
- `service-account*.json`
- `*-credentials.json`

### Cloud Provider Configs
- `.aws/credentials`
- `.aws/config`
- `gcloud/application_default_credentials.json`
- `.azure/`

### SSH & Git Authentication
- `.ssh/`
- `.gitconfig` (may contain credentials)
- `.git-credentials`
- `.netrc`

### API Keys & Tokens
- Any file with `secret`, `token`, or `apikey` in its name
- `secrets.yml` / `secrets.yaml`
- `vault.yml` / `vault.yaml`

## What To Do Instead

When you need information from sensitive files:

1. **Ask the user** what values they need configured
2. **Reference `.env.example`** or similar template files for structure
3. **Check documentation** for required environment variables
4. **Suggest commands** the user can run themselves (e.g., `ddev describe` for database info)

## Safe Alternatives

| Need | Instead of Reading | Do This |
|------|-------------------|---------|
| DB connection info | `.env` or `config.php` | Ask the user or check `ddev describe` |
| API endpoint URLs | `.env` | Reference `.env.example` for variable names |
| Available config keys | `wp-config.php` | Check `wp-config-sample.php` |
| Server details | `.env.production` | Ask the user for the relevant details |

## Rules Summary

- **NEVER** read files matching the patterns above
- **NEVER** include secrets in code examples or responses
- **NEVER** log, echo, or print sensitive values in scripts
- **ALWAYS** use environment variables for sensitive configuration
- **ALWAYS** verify `.gitignore` includes sensitive file patterns
- **ALWAYS** ask the user when you need information that would be in a sensitive file

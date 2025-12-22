# Setup Script Guide

Comprehensive guide to using `setup-project.sh`.

## Synopsis

```bash
./setup-project.sh [OPTIONS]
```

## Required Options

### --stack=\<name>

Technology stack template to use. Auto-detected when using `--refresh`.

**Available stacks:**
- `expressionengine`
- `coilpack`
- `craftcms`
- `wordpress-roots`
- `nextjs`
- `docusaurus`

### --project=\<path>

Target project directory (absolute or relative path).

## Deployment Options

### --with-gemini

Deploy Gemini Code Assist configuration alongside Claude Code configuration.

Creates:
- `GEMINI.md`
- `.gemini/` directory

### --install-extensions

Automatically install VSCode extensions from `.vscode/extensions.json`.

Requires `code` CLI command. See [VSCode Extensions Guide](vscode-extensions.md).

## Update Options

### --refresh

Update configuration files while preserving customizations.

**Behavior:**
- Auto-detects stack from existing `CLAUDE.md`
- Re-scans project for technology changes
- Updates all configuration files
- Preserves `.claude/` customizations
- Updates VSCode settings

**Example:**
```bash
./setup-project.sh --refresh --project=/path/to/project
```

### --force

Overwrite existing files without prompting.

**Warning:** This will replace all files, including customizations.

### --clean

Remove all existing Claude/Gemini configuration before deploying.

Deletes:
- `CLAUDE.md`, `.claude/`
- `GEMINI.md`, `.gemini/`, `.geminiignore`

Use this for a complete fresh start.

## Advanced Options

### --dry-run

Preview changes without modifying any files.

**Output shows:**
- What would be created
- What would be overwritten
- Detected technologies
- Template variables

**Example:**
```bash
./setup-project.sh --dry-run --stack=expressionengine --project=.
```

### --skip-vscode

Skip VSCode configuration deployment.

Use this if you manage `.vscode/` settings separately or don't use VSCode.

### --with-mcp

Deploy `.mcp.json` for standalone MCP server integration.

**Note:** Most users should use `.vscode/settings.json` or `.gemini/settings.json` for MCP configuration instead.

### --analyze

Generate analysis prompt for Claude to customize configuration.

Outputs a prompt you can paste into Claude to get customization suggestions.

## Project Detection

The script automatically detects:

### DDEV Configuration
- Project name
- Document root
- PHP version
- Database type and version
- Primary URL

### Frontend Technologies
- **Tailwind CSS** - `tailwind.config.js` or npm dependency
- **Foundation** - npm dependency or CDN link
- **SCSS/Sass** - `.scss` files
- **Alpine.js** - `x-data` or `@click` attributes in templates
- **Vanilla JS** - `.js` files without framework imports

### Template Engines
- **ExpressionEngine** - `system/ee/` directory
- **Craft CMS** - `craft` executable
- **Blade** - `.blade.php` files
- **Twig** - `.twig` files

### Content Patterns
- **Bilingual** - French language strings or `lang:` tags
- **Stash add-on** - `exp:stash` tags (ExpressionEngine)
- **Structure add-on** - `exp:structure` tags (ExpressionEngine)

## Examples

### First-Time Setup

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/Users/dev/myproject \
  --with-gemini \
  --install-extensions
```

### Update After Technology Changes

```bash
# Added Tailwind CSS to your project
./setup-project.sh --refresh --project=/Users/dev/myproject
```

### Force Clean Reinstall

```bash
./setup-project.sh \
  --clean \
  --force \
  --stack=craftcms \
  --project=.
```

### Preview Without Changes

```bash
./setup-project.sh \
  --dry-run \
  --stack=nextjs \
  --project=../my-nextjs-app
```

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | Invalid options or missing requirements |
| 2 | Project directory doesn't exist |
| 3 | Stack not found |

## Troubleshooting

### "Unknown option" Error

Make sure to use `=` syntax for values:
```bash
# Correct
--stack=expressionengine

# Incorrect
--stack expressionengine
```

### "stack is required" with --refresh

Your project doesn't have `CLAUDE.md` or it doesn't contain stack information. Specify `--stack=<name>` manually.

### Extensions Not Installing

1. Check if `code` command is available: `code --version`
2. Install VSCode CLI: VSCode → Cmd+Shift+P → "Shell Command: Install 'code' command in PATH"
3. Run manually: `./install-vscode-extensions.sh /path/to/project`

### Technology Not Detected

Detection scans template files only (excluding `node_modules`, `vendor`). If technology isn't detected:
1. Ensure config files are in project root
2. Check template files contain the expected patterns
3. Use `--dry-run` to see detection results

## Next Steps

- **[VSCode Extensions](vscode-extensions.md)** - Extension installation details
- **[Conditional Deployment](conditional-deployment.md)** - Detection logic
- **[Updating Projects](updating-projects.md)** - Update workflows

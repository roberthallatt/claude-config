# VSCode Extensions Guide

Automatic extension installation and syntax recognition configuration.

## Overview

The repository configures VSCode for optimal development experience with:
- **Automatic syntax recognition** for template languages
- **Extension recommendations** tailored to each stack
- **Automated installation** via `install-vscode-extensions.sh`

## Syntax Recognition

Each stack configures `files.associations` in `.vscode/settings.json` to ensure correct syntax highlighting.

### ExpressionEngine / Coilpack

```json
"files.associations": {
  "**/system/user/templates/**/*.html": "ExpressionEngine",
  "**/templates/**/*.html": "ExpressionEngine",
  "*.html": "ExpressionEngine",
  ".env.php": "php"
}
```

**Result:** `.html` template files use ExpressionEngine syntax highlighting instead of plain HTML.

### Craft CMS

```json
"files.associations": {
  "**/templates/**/*.twig": "twig",
  "**/templates/**/*.html": "twig",
  "*.twig": "twig"
}
```

**Result:** `.twig` and template `.html` files use Twig syntax highlighting.

### WordPress/Roots

```json
"files.associations": {
  "**/resources/views/**/*.blade.php": "blade",
  "*.blade.php": "blade",
  ".env": "dotenv"
}
```

**Result:** Blade templates get proper syntax highlighting.

### Next.js / Docusaurus

These stacks use standard file extensions (`.tsx`, `.jsx`, `.md`, `.mdx`) that VSCode recognizes natively.

## Recommended Extensions

Each stack includes `.vscode/extensions.json` with curated extension recommendations.

### ExpressionEngine

```json
{
  "recommendations": [
    "mindpixel-labs.expressionengine",
    "bradlc.vscode-tailwindcss",
    "bmewburn.vscode-intelephense-client",
    "editorconfig.editorconfig"
  ]
}
```

### Craft CMS

```json
{
  "recommendations": [
    "craftcms.craft-cms-twig",
    "whatwedo.twig",
    "bradlc.vscode-tailwindcss",
    "bmewburn.vscode-intelephense-client",
    "editorconfig.editorconfig"
  ]
}
```

### Coilpack (Laravel + EE)

```json
{
  "recommendations": [
    "mindpixel-labs.expressionengine",
    "onecentlin.laravel-blade",
    "whatwedo.twig",
    "bradlc.vscode-tailwindcss",
    "bmewburn.vscode-intelephense-client",
    "editorconfig.editorconfig"
  ]
}
```

### WordPress/Roots

```json
{
  "recommendations": [
    "onecentlin.laravel-blade",
    "bradlc.vscode-tailwindcss",
    "bmewburn.vscode-intelephense-client",
    "editorconfig.editorconfig",
    "wordpresstoolbox.wordpress-toolbox"
  ]
}
```

### Next.js

```json
{
  "recommendations": [
    "bradlc.vscode-tailwindcss",
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "editorconfig.editorconfig"
  ]
}
```

### Docusaurus

```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "editorconfig.editorconfig",
    "yzhang.markdown-all-in-one"
  ]
}
```

## Automatic Installation

### Via Setup Script

```bash
./setup-project.sh \
  --stack=expressionengine \
  --project=/path/to/project \
  --install-extensions
```

The `--install-extensions` flag automatically installs all recommended extensions.

### Standalone Installer

```bash
./install-vscode-extensions.sh /path/to/project
```

Installs extensions from `.vscode/extensions.json` in the specified project.

### From Project Directory

```bash
cd /path/to/project
/path/to/claude-config-repo/install-vscode-extensions.sh .
```

## How It Works

The `install-vscode-extensions.sh` script:

1. Reads `.vscode/extensions.json`
2. Extracts extension IDs
3. Checks which are already installed (`code --list-extensions`)
4. Installs missing extensions (`code --install-extension`)
5. Reports status for each extension

**Output example:**
```
Installing VSCode extensions from .vscode/extensions.json...

  ○ anthonydugois.expressionengine (already installed)
  Installing bradlc.vscode-tailwindcss...
  ✓ bradlc.vscode-tailwindcss installed
  Installing bmewburn.vscode-intelephense-client...
  ✓ bmewburn.vscode-intelephense-client installed

Installation complete:
  Installed: 2
  Skipped:   1

Note: Reload VSCode to activate new extensions
```

## Prerequisites

### VSCode CLI Required

The `code` command must be available in your PATH.

**Installation:**
1. Open VSCode
2. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
3. Type "Shell Command: Install 'code' command in PATH"
4. Select and execute

**Verify:**
```bash
code --version
```

Should output VSCode version information.

## Manual Installation

If automatic installation isn't desired:

1. Open your project in VSCode
2. VSCode will show a notification: "This workspace has extension recommendations"
3. Click "Install All" or "Show Recommendations"
4. Select which extensions to install

Alternatively:
1. Open Extensions panel (`Cmd+Shift+X`)
2. Type `@recommended`
3. Install recommended extensions

## Reload After Installation

After installing extensions, reload VSCode:

**Method 1:**
- `Cmd+Shift+P` → "Developer: Reload Window"

**Method 2:**
- Close and reopen VSCode

## Troubleshooting

### Plain Text Instead of Syntax Highlighting

**Problem:** Template files show as plain text.

**Solution:**
1. Install the required extension (ExpressionEngine, Twig, Blade)
2. Reload VSCode window
3. Close and reopen the template file

### "code: command not found"

**Problem:** VSCode CLI not installed.

**Solution:** Follow Prerequisites section above to install `code` command.

### Extensions Won't Install

**Problem:** Installation fails or hangs.

**Possible causes:**
1. Network connection issues
2. VSCode marketplace temporarily unavailable
3. Conflicting extension versions

**Solutions:**
1. Try manual installation from Extensions panel
2. Check VSCode output panel for errors
3. Update VSCode to latest version

### Different Extension Needed

Edit `.vscode/extensions.json` in your project and run:
```bash
./install-vscode-extensions.sh /path/to/project
```

## Emmet Support

All template languages are configured for Emmet support:

```json
"emmet.includeLanguages": {
  "ExpressionEngine": "html",
  "twig": "html",
  "blade": "html"
}
```

This enables HTML abbreviation expansion in template files.

## Next Steps

- **[Setup Script Guide](setup-script.md)** - Full setup options
- **[Configuration](../getting-started/configuration.md)** - VSCode settings details
- **[Updating Projects](updating-projects.md)** - Add extensions to existing projects

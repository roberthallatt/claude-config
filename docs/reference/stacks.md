# Supported Stacks

Complete reference for all supported technology stacks.

## Stack Overview

| Stack | CMS/Framework | Template Engine | Primary Use Case |
|-------|--------------|-----------------|------------------|
| **expressionengine** | ExpressionEngine 7.x | EE Template Language | Content-heavy websites |
| **coilpack** | Laravel + EE | Blade/Twig/EE | Hybrid apps with CMS |
| **craftcms** | Craft CMS | Twig | Content management |
| **wordpress-roots** | WordPress/Bedrock | Blade (via Sage) | WordPress with modern stack |
| **nextjs** | Next.js | React/TSX | React web applications |
| **docusaurus** | Docusaurus | MDX | Documentation sites |

## ExpressionEngine

**Stack ID:** `expressionengine`

### Technologies

- **CMS:** ExpressionEngine 7.x
- **Template Engine:** ExpressionEngine Template Language
- **PHP:** 8.0+
- **Database:** MySQL/MariaDB

### Rules Included

**Always:**
- `accessibility.md` - WCAG compliance
- `expressionengine-templates.md` - EE template best practices
- `performance.md` - Performance optimization

**Conditional:**
- `tailwind-css.md` - If Tailwind detected
- `alpinejs.md` - If Alpine.js detected
- `bilingual-content.md` - If language/bilingual patterns detected
- `mcp-workflow.md` - If using ExpressionEngine MCP

### Skills Included

- `alpine-component-builder` - Build Alpine.js components
- `ee-stash-optimizer` - Optimize Stash usage
- `ee-template-assistant` - EE template help
- `tailwind-utility-finder` - Find Tailwind utilities

### MCP Support

ExpressionEngine stack includes MCP server for:
- Database queries
- Template analysis
- Add-on management
- Cache operations

Configured in `.vscode/settings.json` and `.gemini/settings.json`:
```json
"gemini.mcpServers": {
  "expressionengine": {
    "type": "stdio",
    "command": "ddev",
    "args": ["ee", "mcp:serve"],
    "cwd": "${workspaceFolder}"
  }
}
```

### VSCode Extensions

- ExpressionEngine (mindpixel-labs.expressionengine)
- Tailwind CSS IntelliSense
- PHP Intelephense
- EditorConfig

### File Associations

```json
"files.associations": {
  "**/system/user/templates/**/*.html": "ExpressionEngine",
  "**/templates/**/*.html": "ExpressionEngine",
  "*.html": "ExpressionEngine"
}
```

## Coilpack

**Stack ID:** `coilpack`

### Technologies

- **Framework:** Laravel + ExpressionEngine hybrid
- **Template Engines:** Blade, Twig, or EE Template Language
- **PHP:** 8.1+
- **Database:** MySQL/MariaDB

### Rules Included

**Always:**
- `accessibility.md`
- `laravel-patterns.md` - Laravel best practices
- `performance.md`

**Conditional:**
- `tailwind-css.md`
- `alpinejs.md`
- `bilingual-content.md`
- `mcp-workflow.md`

### MCP Support

Same as ExpressionEngine (includes EE MCP server).

### VSCode Extensions

- ExpressionEngine
- Laravel Blade (onecentlin.laravel-blade)
- Twig Language
- Tailwind CSS IntelliSense
- PHP Intelephense
- EditorConfig

### File Associations

```json
"files.associations": {
  "**/resources/views/**/*.blade.php": "blade",
  "**/resources/views/**/*.twig": "twig",
  "**/templates/**/*.html": "ExpressionEngine",
  "*.blade.php": "blade",
  "*.twig": "twig"
}
```

## Craft CMS

**Stack ID:** `craftcms`

### Technologies

- **CMS:** Craft CMS 4.x+
- **Template Engine:** Twig
- **PHP:** 8.0+
- **Database:** MySQL/PostgreSQL

### Rules Included

**Always:**
- `accessibility.md`
- `craft-templates.md` - Craft/Twig best practices
- `performance.md`

**Conditional:**
- `tailwind-css.md`
- `alpinejs.md`
- `bilingual-content.md`

### MCP Support

Context7 only (library documentation).

### VSCode Extensions

- Craft CMS Twig (craftcms.craft-cms-twig)
- Twig Language (whatwedo.twig)
- Tailwind CSS IntelliSense
- PHP Intelephense
- EditorConfig

### File Associations

```json
"files.associations": {
  "**/templates/**/*.twig": "twig",
  "**/templates/**/*.html": "twig",
  "*.twig": "twig"
}
```

## WordPress/Roots

**Stack ID:** `wordpress-roots`

### Technologies

- **CMS:** WordPress with Bedrock
- **Theme:** Sage (Laravel Blade templates)
- **PHP:** 8.0+
- **Database:** MySQL/MariaDB

### Rules Included

**Always:**
- `accessibility.md`
- `wordpress-patterns.md` - WordPress/Roots best practices
- `performance.md`

**Conditional:**
- `tailwind-css.md`
- `alpinejs.md`
- `bilingual-content.md`

### MCP Support

Context7 only.

### VSCode Extensions

- Laravel Blade
- Tailwind CSS IntelliSense
- PHP Intelephense
- WordPress Toolbox
- EditorConfig

### File Associations

```json
"files.associations": {
  "**/resources/views/**/*.blade.php": "blade",
  "*.blade.php": "blade",
  ".env": "dotenv"
}
```

## Next.js

**Stack ID:** `nextjs`

### Technologies

- **Framework:** Next.js 14+
- **Language:** TypeScript
- **React:** 18+
- **Node:** 18+

### Rules Included

**Always:**
- `accessibility.md`
- `nextjs-patterns.md` - Next.js best practices
- `performance.md`

**Conditional:**
- `tailwind-css.md`

### MCP Support

Context7 only.

### VSCode Extensions

- Tailwind CSS IntelliSense
- ESLint
- Prettier
- EditorConfig

### File Associations

Uses standard TypeScript/React extensions (`.tsx`, `.ts`, `.jsx`, `.js`).

### Special Settings

```json
"tailwindCSS.experimental.classRegex": [
  ["cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"],
  ["cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"]
]
```

For `cva()` and `cn()` utility functions.

## Docusaurus

**Stack ID:** `docusaurus`

### Technologies

- **Framework:** Docusaurus 3+
- **Language:** TypeScript/JavaScript
- **React:** 18+
- **Node:** 18+

### Rules Included

**Always:**
- `accessibility.md`
- `markdown-content.md` - MDX best practices
- `performance.md`

**Conditional:**
- `tailwind-css.md`

### MCP Support

Context7 only.

### VSCode Extensions

- ESLint
- Prettier
- EditorConfig
- Markdown All in One

### File Associations

Uses standard Markdown extensions (`.md`, `.mdx`).

### Special Settings

```json
"[markdown]": {
  "editor.wordWrap": "on",
  "editor.quickSuggestions": true
}
```

## Detection Logic

### How Stacks Are Detected

During `--refresh`, the stack is read from `CLAUDE.md`:

```markdown
## Stack Configuration
@~/.claude/stacks/expressionengine.md
```

### How Technologies Are Detected

**Tailwind CSS:**
- `tailwind.config.js` exists, OR
- `npm list tailwindcss` succeeds, OR
- CDN link in HTML

**Alpine.js:**
- `x-data` or `@click` attributes in template files

**SCSS/Sass:**
- `.scss` or `.sass` files exist

**Bilingual Content:**
- `user_language` compared to `'en'` or `'fr'`
- `{lang:` ExpressionEngine language tags
- `{% if.*lang` Twig language conditionals
- `@lang` Laravel localization helper

**EE Add-ons:**
- Stash: `{exp:stash` in templates
- Structure: `{exp:structure` in templates

See [Conditional Deployment Guide](../guides/conditional-deployment.md) for detailed detection logic.

## Next Steps

- **[Configuration](../getting-started/configuration.md)** - File structure details
- **[Conditional Deployment](../guides/conditional-deployment.md)** - Detection logic
- **[Project Status](../development/project-status.md)** - Implementation status

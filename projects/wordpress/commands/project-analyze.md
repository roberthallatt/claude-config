# /project-analyze

Analyze this WordPress project and customize the configuration.

## Your Task

Scan this WordPress project to understand its structure and customize the Claude configuration.

## Analysis Steps

### 1. Theme Analysis

Identify the active theme and analyze:
- `wp-content/themes/*/style.css` - Theme info
- `wp-content/themes/*/functions.php` - Theme setup
- Template files and organization
- CSS/JS build setup (if any)

### 2. Plugin Analysis

Check `wp-content/plugins/` for:
- ACF (Advanced Custom Fields)
- Page builders (Elementor, Beaver Builder, etc.)
- E-commerce (WooCommerce)
- Forms plugins
- SEO plugins
- Caching plugins

### 3. Custom Post Types

Look for registered post types in:
- `functions.php`
- `inc/` directory
- Plugin registrations

### 4. Development Setup

Check for:
- `package.json` - Frontend build tools
- `composer.json` - PHP dependencies
- `.ddev/config.yaml` - DDEV configuration
- Build tools (Webpack, Vite, Gulp)

### 5. ACF Configuration

If ACF is present:
- Identify field groups
- Check for local JSON (`acf-json/`)
- Document common field patterns

## Update Configuration

After analysis, update these files with project-specific information:

### CLAUDE.md
- Actual theme name and structure
- Active plugins and their patterns
- Custom post types in use
- Build commands from package.json
- Development workflow

### .claude/rules/
- Add ACF patterns if using ACF
- Add WooCommerce rules if e-commerce
- Add page builder rules if applicable

### .claude/agents/
- Add specialized agents for detected patterns

## Output Format

Provide a summary with:
1. Theme type (classic/block/hybrid)
2. Key plugins detected
3. Custom post types found
4. Frontend build setup
5. Recommended configuration updates

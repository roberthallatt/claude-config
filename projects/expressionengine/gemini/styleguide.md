# ExpressionEngine Project Style Guide

This style guide defines coding standards for ExpressionEngine CMS projects using native EE templates.

## General Principles

- **Readability**: Code should be clear and self-documenting
- **Consistency**: Follow established patterns within the codebase
- **Security**: Never expose credentials, sanitize all user input
- **Performance**: Consider caching (Stash), optimize queries
- **Accessibility**: Follow WCAG 2.1 AA standards for all frontend code
- **Bilingual**: Support English and French where applicable

## ExpressionEngine Templates

### File Organization
```
system/user/templates/default_site/
├── _layouts/               # Layout templates
├── _partials/              # Reusable components
├── _snippets/              # Small reusable code
├── _globals/               # Global variables
└── [template_group]/       # Page templates
    ├── index.html          # Default template
    └── [template].html     # Named templates
```

### Naming Conventions
- Template groups: lowercase with underscores `template_group`
- Templates: lowercase with underscores `template_name.html`
- Prefix layouts/partials with underscore: `_header.html`
- Use `.html` extension for all templates

### Tag Syntax Best Practices
```ee
{!-- Always use the full syntax for complex tags --}
{exp:channel:entries channel="blog" limit="10" status="open"}
    {title}
    {body}
{/exp:channel:entries}

{!-- Use shorthand for simple tags --}
{site_name}
{current_url}

{!-- Always escape user-generated content --}
{title:url_title}
{body:html_entity_decode}
```

### Stash Caching
```ee
{!-- Cache expensive operations --}
{exp:stash:set name="nav_data" save="yes" refresh="60"}
    {exp:channel:entries channel="navigation"}
        ...
    {/exp:channel:entries}
{/exp:stash:set}

{!-- Retrieve cached data --}
{exp:stash:get name="nav_data"}
```

### Layout Pattern
```ee
{!-- In page template --}
{layout="_layouts/main"}

{layout:set name="title"}{title} | {site_name}{/layout:set}
{layout:set name="content"}
    {!-- Page content here --}
{/layout:set}
```

## PHP Standards

### PSR Compliance
- Follow PSR-12 coding style
- Use PSR-4 autoloading for custom add-ons
- Prefer typed properties and return types (PHP 8.0+)

### Naming Conventions
- Classes: `PascalCase`
- Methods/Functions: `camelCase`
- Variables: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE`
- Database columns: `snake_case`

### Add-on Development
```php
<?php
// Follow EE coding standards
// Use ee() service container
$db = ee('db');
$query = ee('db')->select('*')->from('exp_channels');

// Use language files for strings
lang('addon.my_string')
```

### Security
- Always validate and sanitize user input
- Use CSRF tokens for forms
- Escape output in templates
- Use parameterized queries
- Never commit secrets or credentials

## JavaScript Standards

### ES6+ Features
- Use `const` by default, `let` when reassignment needed
- Use arrow functions for callbacks
- Use template literals for string interpolation
- Use destructuring where appropriate
- Use async/await over .then() chains

### Alpine.js
- Keep components small and focused
- Use `x-data` for component state
- Prefer `x-on:` over `@` for clarity in templates
- Use `$refs` sparingly

### Tailwind CSS
- Use utility classes over custom CSS
- Extract components for repeated patterns
- Follow mobile-first responsive design
- Use `@apply` sparingly in CSS files

## HTML Standards

### Semantic Markup
- Use appropriate HTML5 elements (`<article>`, `<nav>`, `<aside>`)
- One `<h1>` per page
- Logical heading hierarchy (h1 → h2 → h3)
- Use `<button>` for actions, `<a>` for navigation

### Accessibility
- All images must have `alt` attributes
- Form inputs must have associated `<label>` elements
- Interactive elements must be keyboard accessible
- Color contrast must meet WCAG AA (4.5:1 for text)
- Use ARIA attributes appropriately

### Bilingual Considerations
- Use `lang` attribute on `<html>` and content switches
- Ensure proper text direction support
- Test layouts with both languages (French often 20% longer)

## Database Guidelines

### Query Optimization
- Use indexes on frequently queried columns
- Avoid SELECT * in production code
- Use EE's Query Builder or Active Record
- Implement pagination for large datasets

### ExpressionEngine Data
- Use channel entries for structured content
- Use categories for taxonomy
- Use relationships for content connections
- Use Grid/Fluid fields for repeating content

## Git Practices

### Commit Messages
- Use present tense: "Add feature" not "Added feature"
- Keep subject line under 50 characters
- Reference issue numbers where applicable

### Branch Naming
- `feature/description` for new features
- `fix/description` for bug fixes
- `hotfix/description` for urgent fixes

## Code Review Focus Areas

When reviewing code, prioritize:
1. **Security vulnerabilities** (SQL injection, XSS, CSRF)
2. **Accessibility issues** (missing alt text, keyboard traps)
3. **Performance concerns** (N+1 queries, missing indexes, uncached loops)
4. **Bilingual support** (hardcoded strings, missing translations)
5. **Code maintainability** (complexity, documentation)

# Coilpack Project Style Guide

This style guide defines coding standards for ExpressionEngine + Laravel + Twig (Coilpack) projects.

## General Principles

- **Readability**: Code should be clear and self-documenting
- **Consistency**: Follow established patterns within the codebase
- **Security**: Never expose credentials, sanitize all user input
- **Performance**: Consider caching, eager loading, and query optimization
- **Accessibility**: Follow WCAG 2.1 AA standards for all frontend code
- **Bilingual**: Support English and French where applicable

## PHP Standards

### PSR Compliance
- Follow PSR-12 coding style
- Use PSR-4 autoloading
- Prefer typed properties and return types (PHP 8.0+)

### Naming Conventions
- Classes: `PascalCase`
- Methods/Functions: `camelCase`
- Variables: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE`
- Database columns: `snake_case`

### Laravel Patterns
- Use dependency injection over facades where practical
- Prefer Eloquent over raw queries
- Use form requests for validation
- Keep controllers thin, move logic to services
- Use resource classes for API responses

### Security
- Always validate and sanitize user input
- Use Laravel's CSRF protection
- Escape output in Blade/Twig templates
- Use parameterized queries (Eloquent handles this)
- Never commit secrets or credentials

## Twig Templates

### File Organization
```
ee/system/user/templates/default_site/
├── _layouts/           # Base layouts
├── _partials/          # Reusable components
├── _includes/          # Small snippets
└── [template_group]/   # Page templates
```

### Naming
- Use lowercase with underscores for files: `my_template.html.twig`
- Prefix partials with underscore: `_header.html.twig`
- Use descriptive, semantic names

### Best Practices
- Keep logic minimal in templates
- Use `{% include %}` for reusable components
- Use `{% extends %}` for layout inheritance
- Escape user content: `{{ variable|e }}`
- Use translation functions for bilingual: `{{ __('messages.key') }}`

### ExpressionEngine Data Access
```twig
{# Prefer explicit parameters #}
{% for entry in exp.channel.entries({
    channel: 'blog',
    limit: 10,
    status: 'open',
    orderby: 'entry_date',
    sort: 'desc'
}) %}
```

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

## ExpressionEngine

### Add-on Development
- Follow EE coding guidelines
- Use `ee()` service container
- Implement proper installation/uninstallation
- Use language files for all user-facing strings

### Template Tags
- Document all parameters
- Handle empty results gracefully
- Provide sensible defaults
- Support pagination where appropriate

### Database
- Use EE's Query Builder or Eloquent
- Never modify core EE tables directly
- Create migrations for schema changes
- Index frequently queried columns

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
3. **Performance concerns** (N+1 queries, missing indexes)
4. **Bilingual support** (hardcoded strings, missing translations)
5. **Code maintainability** (complexity, documentation)

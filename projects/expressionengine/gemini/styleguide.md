# CPS ExpressionEngine Code Style Guide

## Introduction

This style guide outlines coding conventions for ExpressionEngine projects at the Canadian Paediatric Society. These projects use EE's native template engine with HTML-based templates.

## Key Principles

- **Readability**: Code should be easy to understand for all team members
- **Maintainability**: Code should be easy to modify and extend
- **Consistency**: Adhere to consistent style across all projects
- **Performance**: Use Stash caching for optimal performance
- **Security**: Always escape user input
- **Accessibility**: Follow WCAG 2.1 AA guidelines

## PHP Standards

### General
- Follow PSR-12 coding standards
- Use PHP 8.1+ features where appropriate

### Type Hints
- All function parameters must have type hints
- All functions must have return type declarations

### Naming Conventions
- Classes: PascalCase (`MyAddon`)
- Methods/Functions: camelCase (`getUserById`)
- Variables: camelCase (`$userId`)
- Constants: SCREAMING_SNAKE_CASE (`MAX_UPLOAD_SIZE`)

## EE Templates

### File Naming
- Use lowercase for template files: `blog_listing.html`
- Prefix partials/embeds with underscore: `_header.html`
- Use descriptive names that indicate purpose

### Template Structure
- Use EE's `{layout=""}` for inheritance
- Use `{embed=""}` for reusable partials
- Use Stash for caching and data passing
- Keep templates focused and single-purpose

### Tag Syntax
```html
{!-- CORRECT: Use proper EE tag syntax --}
{exp:channel:entries channel="blog" limit="10"}
    <article>{title}</article>
{/exp:channel:entries}

{!-- Use conditionals properly --}
{if logged_in}
    Welcome, {screen_name}!
{/if}
```

### Stash Usage
```html
{!-- Cache expensive queries --}
{exp:stash:set name="nav" save="yes" scope="site" replace="no" refresh="60"}
    {exp:channel:entries channel="pages"}
        <li><a href="{url_title_path='pages'}">{title}</a></li>
    {/exp:channel:entries}
{/exp:stash:set}

{!-- Use the cached data --}
{exp:stash:get name="nav"}
```

### Avoid
- Don't nest channel entries tags deeply
- Don't use `dynamic="no"` unless necessary
- Don't hardcode URLs, use path variables

## CSS/Tailwind

### Utility Classes
- Prefer Tailwind utilities over custom CSS
- Use responsive prefixes: `md:`, `lg:`
- Use state variants: `hover:`, `focus:`

### Custom Components
- Use `@apply` sparingly, prefer utility classes
- Document custom component classes
- Follow BEM naming if custom classes needed

### Accessibility
- Ensure sufficient color contrast
- Use `focus:` states for keyboard navigation
- Test with screen readers

## JavaScript

### Alpine.js
- Prefer Alpine.js for simple interactivity
- Use `x-data` for component state
- Use `x-on` for event handling
- Keep components small and focused

## Security

### Input Validation
- Never trust user input
- Use EE's XSS filtering
- Escape output in templates

### SQL Injection
- Never write raw SQL queries
- Use EE's query builder
- Use parameterized queries

### XSS Prevention
- Escape user content by default
- Use `{variable:attr_safe}` for attributes
- Be careful with raw HTML output

## Git Commits

### Commit Messages
- Use present tense: "Add feature" not "Added feature"
- Be descriptive but concise
- Reference issue numbers when applicable

### Branch Naming
- Feature: `feature/description`
- Bugfix: `fix/description`
- Hotfix: `hotfix/description`

## Code Review Focus Areas

When reviewing code, prioritize:
1. Security vulnerabilities
2. Accessibility issues
3. Performance (Stash caching)
4. Code clarity and maintainability
5. Template organization
6. Proper use of EE patterns

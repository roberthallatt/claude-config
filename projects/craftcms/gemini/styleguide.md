# CPS Craft CMS Code Style Guide

## Introduction

This style guide outlines coding conventions for Craft CMS projects at the Canadian Paediatric Society.

## Key Principles

- **Readability**: Code should be easy to understand
- **Maintainability**: Code should be easy to modify
- **Consistency**: Adhere to consistent style across projects
- **Security**: Always validate and sanitize user input
- **Accessibility**: Follow WCAG 2.1 AA guidelines
- **Performance**: Use eager loading and caching

## PHP Standards

### General
- Follow PSR-12 coding standards
- Use PHP 8.2+ features where appropriate
- Always use strict types: `declare(strict_types=1);`

### Type Hints
- All function parameters must have type hints
- All functions must have return type declarations
- Use nullable types (`?string`) for optional values

### Naming Conventions
- Classes: PascalCase (`PageController`)
- Methods/Functions: camelCase (`getPageById`)
- Variables: camelCase (`$pageId`)
- Constants: SCREAMING_SNAKE_CASE (`MAX_ENTRIES`)

### Craft Specific
- Use Craft's service pattern for business logic
- Prefer Element queries over raw SQL
- Use Project Config for deployment

## Twig Templates

### File Naming
- Use kebab-case for template files: `blog-listing.twig`
- Prefix partials/layouts with underscore: `_header.twig`
- Use descriptive names that indicate purpose

### Structure
- Use `{% extends %}` for layout inheritance
- Use `{% include %}` for reusable partials
- Use `{% embed %}` for components with blocks
- Use `{% block %}` for overridable sections

### Element Queries
```twig
{# CORRECT: Use element queries #}
{% set entries = craft.entries()
    .section('blog')
    .with(['author', 'category'])
    .all() %}

{# CORRECT: Eager load relationships #}
{% set entry = craft.entries()
    .id(entryId)
    .with(['featuredImage', 'relatedPosts'])
    .one() %}
```

### Output Escaping
- All output is auto-escaped by default
- Use `|raw` only when intentionally outputting HTML
- Use `|e('html_attr')` for HTML attributes

## CSS/Tailwind

### Utility Classes
- Prefer Tailwind utilities over custom CSS
- Use responsive prefixes: `md:`, `lg:`
- Use state variants: `hover:`, `focus:`

### Accessibility
- Ensure sufficient color contrast
- Use `focus:` states for keyboard navigation
- Test with screen readers

## JavaScript

### Alpine.js
- Use Alpine.js for interactive components
- Use `x-data` for component state
- Keep components focused and small

## Security

### Input Validation
- Use Craft's validation rules
- Sanitize all user input
- Use CSRF tokens for forms

### Queries
- Always use Element queries or Query Builder
- Never concatenate user input into queries

## Code Review Focus Areas

When reviewing code, prioritize:
1. Security vulnerabilities
2. Performance issues (N+1 queries, missing eager loading)
3. Accessibility compliance
4. Code clarity and maintainability
5. Proper error handling

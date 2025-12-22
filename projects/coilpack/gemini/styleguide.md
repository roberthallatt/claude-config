# CPS Coilpack Code Style Guide

## Introduction

This style guide outlines coding conventions for Coilpack projects at the Canadian Paediatric Society. These projects combine ExpressionEngine CMS with Laravel framework using Twig templating.

## Key Principles

- **Readability**: Code should be easy to understand for all team members
- **Maintainability**: Code should be easy to modify and extend
- **Consistency**: Adhere to consistent style across all projects
- **Security**: Always validate and sanitize user input
- **Accessibility**: Follow WCAG 2.1 AA guidelines
- **Bilingual**: Support English and French content

## PHP Standards

### General
- Follow PSR-12 coding standards
- Use PHP 8.2+ features where appropriate
- Always use strict types: `declare(strict_types=1);`

### Type Hints
- All function parameters must have type hints
- All functions must have return type declarations
- Use nullable types (`?string`) rather than union with null

### Naming Conventions
- Classes: PascalCase (`UserController`)
- Methods/Functions: camelCase (`getUserById`)
- Variables: camelCase (`$userId`)
- Constants: SCREAMING_SNAKE_CASE (`MAX_UPLOAD_SIZE`)

### Laravel Specific
- Use dependency injection over facades when possible
- Use form requests for validation
- Use resource controllers for CRUD operations
- Use Eloquent relationships, avoid raw queries

## Twig Templates

### File Naming
- Use snake_case for template files: `blog_listing.html.twig`
- Prefix partials with underscore: `_header.html.twig`
- Use descriptive names that indicate purpose

### Structure
- Use `{% extends %}` for layout inheritance
- Use `{% include %}` for reusable partials
- Use `{% block %}` for overridable sections
- Keep templates focused and single-purpose

### ExpressionEngine Data Access
```twig
{# CORRECT: Use Coilpack syntax #}
{% for entry in exp.channel.entries({channel: 'blog'}) %}

{# INCORRECT: Don't use legacy EE tags #}
{exp:channel:entries channel="blog"}
```

### Bilingual Patterns
- Always provide both language versions
- Use Laravel's `__()` helper for UI strings
- Use field suffixes for content: `body_en`, `body_fr`

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

### Livewire
- Use Livewire for complex server interactions
- Prefer wire:model.lazy for forms
- Use loading states for better UX

## Security

### Input Validation
- Never trust user input
- Use Laravel validation rules
- Sanitize output with Twig's `|e` filter

### SQL Injection
- Use Eloquent or query builder
- Never concatenate user input into queries
- Use parameterized queries

### XSS Prevention
- Escape output by default
- Use `|raw` filter only when necessary
- Sanitize HTML content before storage

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
3. Bilingual support
4. Performance concerns
5. Code clarity and maintainability
6. Test coverage

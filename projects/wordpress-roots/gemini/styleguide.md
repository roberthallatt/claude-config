# WordPress Roots Code Style Guide

## Key Principles

- **WordPress Standards**: Follow WP coding standards
- **Modern PHP**: Use type hints, return types
- **Blade Templates**: Prefer over raw PHP
- **Security**: Sanitize, escape, validate

## PHP

- Follow WordPress Coding Standards
- Use type hints where possible
- Prefer Blade over raw PHP
- Escape output appropriately

## Blade Templates

- Use layouts and partials
- Keep logic in View Composers
- Escape with {{ }} (auto-escaped)
- Use {!! !!} only for trusted HTML

## CSS/Tailwind

- Utility-first approach
- Mobile-first responsive
- Consistent spacing scale

## JavaScript

- Alpine.js for interactivity
- Keep components focused
- Avoid jQuery when possible

## Security

- Always sanitize input
- Always escape output
- Use nonces for forms
- Validate user capabilities

## Code Review Focus

1. Security vulnerabilities
2. WordPress best practices
3. Accessibility
4. Performance
5. Code clarity

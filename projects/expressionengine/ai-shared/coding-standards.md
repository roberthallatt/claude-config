# Coding Standards

## PHP

- Follow PSR-12 coding standards
- Use 4-space indentation
- Use type hints for all function parameters and return types
- Prefer meaningful variable and method names
- Use early returns to reduce nesting
- Never commit credentials or API keys

## HTML/Templates

- Use 2-space indentation
- Use semantic HTML5 elements
- Always include alt attributes on images
- Use lowercase for element names and attributes
- Quote all attribute values with double quotes

## ExpressionEngine Templates

- Use `.html` extension for templates
- Prefix partials/embeds with underscore: `_header`
- Use Stash for caching and data passing
- Keep templates focused and single-purpose
- Use `disable="categories|member_data|pagination"` when not needed
- Use `dynamic="no"` when URL segments shouldn't affect queries

## CSS/Tailwind

- Use Tailwind utility classes, avoid custom CSS when possible
- Follow mobile-first responsive design
- Use BEM naming for any custom CSS classes
- Keep Tailwind purge configuration updated

## JavaScript

- Use ES6+ features
- Use 2-space indentation
- Use single quotes for strings
- Use Alpine.js for simple interactivity
- Prefer `x-data` components over vanilla JS

## Security Requirements

- Never commit `.env.php` or database credentials
- Use parameterized queries for any custom SQL
- Sanitize all user input before output
- All forms must include CSRF tokens via `{csrf_token}`

## Performance Guidelines

- Cache heavy queries appropriately
- Lazy load images below the fold
- Minimize DOM queries
- Debounce scroll/resize event handlers

## Git Workflow

- Use conventional commits format: type(scope): description
- Write commit messages in imperative mood ("Add feature" not "Added feature")
- Keep commits atomic - one logical change per commit
- When finishing a feature branch: merge to `staging` first, then to `main`
- Delete the feature branch after successful merge to `main`

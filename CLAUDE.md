# Global Development Preferences

## Code Style

### General
- Use 2-space indentation for HTML, CSS, JavaScript, JSON, YAML
- Use 4-space indentation for PHP
- Maximum line length of 120 characters
- Use single quotes for strings in JavaScript/PHP unless interpolation needed
- Always use strict equality (=== and !==) in JavaScript
- Prefer const over let; avoid var entirely
- Use meaningful, descriptive variable and function names — clarity over brevity
- One statement per line; avoid chaining more than 2-3 methods

### HTML
- Use semantic HTML5 elements (nav, main, article, section, aside, footer)
- Always include alt attributes on images — descriptive for content, empty for decorative
- Use lowercase for element names and attributes
- Quote all attribute values with double quotes
- Self-close void elements without slash (e.g., `<img>` not `<img />`)

### CSS
- Prefer modern CSS (custom properties, grid, flexbox) over legacy approaches
- Use BEM naming convention for class names when not using utility framework
- Mobile-first media queries (min-width)
- Logical properties where appropriate (margin-inline, padding-block)
- Group properties: positioning, box model, typography, visual, misc

### JavaScript
- Use ES6+ features (arrow functions, destructuring, template literals, optional chaining)
- Async/await over raw promises where practical
- Early returns to reduce nesting
- Avoid mutating function arguments

### PHP
- Follow PSR-12 coding standards
- Use type declarations for parameters and return types
- Prefer null coalescing (??) and nullsafe operator (?->)
- Use early returns to reduce nesting
- Array short syntax [] not array()

### SQL
- Use uppercase for SQL keywords (SELECT, FROM, WHERE, JOIN)
- Lowercase for table and column names
- Use snake_case for naming
- Always use parameterized queries — never concatenate user input

## Git & Version Control
- Write commit messages in imperative mood ("Add feature" not "Added feature")
- Use conventional commits format: type(scope): description
  - feat: new feature
  - fix: bug fix
  - refactor: code change that neither fixes nor adds
  - docs: documentation only
  - style: formatting, no code change
  - test: adding or updating tests
  - chore: maintenance tasks
- Keep commits atomic — one logical change per commit
- Never commit credentials, API keys, or secrets

## Security Fundamentals
- Sanitize all user input before output
- Use parameterized queries for all database operations
- Escape output appropriate to context (HTML, JS, URL, SQL)
- Never trust client-side validation alone
- Use HTTPS URLs for all external resources
- Set appropriate CORS headers
- Avoid inline JavaScript and CSS where CSP is a concern

## Performance
- Minimize DOM queries; cache references when reused
- Debounce scroll/resize event handlers
- Lazy load images below the fold
- Prefer CSS animations over JavaScript when possible
- Avoid layout thrashing (batch DOM reads, then writes)
- Consider perceived performance, not just actual load time

## Accessibility
- Ensure keyboard navigation works for all interactive elements
- Maintain logical heading hierarchy (h1 → h2 → h3)
- Sufficient color contrast (WCAG AA minimum: 4.5:1 for text)
- Don't rely on color alone to convey information
- Provide visible focus states for interactive elements
- Use ARIA only when native HTML semantics are insufficient

## Documentation & Comments
- Comment the "why," not the "what" — code shows what, comments explain why
- Use JSDoc/PHPDoc for functions: describe parameters, return values, exceptions
- Document non-obvious business logic and edge cases
- Keep README files current with setup instructions
- Include example usage for utility functions

## File Organization
- Group by feature/module rather than file type when project scale warrants
- Keep files focused — if it's doing too many things, split it
- Consistent naming: kebab-case for files, PascalCase for components/classes

## Testing Mindset
- Write testable code: pure functions, dependency injection, single responsibility
- Test behavior, not implementation details
- Cover edge cases and error conditions
- If fixing a bug, write a test that would have caught it

## Working With Claude

### Communication Preferences
- Be direct; skip excessive caveats or preamble
- When showing code changes, show only the relevant diff context unless full file requested
- Explain architectural decisions and tradeoffs briefly
- If multiple valid approaches exist, suggest the most pragmatic one and note alternatives

### Before Making Changes
- Understand existing patterns in the codebase before introducing new ones
- Check for existing utilities/helpers before creating new ones
- Respect established conventions even if different from these defaults
- Ask for clarification on ambiguous requirements rather than assuming

### Error Handling
- When debugging, identify root cause before suggesting fixes
- Explain what went wrong and why the fix works
- Consider related areas that might have the same issue

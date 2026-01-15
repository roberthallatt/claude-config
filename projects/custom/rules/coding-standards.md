# Coding Standards

## General Guidelines

These are baseline coding standards. Run `/project-discover` to generate stack-specific rules.

### Code Style

- Use consistent indentation (2 spaces for JS/HTML/CSS, 4 spaces for Python/PHP)
- Maximum line length of 120 characters
- Use meaningful, descriptive variable and function names
- One statement per line

### Documentation

- Comment the "why," not the "what"
- Document non-obvious business logic
- Keep README files current

### Security

- Never commit credentials or secrets
- Sanitize all user input
- Use parameterized queries for databases
- Validate at system boundaries

### Git Workflow

- Write commit messages in imperative mood
- Use conventional commits: type(scope): description
- Keep commits atomic - one logical change per commit

### Testing

- Write testable code
- Test behavior, not implementation details
- Cover edge cases and error conditions

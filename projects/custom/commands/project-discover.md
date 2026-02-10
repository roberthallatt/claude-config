# /project-discover

Analyze this codebase and generate comprehensive AI assistant configuration.

## Your Task

You are tasked with analyzing this project and generating custom configuration for AI coding assistants. This includes researching best practices for the detected technologies and creating appropriate rules, workflows, and documentation.

## Step 1: Analyze the Codebase

Scan the project and identify:

1. **Project Structure**
   - Directory layout and organization
   - Entry points and main files
   - Configuration files

2. **Languages & Frameworks**
   - Primary programming language(s)
   - Frameworks in use (React, Vue, Laravel, Django, etc.)
   - Template engines (Twig, Blade, EJS, etc.)

3. **Build Tools & Package Managers**
   - npm, yarn, pnpm, composer, pip, cargo, etc.
   - Build tools (Vite, Webpack, esbuild, etc.)
   - Task runners

4. **Testing Setup**
   - Test frameworks (Jest, Vitest, PHPUnit, pytest, etc.)
   - Test file patterns and locations

5. **Code Quality Tools**
   - Linters (ESLint, Pylint, PHP_CodeSniffer)
   - Formatters (Prettier, Black)
   - Type checkers (TypeScript, mypy)

6. **Development Environment**
   - Docker, DDEV, or other containerization
   - Environment configuration (.env files)
   - Local development URLs

## Step 2: Research Best Practices

For each detected technology, research and document:

1. **Coding Standards**
   - Official style guides
   - Community conventions
   - Common patterns

2. **Security Best Practices**
   - OWASP guidelines for the stack
   - Authentication/authorization patterns
   - Input validation approaches

3. **Performance Guidelines**
   - Caching strategies
   - Optimization techniques
   - Common performance pitfalls

4. **Testing Strategies**
   - Recommended test coverage
   - Testing patterns for the framework
   - Mocking and fixture approaches

## Step 3: Generate Configuration

Create or update the following files:

### CLAUDE.md
Update with:
- Accurate project overview
- Complete directory structure
- All development commands
- Framework-specific patterns and examples

### .claude/rules/
Create rules for each detected technology:
- `{framework}-patterns.md` - Framework-specific patterns
- `{language}-standards.md` - Language coding standards
- `testing-guidelines.md` - Testing requirements
- `security-requirements.md` - Security guidelines

### .claude/agents/
Create relevant specialist agents:
- Backend specialist (if applicable)
- Frontend specialist (if applicable)
- Testing specialist
- Security reviewer

### Other AI Assistants
If deployed with --with-all, also update:
- `.github/copilot-instructions.md`
- `AGENTS.md`
- `CONVENTIONS.md`
- `GEMINI.md` and `.gemini/`

## Step 4: Report Findings

After analysis, provide a summary:

```
## Discovery Report

### Detected Stack
- Primary: [framework/language]
- Frontend: [if applicable]
- Database: [if applicable]
- Testing: [frameworks]

### Generated Configuration
- [x] Updated CLAUDE.md
- [x] Created X rules in .claude/rules/
- [x] Created X agents in .claude/agents/
- [x] Updated other AI configs (if applicable)

### Recommendations
1. [Suggested improvements]
2. [Missing configurations to consider]
3. [Best practices to implement]
```

## Notes

- Be thorough but avoid over-engineering
- Focus on patterns already present in the codebase
- Respect existing conventions even if they differ from defaults
- Ask clarifying questions if the project type is ambiguous

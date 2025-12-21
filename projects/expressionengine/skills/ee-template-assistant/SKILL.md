---
name: ee-template-assistant
description: Help with ExpressionEngine template development, syntax, Stash tags, and conditional logic. Use when working with EE templates, template groups, or debugging template rendering issues.
allowed-tools: Read, Grep, Glob
---

# ExpressionEngine Template Assistant

## What This Skill Does

Assists with developing, debugging, and optimizing ExpressionEngine templates including:
- Template syntax and tag usage
- Stash add-on advanced caching and variable management
- Conditional logic and template variables
- Performance optimization with template-level caching
- Bilingual template structure (English/French)

## When to Use This Skill

Ask when you need help with:
- Writing or debugging EE template code
- Understanding Stash tag syntax or behavior
- Implementing template conditionals
- Caching strategies in templates
- Template organization in template groups
- Variable passing between templates

## Key ExpressionEngine Concepts

### Template Structure
Templates are stored in: `/system/user/templates/cyntc/`
- Templates are organized by template groups (home, about, care, etc.)
- Stash add-on manages advanced template caching and variable sharing
- Bilingual support built into template structure

### Common Stash Tags
- `{exp:stash:set}` - Set variables in cache
- `{exp:stash:get}` - Retrieve cached variables
- `{exp:stash:append}` - Append to cached variables
- `{exp:stash:parse}` - Parse templates with cached context

### Template Variables
- `{title}` - Page title
- `{content}` - Main content area
- `{lang}` - Current language (en/fr)
- Structure variables for navigation

## Instructions

1. **For syntax help**: Reference the SYNTAX_GUIDE.md for common tag patterns
2. **For examples**: Check EXAMPLES.md for real-world template patterns
3. **For debugging**: Use Read and Grep to examine template files
4. **For optimization**: Apply Stash best practices from BEST_PRACTICES.md

## Best Practices

- Use Stash caching to reduce database queries
- Keep template files focused on single responsibilities
- Use conditionals to handle bilingual content
- Test template changes with both language versions
- Document custom variables and their scope

## Common Patterns

See EXAMPLES.md for:
- Conditional rendering based on language
- Navigation generation with Structure add-on
- Content blocks with Stash
- File upload integration

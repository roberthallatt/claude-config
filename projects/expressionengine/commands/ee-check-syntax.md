---
description: Check ExpressionEngine template for syntax errors and best practices
---

# ExpressionEngine Template Syntax Checker

Validate an ExpressionEngine template for syntax errors and best practices.

## Instructions

When the user invokes this command:
1. Ask which template file to check
2. Read the template file
3. Validate for:
   - Proper tag closure
   - Correct conditional syntax
   - Valid Stash parameters
   - Proper bilingual structure
   - Brand color usage
   - Accessibility attributes
4. Report findings with line numbers
5. Suggest fixes for any issues found

## Validation Checklist

### Syntax Errors
- [ ] All tags properly closed
- [ ] Conditional blocks complete ({if}...{/if})
- [ ] No mismatched braces
- [ ] Valid parameter syntax
- [ ] Proper quote usage

### Best Practices
- [ ] Bilingual conditionals present
- [ ] Proper indentation (2 spaces)
- [ ] Brand colors used correctly
- [ ] Responsive Tailwind classes
- [ ] Semantic HTML elements
- [ ] Accessibility attributes (alt, aria-*)

### Performance
- [ ] Expensive queries cached
- [ ] Proper Stash scope usage
- [ ] Reasonable TTL values
- [ ] No nested channel:entries (avoid)

### ExpressionEngine Specifics
- [ ] Valid channel names
- [ ] Correct Stash parameters
- [ ] Proper Structure:nav syntax
- [ ] Valid embed paths

## Output Format

```
## Template Validation: [template-name]

### ✅ Passed (5 checks)
- All tags properly closed
- Bilingual structure complete
- Brand colors used correctly
- Responsive design implemented
- Accessibility attributes present

### ⚠️  Warnings (2 issues)
1. Line 45: Consider caching this channel:entries query
   {exp:channel:entries channel="resources"}
   Suggestion: Wrap with Stash caching

2. Line 78: Missing alt attribute on image
   <img src="{image_url}">
   Fix: <img src="{image_url}" alt="{image_title}">

### ❌ Errors (1 issue)
1. Line 92: Unclosed conditional block
   {if lang == 'en'}
     Content here
   {* Missing {/if} *}
   Fix: Add {/if} at line 95

### Recommendations
1. Add Stash caching to improve performance
2. Fix accessibility issues for WCAG compliance
3. Close all conditional blocks properly
```

## Auto-Fix Option

Ask the user if they want Claude to:
1. Show the fixes
2. Apply the fixes automatically
3. Create a backup first

---
name: alpine-component-builder
description: Build interactive components using Alpine.js for the Kids New To Canada site. Use when creating dropdowns, modals, tabs, accordions, or other interactive elements.
allowed-tools: Read, Grep, Glob
---

# Alpine Component Builder

## What This Skill Does

Helps build interactive components using Alpine.js, including:
- Creating dropdowns, modals, and menus
- Building accordions and tabs
- Form interactions and validation
- State management patterns
- Animation and transitions
- Event handling patterns

## When to Use This Skill

Ask when you need help with:
- Creating interactive components
- Managing component state with Alpine
- Handling click events and user interactions
- Building modals or dropdowns
- Creating form interactions
- Debugging Alpine component behavior

## Alpine.js Core Concepts

### Basic Structure
```
x-data: Initialize component state
x-show/x-if: Toggle element visibility
x-on: Attach event listeners
x-bind: Bind attributes to data
x-text: Update text content
```

### Directives Reference
- `x-data="{ isOpen: false }"` - Initialize state
- `@click="isOpen = !isOpen"` - Handle clicks
- `x-show="isOpen"` - Show/hide elements
- `x-bind:class="{ active: isOpen }"` - Conditional classes
- `x-text="message"` - Update text

## Instructions

1. Check PATTERNS.md for component examples
2. Use Alpine's `$watch` for reactivity
3. Initialize state in `x-data`
4. Use `@click` for interactions
5. Combine with Tailwind for styling
6. Test all interactive states

## Best Practices

- Keep components simple and focused
- Use meaningful state variable names
- Leverage Alpine's magic properties ($el, $dispatch, etc.)
- Test keyboard navigation for accessibility
- Use transitions for smooth interactions

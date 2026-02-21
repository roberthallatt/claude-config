---
name: tailwind-utility-finder
description: Find optimal Tailwind CSS utility classes and brand colors for the {{PROJECT_NAME}} site. Use when styling components, creating responsive designs, or applying brand colors.
allowed-tools: Read, Grep, Glob
---

# Tailwind Utility Finder

## What This Skill Does

Helps identify and apply the right Tailwind CSS utilities and brand colors for the project, including:
- Finding optimal utility class combinations
- Applying brand color system
- Creating responsive layouts (mobile-first)
- Responsive design patterns
- Animation and transition utilities

## Project Color System

Brand colors available in Tailwind config:
- `brand-light-green` - Light green accent ({{BRAND_LIGHT_GREEN}})
- `brand-green` - Primary green ({{BRAND_GREEN}})
- `brand-blue` - Primary blue ({{BRAND_BLUE}})
- `brand-orange` - Accent orange ({{BRAND_ORANGE}})

## When to Use This Skill

Ask when you need help with:
- Selecting Tailwind classes for a component
- Building responsive layouts
- Applying brand colors consistently
- Creating animations or transitions
- Optimizing CSS class combinations
- Understanding responsive breakpoints

## Key Tailwind Concepts for This Project

### Responsive Design (Mobile-First)
- `sm:` - 640px
- `md:` - 768px
- `lg:` - 1024px
- `xl:` - 1280px

### Spacing Scale
- Use `px-4` for horizontal padding on containers
- Use `py-8` for vertical padding sections
- Use `gap-4` for grid/flex gaps

### Typography
- Uses `font-sans` for body text
- Heading sizes: `text-2xl`, `text-3xl`, `text-4xl`
- Line heights: `leading-tight`, `leading-normal`, `leading-relaxed`

## Instructions

1. Check BRAND_COLORS.md for color usage guidelines
2. Reference TAILWIND_CLASSES.md for common pattern combinations
3. Always mobile-first: start with base styles, add responsive variants
4. Use brand colors from the defined palette
5. Test responsive design at all breakpoints

## Common Patterns

### Hero Section
```
<section class="bg-brand-green text-white py-12 md:py-20">
  <div class="container mx-auto px-4">
    <h1 class="text-4xl md:text-5xl font-bold mb-4">Heading</h1>
    <p class="text-lg md:text-xl">Description</p>
  </div>
</section>
```

### Button Group (Responsive)
```
<div class="flex flex-col md:flex-row gap-4">
  <button class="bg-brand-green text-white px-6 py-3">Primary</button>
  <button class="border-2 border-brand-blue px-6 py-3">Secondary</button>
</div>
```

### Card Grid (Responsive)
```
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  {* cards here *}
</div>
```

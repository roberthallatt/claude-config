---
description: Generate an Alpine.js interactive component (dropdown, modal, accordion, etc.)
---

# Alpine Component Generator

Generate a ready-to-use Alpine.js component with Tailwind styling.

## Available Component Types

1. **dropdown** - Dropdown menu with click-away
2. **modal** - Modal dialog with overlay
3. **accordion** - Collapsible accordion component
4. **tabs** - Tab switcher component
5. **toggle** - Simple toggle with transitions
6. **form** - Form with validation patterns

## Instructions

When the user invokes this command:
1. Ask which component type they want
2. Ask for a component name (kebab-case)
3. Generate the complete component code
4. Include:
   - Alpine.js state management
   - Tailwind CSS styling with brand colors
   - Accessibility attributes
   - Code comments explaining key parts
5. Show the generated code
6. Explain how to integrate it into their template

## Component Features

All generated components include:
- ✅ Alpine.js reactivity
- ✅ Tailwind brand colors
- ✅ Responsive design
- ✅ Smooth transitions
- ✅ Click-away detection (where applicable)
- ✅ Keyboard navigation support
- ✅ Clear code comments

## Example Usage

After generating a dropdown component named "user-menu":
```html
<!-- Copy this code into your EE template -->
<div x-data="{ isOpen: false }" class="relative">
  <button
    @click="isOpen = !isOpen"
    class="px-4 py-2 bg-brand-green text-white rounded"
  >
    User Menu
  </button>

  <div
    x-show="isOpen"
    @click.away="isOpen = false"
    class="absolute right-0 mt-2 w-48 bg-white rounded shadow-lg"
  >
    <a href="#" class="block px-4 py-2 hover:bg-gray-100">Profile</a>
    <a href="#" class="block px-4 py-2 hover:bg-gray-100">Settings</a>
    <a href="#" class="block px-4 py-2 hover:bg-gray-100">Logout</a>
  </div>
</div>
```

## Customization Tips

After generating, users can customize:
- Colors: Replace `brand-green` with other brand colors
- Sizing: Adjust `px-4 py-2` padding values
- Positioning: Change `right-0` to `left-0` for left-aligned dropdowns
- Content: Replace menu items with their own content

---
description: Run Tailwind CSS build command (development or production)
---

# Tailwind CSS Build

Run the appropriate Tailwind CSS build command based on the environment.

## Commands

### Development Mode (with watch and live reload)
```bash
npm run dev
```
- Watches for file changes (CSS and templates)
- Rebuilds automatically
- Live browser reload with Browser-Sync
- Unminified output for debugging
- Use during active development

### Production Mode (minified)
```bash
npm run build
```
- One-time build
- Minified and optimized
- Removes unused classes
- Use before deployment

## Instructions

When the user invokes this command:
1. Ask if they want development or production mode
2. Run the appropriate npm command
3. Show the output
4. Confirm the CSS was built successfully
5. If errors occur, explain them clearly

## What This Does

1. Processes Tailwind CSS from configuration
2. Compiles `src/main.css` to `public/assets/css/tailwind.css`
3. Applies PostCSS transformations and Tailwind directives
4. Purges unused styles (production only)
5. In dev mode: Starts Browser-Sync for live reload

## Common Issues

- **Build fails**: Check `tailwind.config.js` for syntax errors
- **Styles missing**: Ensure classes are used in template files
- **Watch not working**: Restart `npm run dev`
- **Old styles persisting**: Clear browser cache or hard reload
- **Browser-Sync not working**: Check port 3000 is available

# Project Instructions

## Tech Stack

This is a **Next.js** project using:
- **Next.js** - React framework with App Router
- **TypeScript** - Type-safe JavaScript
- **Tailwind CSS** - Utility-first CSS
- **React** - UI library

## Project Structure

```
project-root/
├── app/                    # App Router pages
├── components/            # React components
├── lib/                   # Utilities
├── hooks/                 # Custom hooks
├── types/                 # TypeScript types
├── public/                # Static assets
└── next.config.js         # Configuration
```

## Development

```bash
npm run dev       # Start dev server
npm run build     # Build for production
npm run lint      # Run linting
```

## Key Conventions

1. **Server Components** - Default, for static content
2. **Client Components** - Use 'use client' for interactivity
3. **TypeScript** - Strict mode, define all types
4. **Tailwind** - Utility classes, mobile-first
5. **Accessibility** - WCAG 2.1 AA compliance

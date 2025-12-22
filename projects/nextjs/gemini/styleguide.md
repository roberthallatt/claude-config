# Next.js Code Style Guide

## Key Principles

- **Type Safety**: Use TypeScript strictly
- **Performance**: Optimize for Core Web Vitals
- **Accessibility**: WCAG 2.1 AA compliance
- **Maintainability**: Clean, readable code

## TypeScript

- Use strict mode
- Define interfaces for all props
- Avoid `any` type
- Use discriminated unions

## React

- Prefer Server Components
- Use 'use client' only when needed
- Extract logic into custom hooks
- Keep components focused

## Styling

- Use Tailwind utility classes
- Mobile-first responsive design
- Consistent spacing scale
- Accessible color contrast

## Performance

- Use next/image for images
- Use next/font for fonts
- Implement loading states
- Configure caching properly

## Code Review Focus

1. Type safety
2. Server vs Client component usage
3. Performance implications
4. Accessibility
5. Error handling

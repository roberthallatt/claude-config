# Next.js Helper Command

Provides assistance with Next.js development patterns and commands.

## Development Commands

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Start production server
npm run start

# Linting
npm run lint

# Type checking
npx tsc --noEmit
```

## App Router Patterns

### Page Components
```tsx
// app/page.tsx - Server Component (default)
export default function HomePage() {
  return <main>Hello World</main>;
}

// With async data fetching
export default async function HomePage() {
  const data = await fetchData();
  return <main>{data.title}</main>;
}
```

### Layouts
```tsx
// app/layout.tsx
export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
```

### Dynamic Routes
```tsx
// app/posts/[slug]/page.tsx
interface Props {
  params: { slug: string };
}

export default async function PostPage({ params }: Props) {
  const post = await getPost(params.slug);
  return <article>{post.content}</article>;
}

// Generate static params
export async function generateStaticParams() {
  const posts = await getPosts();
  return posts.map((post) => ({ slug: post.slug }));
}
```

### Metadata
```tsx
// Static metadata
export const metadata = {
  title: 'Page Title',
  description: 'Page description',
};

// Dynamic metadata
export async function generateMetadata({ params }: Props) {
  const post = await getPost(params.slug);
  return {
    title: post.title,
    description: post.excerpt,
  };
}
```

## Client Components

```tsx
'use client';

import { useState, useEffect } from 'react';

export function InteractiveComponent() {
  const [state, setState] = useState(null);
  
  useEffect(() => {
    // Client-side effects
  }, []);
  
  return <div onClick={() => setState('clicked')}>{state}</div>;
}
```

## API Routes

```tsx
// app/api/posts/route.ts
import { NextResponse } from 'next/server';

export async function GET() {
  const posts = await getPosts();
  return NextResponse.json(posts);
}

export async function POST(request: Request) {
  const body = await request.json();
  const post = await createPost(body);
  return NextResponse.json(post, { status: 201 });
}
```

## Data Fetching

### Server-Side
```tsx
// Cached by default
const data = await fetch('https://api.example.com/data');

// Revalidate every hour
const data = await fetch('https://api.example.com/data', {
  next: { revalidate: 3600 }
});

// No cache
const data = await fetch('https://api.example.com/data', {
  cache: 'no-store'
});
```

### Client-Side with React Query
```tsx
'use client';

import { useQuery } from '@tanstack/react-query';

export function DataComponent() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['data'],
    queryFn: () => fetch('/api/data').then(res => res.json()),
  });
  
  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error</div>;
  return <div>{data.title}</div>;
}
```

## Image Optimization

```tsx
import Image from 'next/image';

<Image
  src="/hero.jpg"
  alt="Hero image"
  width={1200}
  height={600}
  priority // For above-the-fold images
/>
```

## Prompt

When I ask for Next.js help, provide:
1. The correct file location and naming
2. Server vs Client component guidance
3. TypeScript types and interfaces
4. Performance best practices
5. App Router specific patterns

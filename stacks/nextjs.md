# Next.js Development Standards

## Stack Overview
- Framework: Next.js 14+ (App Router)
- React 18+
- TypeScript preferred
- Node.js 18+

## Directory Structure (App Router)
```
project/
├── app/
│   ├── (marketing)/       # Route groups
│   │   ├── page.tsx
│   │   └── about/
│   │       └── page.tsx
│   ├── blog/
│   │   ├── page.tsx       # /blog listing
│   │   └── [slug]/
│   │       └── page.tsx   # /blog/[slug]
│   ├── api/               # API routes
│   │   └── route.ts
│   ├── layout.tsx         # Root layout
│   ├── page.tsx           # Homepage
│   ├── loading.tsx        # Loading UI
│   ├── error.tsx          # Error boundary
│   ├── not-found.tsx      # 404 page
│   └── globals.css
├── components/
│   ├── ui/                # Generic UI components
│   ├── forms/             # Form components
│   └── [feature]/         # Feature-specific
├── lib/
│   ├── api.ts             # API client functions
│   ├── utils.ts           # Utility functions
│   └── constants.ts       # App constants
├── hooks/                 # Custom React hooks
├── types/                 # TypeScript types
├── public/                # Static assets
├── next.config.js
├── tailwind.config.ts
└── tsconfig.json
```

## Common Patterns

### Page Component (Server Component)
```tsx
// app/blog/[slug]/page.tsx
import { notFound } from 'next/navigation';
import { getPost } from '@/lib/api';

interface PageProps {
  params: Promise<{ slug: string }>;
}

export async function generateMetadata({ params }: PageProps) {
  const { slug } = await params;
  const post = await getPost(slug);
  
  if (!post) return {};
  
  return {
    title: post.title,
    description: post.excerpt,
  };
}

export default async function BlogPost({ params }: PageProps) {
  const { slug } = await params;
  const post = await getPost(slug);

  if (!post) {
    notFound();
  }

  return (
    <article>
      <h1>{post.title}</h1>
      <div dangerouslySetInnerHTML={{ __html: post.content }} />
    </article>
  );
}
```

### Client Components
```tsx
'use client';

import { useState } from 'react';

interface CounterProps {
  initialCount?: number;
}

export function Counter({ initialCount = 0 }: CounterProps) {
  const [count, setCount] = useState(initialCount);

  return (
    <button onClick={() => setCount((c) => c + 1)}>
      Count: {count}
    </button>
  );
}
```

### API Routes
```tsx
// app/api/posts/route.ts
import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  const searchParams = request.nextUrl.searchParams;
  const page = searchParams.get('page') ?? '1';
  
  const posts = await fetchPosts({ page: parseInt(page) });

  return NextResponse.json(posts);
}

export async function POST(request: NextRequest) {
  const body = await request.json();
  
  // Validate input
  if (!body.title) {
    return NextResponse.json(
      { error: 'Title is required' },
      { status: 400 }
    );
  }

  const post = await createPost(body);
  return NextResponse.json(post, { status: 201 });
}
```

### Data Fetching
```tsx
// Server Component — direct async/await
async function Posts() {
  // Cached by default in production
  const posts = await fetch('https://api.example.com/posts', {
    next: { revalidate: 60 }, // ISR: revalidate every 60 seconds
  }).then((res) => res.json());

  return <PostList posts={posts} />;
}

// Force dynamic rendering
export const dynamic = 'force-dynamic';

// Static params for SSG
export async function generateStaticParams() {
  const posts = await getPosts();
  return posts.map((post) => ({ slug: post.slug }));
}
```

### Loading and Error States
```tsx
// app/blog/loading.tsx
export default function Loading() {
  return <div className="animate-pulse">Loading...</div>;
}

// app/blog/error.tsx
'use client';

export default function Error({
  error,
  reset,
}: {
  error: Error;
  reset: () => void;
}) {
  return (
    <div>
      <h2>Something went wrong!</h2>
      <button onClick={reset}>Try again</button>
    </div>
  );
}
```

## Component Conventions
- One component per file
- Named exports for components (not default)
- Props interface above component
- Keep components focused and composable
- Colocate component-specific styles/tests

## TypeScript
- Enable strict mode
- Define interfaces for all props
- Use `type` for unions, `interface` for objects/extensible
- Avoid `any` — use `unknown` if type is truly unknown

## Performance
- Use Server Components by default
- Add `'use client'` only when needed (interactivity, hooks, browser APIs)
- Lazy load heavy components with `next/dynamic`
- Optimize images with `next/image`
- Use `loading="lazy"` for below-fold content

## Environment Variables
```bash
# .env.local (gitignored)
DATABASE_URL=postgresql://...
API_SECRET=xxx

# Public vars (exposed to browser)
NEXT_PUBLIC_API_URL=https://api.example.com
```

Access with `process.env.VAR_NAME` (server) or `process.env.NEXT_PUBLIC_VAR` (client).

---
name: ee-stash-optimizer
description: Optimize Stash caching strategy for ExpressionEngine templates. Use when analyzing template performance, designing cache strategies, or debugging caching issues.
allowed-tools: Read, Grep
---

# ExpressionEngine Stash Optimizer

## What This Skill Does

Helps optimize performance through Stash caching including:
- Cache scope strategy (site, user, local)
- TTL (time-to-live) optimization
- Static vs dynamic caching
- Cache invalidation patterns
- Database query reduction
- Performance measurement

## When to Use This Skill

Ask when you need help with:
- Improving template load performance
- Setting up Stash caching strategies
- Determining optimal TTL values
- Understanding cache scopes
- Debugging cache behavior
- Measuring performance improvements

## Stash Caching Concepts

### Cache Scopes
- `site` - Shared across all visitors (fastest)
- `user` - Per-user cache (medium speed)
- `local` - Temporary during page build (fast)

### Static Caching
- `static="yes"` - Cache doesn't change unless manually cleared
- Best for: Navigation, static content blocks
- Use: High-hit components that change infrequently

### TTL Settings
- `ttl="3600"` - 1 hour cache
- `ttl="86400"` - 1 day cache
- `ttl="604800"` - 1 week cache

## Instructions

1. Review BEST_PRACTICES.md for caching strategies
2. Identify high-cost template sections
3. Apply appropriate cache scope and TTL
4. Test performance before/after
5. Monitor cache hit rates
6. Set up cache invalidation

## Common Performance Issues

1. Over-caching static content
2. Under-caching expensive queries
3. Incorrect TTL settings
4. Cache scope mismatches
5. Missing cache invalidation logic

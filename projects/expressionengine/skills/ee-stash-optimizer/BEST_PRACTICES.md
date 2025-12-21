# Stash Caching Best Practices

## Cache Strategy Framework

### Identify Cache Candidates
1. Database-intensive queries
2. Static content blocks
3. Navigation structures
4. Repeated calculations
5. External API calls

### Example Cache Tiers

**Tier 1: Static (cache forever)**
- Main navigation
- Site footer
- Brand assets
- Static pages
```
{exp:stash:set name="main_nav" scope="site" static="yes"}
  {* navigation content *}
{/exp:stash:set}
```

**Tier 2: Long-lived (24 hour cache)**
- Category listings
- Featured resources
- Author bios
```
{exp:stash:set name="resources" scope="site" ttl="86400"}
  {* resource listing *}
{/exp:stash:set}
```

**Tier 3: Medium-lived (1 hour cache)**
- User-specific content
- Current statistics
- Recent posts
```
{exp:stash:set name="user_dashboard" scope="user" ttl="3600"}
  {* user content *}
{/exp:stash:set}
```

**Tier 4: Session (temporary)**
- Form data
- Dynamic calculations
- Request-specific content
```
{exp:stash:set name="temp_data" scope="local"}
  {* temporary data *}
{/exp:stash:set}
```

## Cache Invalidation

### Manual Invalidation
```
{exp:stash:set name="component" action="delete"}
{/exp:stash:set}
```

### Conditional Invalidation (on content update)
```
{if segment_1 == 'update'}
  {* Invalidate affected caches *}
  {exp:stash:set name="featured" action="delete"}
  {/exp:stash:set}
{/if}
```

### Scheduled Invalidation (TTL)
```
{exp:stash:set name="trending" scope="site" ttl="7200"}
  {* 2-hour cache window *}
{/exp:stash:set}
```

## Performance Monitoring

### Before Caching
- Track query count
- Measure load time
- Monitor database load

### After Caching
- Verify cache hit rates
- Measure load time reduction
- Monitor server resources

### Expected Improvements
- 40-60% load time reduction (well-cached pages)
- 70-80% database query reduction
- 30-50% server CPU reduction

## Common Patterns

### Navigation + Site Menu
```
- Cache: static="yes"
- Scope: site
- TTL: Forever (or clear on menu changes)
- Impact: Huge (runs on every page)
```

### Featured Resources Block
```
- Cache: ttl="86400"
- Scope: site
- TTL: 1 day (or clear on publish)
- Impact: High (database query)
```

### Sidebar Widget
```
- Cache: ttl="3600"
- Scope: user
- TTL: 1 hour (changes per user)
- Impact: Medium (user-specific)
```

### Search Results
```
- Cache: ttl="300"
- Scope: local
- TTL: 5 minutes (user query)
- Impact: Low (temporary)
```

## Anti-Patterns to Avoid

1. **Over-caching dynamic content**
   - Don't cache user-specific data with scope="site"
   - Don't cache pages that change frequently

2. **Under-caching expensive queries**
   - Always cache database-intensive operations
   - Cache external API calls

3. **Incorrect scope assignment**
   - Don't use scope="user" for site-wide content
   - Use scope="site" for shared content

4. **Missing cache invalidation**
   - Always plan how to clear cache when data changes
   - Implement TTL-based expiration

5. **Infinite cache lifespans**
   - Always set reasonable TTLs
   - Use static="yes" sparingly for truly static content

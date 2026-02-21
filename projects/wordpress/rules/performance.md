# Performance Optimization Rules

These rules MUST be followed to ensure optimal performance for the {{PROJECT_NAME}} website.

## Database and Caching

### Stash Caching Strategy
- ✅ ALWAYS cache navigation components
- ✅ ALWAYS cache channel:entries queries
- ✅ ALWAYS cache Structure:nav calls
- ✅ Cache expensive computations
- ❌ NEVER run database queries without caching

**Navigation (Critical - Cache Static):**
```html
{* ✅ CORRECT: Static cache - navigation doesn't change often *}
{exp:stash:set name="main_nav" scope="site" static="yes"}
  {exp:structure:nav channel="pages" max_depth="3"}
    <a href="{url}">{title}</a>
  {/exp:structure:nav}
{/exp:stash:set}

{exp:stash:get name="main_nav"}

{* ❌ INCORRECT: No caching - runs on every page load *}
{exp:structure:nav channel="pages" max_depth="3"}
  <a href="{url}">{title}</a>
{/exp:structure:nav}
```

### Cache Scope Rules
- ✅ Use `scope="site"` for content shared by all visitors
- ✅ Use `scope="user"` for user-specific content
- ✅ Use `scope="local"` for temporary page-build data
- ❌ NEVER use wrong scope (causes cache pollution)

**Scope Examples:**
```html
{* Site-wide content (all visitors see same thing) *}
{exp:stash:set name="featured_resources" scope="site" ttl="86400"}
  {exp:channel:entries channel="resources" limit="5"}
    {title}
  {/exp:channel:entries}
{/exp:stash:set}

{* User-specific content (different per user) *}
{exp:stash:set name="user_favorites" scope="user" ttl="3600"}
  {exp:channel:entries entry_id="{user_favorites}"}
    {title}
  {/exp:channel:entries}
{/exp:stash:set}

{* Temporary data (just for this page build) *}
{exp:stash:set name="temp_calculation" scope="local"}
  {* Some computed value *}
{/exp:stash:set}
```

### TTL (Time To Live) Guidelines
- ✅ Use appropriate TTL based on update frequency
- ✅ Set TTL in seconds
- ❌ NEVER cache without TTL unless using `static="yes"`

**TTL Reference:**
```html
{* Static content (never changes) - Use static="yes" *}
{exp:stash:set name="nav" scope="site" static="yes"}

{* Daily updates - 86400 seconds (24 hours) *}
{exp:stash:set name="daily_content" scope="site" ttl="86400"}

{* Hourly updates - 3600 seconds (1 hour) *}
{exp:stash:set name="hourly_content" scope="site" ttl="3600"}

{* Frequently updated - 300 seconds (5 minutes) *}
{exp:stash:set name="frequent_updates" scope="site" ttl="300"}
```

### Query Optimization
- ✅ Use `limit` parameter to restrict results
- ✅ Specify exact fields needed (avoid `*`)
- ✅ Use appropriate channel parameters
- ❌ NEVER run unlimited queries
- ❌ NEVER nest channel:entries tags

**Correct Query:**
```html
{exp:stash:set name="recent_resources" scope="site" ttl="3600"}
  {exp:channel:entries
    channel="resources"
    limit="10"
    orderby="date"
    sort="desc"
    status="open"
  }
    <article>
      <h2>{title}</h2>
      <p>{excerpt}</p>
    </article>
  {/exp:channel:entries}
{/exp:stash:set}
```

**Incorrect Query:**
```html
{* ❌ No caching, no limit *}
{exp:channel:entries channel="resources"}
  {title}
{/exp:channel:entries}
```

## Frontend Performance

### CSS Optimization
- ✅ Run `npm run build` before deployment
- ✅ Minify and purge unused CSS
- ✅ Use Tailwind's PurgeCSS configuration
- ❌ NEVER deploy unminified CSS

**Build Commands:**
```bash
# Development (unminified, watch mode, live reload)
npm run dev

# Production (minified, purged)
npm run build
```

### Image Optimization
- ✅ Compress all images before upload
- ✅ Use appropriate image formats (WebP, JPEG, PNG)
- ✅ Implement lazy loading for below-fold images
- ✅ Use responsive images with srcset
- ❌ NEVER upload uncompressed images

**Lazy Loading:**
```html
<img
  src="/images/resource.jpg"
  alt="Resource description"
  loading="lazy"
  class="rounded-lg"
/>
```

**Responsive Images:**
```html
<img
  srcset="
    /images/hero-small.jpg 640w,
    /images/hero-medium.jpg 1024w,
    /images/hero-large.jpg 1920w
  "
  sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
  src="/images/hero-medium.jpg"
  alt="Hero image"
  loading="lazy"
/>
```

### JavaScript Optimization
- ✅ Load Alpine.js from CDN with defer attribute
- ✅ Minimize custom JavaScript
- ✅ Use Alpine.js for interactivity (no heavy frameworks)
- ❌ NEVER block page rendering with JavaScript

**Script Loading:**
```html
{* ✅ CORRECT: Deferred loading *}
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>

{* ❌ INCORRECT: Blocks rendering *}
<script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

### Font Loading
- ✅ Use `font-display: swap` for Google Fonts
- ✅ Preconnect to font origins
- ✅ Load fonts asynchronously
- ❌ NEVER block rendering with font loading

**Font Loading:**
```html
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
  href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap"
  rel="stylesheet"
  media="print"
  onload="this.media='all'"
/>
```

## Template Performance

### Avoid Nested Queries
- ✅ Use relationships and joins instead of nesting
- ✅ Fetch data once and reuse
- ❌ NEVER nest channel:entries tags

**❌ INCORRECT (Nested Queries - Very Slow):**
```html
{exp:channel:entries channel="categories"}
  {title}
  {exp:channel:entries channel="posts" category="{category_id}"}
    {title}
  {/exp:channel:entries}
{/exp:channel:entries}
```

**✅ CORRECT (Use Relationships):**
```html
{exp:channel:entries channel="posts"}
  {title}
  {categories}
    {category_name}
  {/categories}
{/exp:channel:entries}
```

### Template Parsing
- ✅ Cache parsed templates with Stash
- ✅ Use early parsing for conditionals when possible
- ✅ Minimize template embeds (max 2 levels)
- ❌ NEVER create deep embed chains

### Reduce HTTP Requests
- ✅ Combine CSS files
- ✅ Use CSS sprites for icons (or inline SVG)
- ✅ Minimize external dependencies
- ✅ Use defer/async for scripts

## Resource Hints

### Preconnect
- ✅ Preconnect to third-party origins
- ✅ Use for Google Fonts, CDNs, analytics

```html
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link rel="preconnect" href="https://cdn.jsdelivr.net" />
```

### DNS Prefetch
- ✅ Use for resources loaded later in page

```html
<link rel="dns-prefetch" href="https://www.google-analytics.com" />
```

### Preload
- ✅ Preload critical resources
- ✅ Use sparingly (only critical resources)

```html
<link rel="preload" href="/fonts/inter-var.woff2" as="font" type="font/woff2" crossorigin />
```

## Performance Budgets

### Target Metrics
- Page load time: < 2 seconds
- Time to First Byte (TTFB): < 600ms
- First Contentful Paint (FCP): < 1.8s
- Largest Contentful Paint (LCP): < 2.5s
- Cumulative Layout Shift (CLS): < 0.1
- Database queries per page: < 10

### File Size Limits
- HTML: < 50KB (gzipped)
- CSS: < 50KB (minified, gzipped)
- JavaScript: < 100KB (minified, gzipped)
- Images: < 200KB per image (optimized)
- Total page weight: < 1MB

## Monitoring and Measurement

### Performance Testing
- ✅ Test with Lighthouse in Chrome DevTools
- ✅ Test on slow connections (3G)
- ✅ Monitor Core Web Vitals
- ✅ Check database query counts

**Testing Checklist:**
```
□ Lighthouse score > 90 (Performance)
□ Lighthouse score > 90 (Accessibility)
□ Lighthouse score > 90 (Best Practices)
□ Lighthouse score > 90 (SEO)
□ Database queries < 10 per page
□ Page load < 2 seconds
□ No console errors
```

### Cache Performance
- ✅ Monitor cache hit rates
- ✅ Verify Stash caching is working
- ✅ Check for cache misses

**Verify Caching:**
```html
{* Add debug output in development *}
{if logged_in_member_id}
  <!-- Cache hit: {exp:stash:get name="main_nav" output="yes"} -->
{/if}
```

## Server Configuration

### Apache Optimization
- ✅ Enable Gzip compression
- ✅ Set proper cache headers
- ✅ Enable browser caching
- ✅ Use HTTP/2 if available

**.htaccess (Compression):**
```apache
# Gzip compression
<IfModule mod_deflate.c>
  AddOutputFilterByType DEFLATE text/html text/plain text/css
  AddOutputFilterByType DEFLATE application/javascript application/json
  AddOutputFilterByType DEFLATE text/xml application/xml
</IfModule>

# Browser caching
<IfModule mod_expires.c>
  ExpiresActive On
  ExpiresByType image/jpg "access plus 1 year"
  ExpiresByType image/jpeg "access plus 1 year"
  ExpiresByType image/png "access plus 1 year"
  ExpiresByType image/webp "access plus 1 year"
  ExpiresByType text/css "access plus 1 month"
  ExpiresByType application/javascript "access plus 1 month"
</IfModule>
```

### PHP Configuration
- ✅ Enable OPcache
- ✅ Set appropriate memory limits
- ✅ Configure PHP sessions properly

## Critical Performance Issues

### ⚠️  HIGH PRIORITY (Fix Immediately)
1. **Uncached navigation** - Cache with `static="yes"`
2. **Nested channel:entries** - Refactor to use relationships
3. **No image optimization** - Compress all images
4. **Blocking JavaScript** - Add defer attribute
5. **No CSS minification** - Run `npm run build`

### 🔶 MEDIUM PRIORITY (Fix Soon)
1. **Missing lazy loading** - Add to below-fold images
2. **No font optimization** - Implement font-display: swap
3. **Too many HTTP requests** - Combine resources
4. **Large page weight** - Optimize assets
5. **Missing cache headers** - Configure server

### 🔵 LOW PRIORITY (Optimize When Possible)
1. **Non-critical CSS** - Consider code splitting
2. **Third-party scripts** - Load asynchronously
3. **Unused JavaScript** - Remove dead code
4. **Image formats** - Consider WebP format

## Anti-Patterns to Avoid

### ❌ NEVER Do These:

1. **No caching on navigation**
   ```html
   ❌ {exp:structure:nav channel="pages"}
   ✅ {exp:stash:set name="nav" scope="site" static="yes"}
        {exp:structure:nav channel="pages"}
   ```

2. **Nested queries**
   ```html
   ❌ {exp:channel:entries}
        {exp:channel:entries}
          {* Nested query *}
        {/exp:channel:entries}
      {/exp:channel:entries}
   ```

3. **Unoptimized images**
   ```html
   ❌ <img src="huge-5mb-image.jpg" />
   ✅ <img src="optimized-150kb-image.jpg" loading="lazy" />
   ```

4. **Blocking scripts**
   ```html
   ❌ <script src="script.js"></script>
   ✅ <script defer src="script.js"></script>
   ```

5. **No production CSS build**
   ```bash
   ❌ Deploying with dev output
   ✅ npm run build before deployment
   ```

6. **Missing TTL**
   ```html
   ❌ {exp:stash:set name="content" scope="site"}
   ✅ {exp:stash:set name="content" scope="site" ttl="3600"}
   ```

## Validation Checklist

Before deploying any code:
- [ ] All channel:entries wrapped in Stash caching
- [ ] Navigation cached with static="yes"
- [ ] Appropriate TTL values set
- [ ] No nested queries
- [ ] Images optimized and lazy loaded
- [ ] CSS minified (npm run build executed)
- [ ] Scripts loaded with defer
- [ ] Fonts optimized
- [ ] Lighthouse score > 90 (all categories)
- [ ] Database queries < 10 per page
- [ ] Page load time < 2 seconds
- [ ] No console errors

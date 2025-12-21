---
description: Analyze and optimize Stash caching strategy for a template
---

# Stash Cache Optimizer

Analyze an ExpressionEngine template and suggest Stash caching optimizations.

## Instructions

When the user invokes this command:
1. Ask which template file to optimize
2. Read the template file
3. Analyze for caching opportunities:
   - Database queries (channel:entries, etc.)
   - Navigation components
   - Repeated content blocks
   - Expensive operations
4. Suggest specific Stash caching strategies:
   - Appropriate cache scope (site/user/local)
   - Recommended TTL values
   - Static vs dynamic caching
5. Provide before/after code examples
6. Explain expected performance improvements

## Analysis Checklist

Look for these optimization opportunities:
- [ ] Channel:entries tags without caching
- [ ] Navigation components
- [ ] Structure:nav calls
- [ ] Repeated template parsing
- [ ] External data fetching
- [ ] Complex conditionals
- [ ] Large data loops

## Optimization Tiers

**High Priority** (implement first):
- Navigation menus → `static="yes"`
- Site-wide components → `scope="site" ttl="86400"`
- Channel listings → `scope="site" ttl="3600"`

**Medium Priority**:
- User-specific content → `scope="user" ttl="1800"`
- Dynamic calculations → `scope="local"`

**Low Priority**:
- Already fast operations
- Content that changes frequently

## Output Format

Provide recommendations in this format:

```
## Template: [template-name]

### Issues Found
1. Channel query on line X not cached
2. Navigation component rendered 3 times
3. Heavy computation without caching

### Recommended Changes

#### Change 1: Cache main navigation
**Before:**
{exp:structure:nav channel="pages"}
  ...
{/exp:structure:nav}

**After:**
{exp:stash:set name="main_nav" scope="site" static="yes"}
  {exp:structure:nav channel="pages"}
    ...
  {/exp:structure:nav}
{/exp:stash:set}
{exp:stash:get name="main_nav"}

**Impact:** 80% reduction in navigation queries

### Expected Performance Gains
- Page load: 1200ms → 450ms (62% faster)
- Database queries: 15 → 3 (80% reduction)
- Server CPU: 40% → 15% (63% reduction)
```

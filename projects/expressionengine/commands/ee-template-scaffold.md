---
description: Generate a new ExpressionEngine template file with proper structure and bilingual support
---

# ExpressionEngine Template Scaffold

Create a new template file at `/system/user/templates/cyntc/{template-group}/{template-name}.html` with:

1. Bilingual conditional structure (English/French)
2. Meta tag embed for SEO
3. Main content container with Tailwind classes
4. Proper cache strategy using Stash
5. Navigation component

## Template Structure

Generate a template with the following structure:

```
{if lang == 'en'}
  {embed="_meta_tags" title="[Page Title] - Kids New To Canada"}
{if:else}
  {embed="_meta_tags" title="[Titre de page] - Les enfants nouveaux au Canada"}
{/if}

<main class="container mx-auto px-4 py-8">
  <div class="max-w-3xl mx-auto">
    {if lang == 'en'}
      <h1 class="text-4xl font-bold text-brand-green mb-6">Page Title</h1>
    {if:else}
      <h1 class="text-4xl font-bold text-brand-green mb-6">Titre de page</h1>
    {/if}

    {exp:channel:entries channel="pages" url_title="{segment_2}"}
      <div class="prose max-w-none">
        {body}
      </div>
    {/exp:channel:entries}
  </div>
</main>
```

## Instructions

When the user invokes this command with a template name and group:
1. Ask for template name (kebab-case, e.g., "about-us")
2. Ask for template group (e.g., "about", "resources", "care")
3. Ask for English page title
4. Ask for French page title
5. Generate the complete template file
6. Save to the appropriate directory
7. Show the user the generated file path

## Checklist

- [ ] Bilingual conditionals for both meta tags and content
- [ ] Proper indentation (2 spaces)
- [ ] Tailwind container and responsive classes
- [ ] Brand color usage (text-brand-green for headings)
- [ ] Channel:entries tag for content
- [ ] Proper URL title parameter

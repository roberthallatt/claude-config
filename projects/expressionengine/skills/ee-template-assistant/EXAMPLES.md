# ExpressionEngine Template Examples

## Bilingual Home Page Template

```
{if lang == 'en'}
  {embed="_meta_tags" title="Home - Kids New To Canada"}
{if:else}
  {embed="_meta_tags" title="Accueil - Les enfants nouveaux au Canada"}
{/if}

<main class="container mx-auto px-4 py-8">
  {if lang == 'en'}
    <h1>Welcome to Kids New To Canada</h1>
  {if:else}
    <h1>Bienvenue à Les enfants nouveaux au Canada</h1>
  {/if}

  {exp:channel:entries channel="pages" url_title="index"}
    {body}
  {/exp:channel:entries}
</main>
```

## Cached Navigation Component

```
{exp:stash:set name="main_nav" scope="site" static="yes" ttl="10080"}
  <nav class="navbar">
    {exp:structure:nav channel="pages" max_depth="2"}
      <a href="{url}" class="{if current}active{/if}">
        {title}
      </a>
    {/exp:structure:nav}
  </nav>
{/exp:stash:set}

{exp:stash:get name="main_nav"}
```

## Dynamic Content Block with Stash

```
{exp:stash:set name="hero_section" scope="site"}
  <section class="hero bg-brand-green text-white py-16">
    <div class="container mx-auto">
      <h1 class="text-4xl font-bold">{title}</h1>
      <p class="text-xl mt-4">{subtitle}</p>
    </div>
  </section>
{/exp:stash:set}

{exp:stash:get name="hero_section"}
```

## Conditional Language Switcher

```
{if lang == 'en'}
  {exp:structure:entries url_title="{page_title}" language="fr"}
    <a href="{page_url}">Français</a>
  {/exp:structure:entries}
{if:else}
  {exp:structure:entries url_title="{page_title}" language="en"}
    <a href="{page_url}">English</a>
  {/exp:structure:entries}
{/if}
```

## Stash Best Practices

```
{* Cache heavy database queries *}
{exp:stash:set name="featured_resources" scope="site" ttl="86400"}
  {exp:channel:entries channel="resources" status="open" limit="5"}
    <article class="resource-card">
      <h3>{title}</h3>
      <p>{excerpt}</p>
      <a href="{url}">Learn more</a>
    </article>
  {/exp:channel:entries}
{/exp:stash:set}

{exp:stash:get name="featured_resources"}
```

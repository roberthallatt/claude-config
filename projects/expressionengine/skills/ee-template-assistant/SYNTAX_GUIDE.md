# ExpressionEngine Template Syntax Guide

## Basic Template Tags

### Variables
```
{title}          - Page title
{content}        - Main content area
{lang}           - Current language
{segment_1}      - URL segment
{exp:member:id}  - Current member ID
```

### Conditionals
```
{if lang == 'en'}
  English content
{if:else}
  Français content
{/if}

{if segment_1 == 'about'}
  About page content
{/if}
```

### Loops
```
{exp:channel:entries channel="pages"}
  {title}
  {body}
{/exp:channel:entries}
```

## Stash Add-on Syntax

### Setting Variables
```
{exp:stash:set name="page_title" scope="site"}
  {title}
{/exp:stash:set}
```

### Getting Variables
```
{exp:stash:get name="page_title"}
```

### Appending Content
```
{exp:stash:append name="styles" scope="site"}
  <style>/* additional styles */</style>
{/exp:stash:append}
```

### Parsing with Context
```
{exp:stash:parse template="partial_name" process="inline"}
  {title}
{/exp:stash:parse}
```

## Structure Add-on Syntax

### Navigation Generation
```
{exp:structure:nav
  channel="pages"
  max_depth="3"
  show_all_children="yes"
}
```

## Common Performance Patterns

### Cache Strategy
```
{exp:stash:set name="nav" scope="site" static="yes"}
  {exp:structure:nav}
    {title} - {url}
  {/exp:structure:nav}
{/exp:stash:set}

{exp:stash:get name="nav"}
```

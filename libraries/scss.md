# SCSS Conventions

## File Organization
```
styles/
├── _variables.scss       # Design tokens
├── _mixins.scss          # Reusable mixins
├── _functions.scss       # Custom functions
├── _base.scss            # Reset/normalize, base styles
├── _typography.scss      # Type scale, font styles
├── _utilities.scss       # Helper classes
├── components/
│   ├── _buttons.scss
│   ├── _cards.scss
│   ├── _forms.scss
│   └── _navigation.scss
├── layouts/
│   ├── _header.scss
│   ├── _footer.scss
│   └── _grid.scss
├── pages/
│   ├── _home.scss
│   └── _about.scss
└── main.scss             # Main entry point
```

## Main Entry Point (main.scss)
```scss
// Use @use instead of @import (modern Sass)
@use 'variables' as vars;
@use 'mixins' as mix;
@use 'functions' as fn;

// Base styles
@use 'base';
@use 'typography';

// Components
@use 'components/buttons';
@use 'components/cards';
@use 'components/forms';

// Layouts
@use 'layouts/header';
@use 'layouts/footer';

// Pages
@use 'pages/home';

// Utilities (load last to override)
@use 'utilities';
```

## Variables (_variables.scss)
```scss
// Colors
$color-primary: #0066cc;
$color-primary-dark: #004d99;
$color-primary-light: #3399ff;

$color-secondary: #6c757d;
$color-success: #28a745;
$color-warning: #ffc107;
$color-danger: #dc3545;

$color-text: #212529;
$color-text-muted: #6c757d;
$color-text-light: #adb5bd;

$color-background: #ffffff;
$color-background-alt: #f8f9fa;
$color-border: #dee2e6;

// Typography
$font-family-base: 'Inter', system-ui, -apple-system, sans-serif;
$font-family-heading: 'Poppins', sans-serif;
$font-family-mono: 'Fira Code', monospace;

$font-size-base: 1rem;        // 16px
$font-size-sm: 0.875rem;      // 14px
$font-size-lg: 1.125rem;      // 18px
$font-size-xl: 1.25rem;       // 20px

$line-height-base: 1.5;
$line-height-tight: 1.25;
$line-height-loose: 1.75;

// Spacing (8px base unit)
$spacing-unit: 0.5rem;        // 8px
$spacing-xs: $spacing-unit;   // 8px
$spacing-sm: $spacing-unit * 2;   // 16px
$spacing-md: $spacing-unit * 3;   // 24px
$spacing-lg: $spacing-unit * 4;   // 32px
$spacing-xl: $spacing-unit * 6;   // 48px
$spacing-2xl: $spacing-unit * 8;  // 64px

// Breakpoints
$breakpoint-sm: 576px;
$breakpoint-md: 768px;
$breakpoint-lg: 992px;
$breakpoint-xl: 1200px;
$breakpoint-2xl: 1400px;

// Borders
$border-radius-sm: 0.25rem;
$border-radius: 0.375rem;
$border-radius-lg: 0.5rem;
$border-radius-full: 9999px;

// Shadows
$shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
$shadow: 0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06);
$shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1), 0 2px 4px rgba(0, 0, 0, 0.06);
$shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1), 0 4px 6px rgba(0, 0, 0, 0.05);

// Transitions
$transition-fast: 150ms ease;
$transition-base: 250ms ease;
$transition-slow: 350ms ease;

// Z-index scale
$z-dropdown: 100;
$z-sticky: 200;
$z-fixed: 300;
$z-modal-backdrop: 400;
$z-modal: 500;
$z-tooltip: 600;
```

## Mixins (_mixins.scss)
```scss
// Responsive breakpoints
@mixin respond-to($breakpoint) {
  @if $breakpoint == 'sm' {
    @media (min-width: $breakpoint-sm) { @content; }
  } @else if $breakpoint == 'md' {
    @media (min-width: $breakpoint-md) { @content; }
  } @else if $breakpoint == 'lg' {
    @media (min-width: $breakpoint-lg) { @content; }
  } @else if $breakpoint == 'xl' {
    @media (min-width: $breakpoint-xl) { @content; }
  } @else if $breakpoint == '2xl' {
    @media (min-width: $breakpoint-2xl) { @content; }
  }
}

// Usage: @include respond-to('md') { ... }

// Flexbox shortcuts
@mixin flex-center {
  display: flex;
  align-items: center;
  justify-content: center;
}

@mixin flex-between {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

@mixin flex-column {
  display: flex;
  flex-direction: column;
}

// Truncate text
@mixin truncate($lines: 1) {
  @if $lines == 1 {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  } @else {
    display: -webkit-box;
    -webkit-line-clamp: $lines;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }
}

// Accessible hiding
@mixin visually-hidden {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

// Focus ring
@mixin focus-ring($color: $color-primary) {
  outline: none;
  box-shadow: 0 0 0 3px rgba($color, 0.4);
}

// Aspect ratio (for older browser support)
@mixin aspect-ratio($width, $height) {
  position: relative;
  
  &::before {
    content: '';
    display: block;
    padding-top: calc($height / $width * 100%);
  }
  
  > * {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }
}

// Button reset
@mixin button-reset {
  appearance: none;
  background: none;
  border: none;
  padding: 0;
  margin: 0;
  font: inherit;
  color: inherit;
  cursor: pointer;
}

// Container
@mixin container($max-width: 1200px, $padding: $spacing-md) {
  width: 100%;
  max-width: $max-width;
  margin-left: auto;
  margin-right: auto;
  padding-left: $padding;
  padding-right: $padding;
}
```

## Functions (_functions.scss)
```scss
// Convert px to rem
@function rem($px) {
  @return calc($px / 16) * 1rem;
}

// Convert px to em
@function em($px, $base: 16) {
  @return calc($px / $base) * 1em;
}

// Z-index management
$z-layers: (
  'dropdown': 100,
  'sticky': 200,
  'fixed': 300,
  'modal-backdrop': 400,
  'modal': 500,
  'tooltip': 600
);

@function z($layer) {
  @if map-has-key($z-layers, $layer) {
    @return map-get($z-layers, $layer);
  }
  @warn "Unknown z-index layer: #{$layer}";
  @return null;
}

// Lighten/darken with better control
@function tint($color, $percentage) {
  @return mix(white, $color, $percentage);
}

@function shade($color, $percentage) {
  @return mix(black, $color, $percentage);
}
```

## BEM Naming Convention
```scss
// Block
.card {
  background: white;
  border-radius: $border-radius;
  
  // Element (child)
  &__header {
    padding: $spacing-md;
    border-bottom: 1px solid $color-border;
  }
  
  &__title {
    font-size: $font-size-lg;
    margin: 0;
  }
  
  &__body {
    padding: $spacing-md;
  }
  
  &__footer {
    padding: $spacing-md;
    border-top: 1px solid $color-border;
  }
  
  // Modifier (variation)
  &--featured {
    border: 2px solid $color-primary;
  }
  
  &--horizontal {
    display: flex;
    
    .card__header {
      border-bottom: none;
      border-right: 1px solid $color-border;
    }
  }
}
```

## Nesting Rules
```scss
// Maximum 3 levels deep
.component {
  // Level 1: OK
  
  &__element {
    // Level 2: OK
    
    &:hover {
      // Level 3: OK for pseudo-classes/elements
    }
    
    &--modifier {
      // Level 3: OK for modifiers
    }
  }
}

// Avoid deep nesting like this:
// .component .element .child .grandchild { } // Bad
```

## Modern SCSS (@use and @forward)
```scss
// _colors.scss
$primary: #0066cc;
$secondary: #6c757d;

// _index.scss (barrel file)
@forward 'colors';
@forward 'typography';

// main.scss
@use 'variables' as vars;

.button {
  background: vars.$primary;
}
```

## Best Practices
- Use variables for all repeated values
- Limit nesting to 3 levels maximum
- Use BEM naming convention
- Keep selectors as simple as possible
- Group related properties together
- Comment complex calculations or browser hacks
- Use @use and @forward (not @import — deprecated)
- Prefer native CSS features when well-supported (custom properties, calc)
- Mobile-first media queries
- Avoid !important — fix specificity instead

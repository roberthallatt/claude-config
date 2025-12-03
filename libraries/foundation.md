# Zurb Foundation Conventions

## Version
- Foundation for Sites 6.x
- Use Foundation's Sass source for customization

## Grid System
```html
<!-- XY Grid (recommended) -->
<div class="grid-container">
  <div class="grid-x grid-margin-x">
    <div class="cell small-12 medium-6 large-4">Column</div>
    <div class="cell small-12 medium-6 large-4">Column</div>
    <div class="cell small-12 medium-12 large-4">Column</div>
  </div>
</div>

<!-- Auto-sizing cells -->
<div class="grid-x grid-margin-x">
  <div class="cell auto">Flexible</div>
  <div class="cell shrink">Shrinks to content</div>
</div>

<!-- Responsive gutters -->
<div class="grid-x grid-padding-x small-padding-collapse">

<!-- Vertical alignment -->
<div class="grid-x grid-margin-x align-middle">
<div class="grid-x grid-margin-x align-bottom">

<!-- Horizontal alignment -->
<div class="grid-x grid-margin-x align-center">
<div class="grid-x grid-margin-x align-justify">
<div class="grid-x grid-margin-x align-spaced">
```

## Common Components

### Buttons
```html
<button class="button">Default</button>
<button class="button primary">Primary</button>
<button class="button secondary">Secondary</button>
<button class="button success">Success</button>
<button class="button alert">Alert</button>
<button class="button warning">Warning</button>

<!-- Variations -->
<button class="button secondary hollow">Hollow</button>
<button class="button expanded">Full Width</button>
<button class="button small">Small</button>
<button class="button large">Large</button>
<button class="button disabled" disabled>Disabled</button>

<!-- Button group -->
<div class="button-group">
  <button class="button">One</button>
  <button class="button">Two</button>
  <button class="button">Three</button>
</div>
```

### Callouts
```html
<div class="callout">Default</div>
<div class="callout primary">Primary</div>
<div class="callout secondary">Secondary</div>
<div class="callout success">Success</div>
<div class="callout warning">Warning</div>
<div class="callout alert">Alert</div>

<!-- Closable callout -->
<div class="callout alert" data-closable>
  <p>Alert message</p>
  <button class="close-button" data-close>&times;</button>
</div>
```

### Cards
```html
<div class="card">
  <div class="card-divider">Header</div>
  <img src="...">
  <div class="card-section">
    <h4>Title</h4>
    <p>Content goes here.</p>
  </div>
</div>

<!-- Card with footer -->
<div class="card">
  <div class="card-section">
    <h4>Title</h4>
    <p>Content</p>
  </div>
  <div class="card-divider">
    <button class="button">Action</button>
  </div>
</div>
```

### Forms
```html
<form>
  <label>
    Name
    <input type="text" placeholder="Enter name">
  </label>
  
  <label>
    Email
    <input type="email" placeholder="Enter email">
  </label>
  
  <label>
    Message
    <textarea placeholder="Your message"></textarea>
  </label>
  
  <fieldset class="fieldset">
    <legend>Options</legend>
    <input type="checkbox" id="opt1"><label for="opt1">Option 1</label>
    <input type="checkbox" id="opt2"><label for="opt2">Option 2</label>
  </fieldset>
  
  <button type="submit" class="button primary">Submit</button>
</form>

<!-- Inline form elements -->
<div class="input-group">
  <span class="input-group-label">$</span>
  <input class="input-group-field" type="number">
  <div class="input-group-button">
    <button class="button">Submit</button>
  </div>
</div>
```

### Navigation
```html
<!-- Top Bar -->
<div class="top-bar">
  <div class="top-bar-left">
    <ul class="dropdown menu" data-dropdown-menu>
      <li class="menu-text">Site Title</li>
      <li><a href="#">One</a></li>
      <li><a href="#">Two</a></li>
    </ul>
  </div>
  <div class="top-bar-right">
    <ul class="menu">
      <li><input type="search" placeholder="Search"></li>
      <li><button class="button">Search</button></li>
    </ul>
  </div>
</div>

<!-- Responsive menu -->
<div class="title-bar" data-responsive-toggle="main-menu" data-hide-for="medium">
  <button class="menu-icon" type="button" data-toggle="main-menu"></button>
  <div class="title-bar-title">Menu</div>
</div>

<div class="top-bar" id="main-menu">
  <!-- menu content -->
</div>
```

### Responsive Visibility
```html
<div class="show-for-small-only">Phone only</div>
<div class="show-for-medium">Medium and up</div>
<div class="show-for-large">Large and up</div>
<div class="hide-for-small-only">Hidden on phone</div>
<div class="hide-for-medium">Hidden medium and up</div>
<div class="hide-for-large">Hidden large and up</div>
<div class="show-for-sr">Screen reader only</div>
```

## JavaScript Initialization
```javascript
// Initialize all plugins
$(document).foundation();

// Initialize specific plugin
const accordion = new Foundation.Accordion($('#myAccordion'));

// Plugin options
const dropdown = new Foundation.Dropdown($('#myDropdown'), {
  hover: true,
  hoverDelay: 250
});

// Events
$('#myAccordion').on('down.zf.accordion', function() {
  console.log('Accordion opened');
});
```

## Sass Customization (_settings.scss)
```scss
// Override before importing Foundation
$global-width: 1200px;
$grid-margin-gutters: (
  small: 20px,
  medium: 30px
);
$primary-color: #1779ba;
$secondary-color: #767676;
$success-color: #3adb76;
$warning-color: #ffae00;
$alert-color: #cc4b37;

$body-font-family: 'Open Sans', sans-serif;
$header-font-family: 'Poppins', sans-serif;

$breakpoints: (
  small: 0,
  medium: 640px,
  large: 1024px,
  xlarge: 1200px,
  xxlarge: 1440px,
);

@import 'foundation';
@include foundation-everything;
```

## Best Practices
- Import only needed components to reduce CSS size
- Use mixins for consistent styling patterns
- Prefer built-in breakpoints over custom media queries
- Use Foundation's motion-ui for animations
- Test across breakpoints during development

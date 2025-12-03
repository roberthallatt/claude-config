# HTML5 Best Practices

## Document Structure

### Basic Template
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Page description for SEO (150-160 characters)">
  <title>Page Title — Site Name</title>
  
  <!-- Preconnect to external domains -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  
  <!-- CSS -->
  <link rel="stylesheet" href="/assets/css/main.css">
  
  <!-- Favicon -->
  <link rel="icon" href="/favicon.ico" sizes="32x32">
  <link rel="icon" href="/icon.svg" type="image/svg+xml">
  <link rel="apple-touch-icon" href="/apple-touch-icon.png">
  
  <!-- Open Graph -->
  <meta property="og:title" content="Page Title">
  <meta property="og:description" content="Page description">
  <meta property="og:image" content="https://example.com/og-image.jpg">
  <meta property="og:url" content="https://example.com/page">
  <meta property="og:type" content="website">
  
  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
</head>
<body>
  <header>
    <nav aria-label="Main navigation">...</nav>
  </header>
  
  <main id="main-content">
    <!-- Primary page content -->
  </main>
  
  <footer>...</footer>
  
  <!-- Scripts at end of body -->
  <script src="/assets/js/main.js" defer></script>
</body>
</html>
```

## Semantic Elements

### Page Layout
```html
<body>
  <header>
    <!-- Site header: logo, main nav, search -->
    <nav aria-label="Main navigation">...</nav>
  </header>
  
  <main id="main-content">
    <!-- One <main> per page, primary content -->
    
    <article>
      <!-- Self-contained content: blog post, news article, comment -->
      <header>
        <h1>Article Title</h1>
        <p><time datetime="2024-01-15">January 15, 2024</time></p>
      </header>
      
      <section>
        <!-- Thematic grouping with heading -->
        <h2>Section Title</h2>
        <p>Content...</p>
      </section>
      
      <footer>
        <p>Written by <address><a href="mailto:author@example.com">Author Name</a></address></p>
      </footer>
    </article>
    
    <aside>
      <!-- Tangentially related: sidebar, pull quotes, ads -->
    </aside>
  </main>
  
  <footer>
    <!-- Site footer: copyright, secondary nav, contact -->
    <nav aria-label="Footer navigation">...</nav>
  </footer>
</body>
```

### When to Use What
| Element | Use For |
|---------|---------|
| `<header>` | Introductory content, navigation (page or section) |
| `<nav>` | Major navigation blocks |
| `<main>` | Primary page content (one per page) |
| `<article>` | Self-contained, independently distributable content |
| `<section>` | Thematic grouping of content with a heading |
| `<aside>` | Tangentially related content (sidebars, pull quotes) |
| `<footer>` | Footer for page or section |
| `<figure>` | Self-contained content like images, diagrams, code |
| `<figcaption>` | Caption for a figure |
| `<address>` | Contact information for author/owner |
| `<time>` | Machine-readable date/time |
| `<mark>` | Highlighted/marked text |
| `<details>` | Collapsible content |
| `<summary>` | Summary/heading for details element |

### Avoid Div Soup
```html
<!-- Bad: divs everywhere -->
<div class="header">
  <div class="nav">...</div>
</div>
<div class="content">
  <div class="post">...</div>
</div>

<!-- Good: semantic elements -->
<header>
  <nav aria-label="Main">...</nav>
</header>
<main>
  <article>...</article>
</main>
```

## Headings

### Hierarchy
```html
<!-- Maintain logical heading order -->
<h1>Page Title</h1>              <!-- One h1 per page -->
  <h2>Major Section</h2>
    <h3>Subsection</h3>
      <h4>Sub-subsection</h4>
    <h3>Another Subsection</h3>
  <h2>Another Major Section</h2>

<!-- Don't skip levels -->
<!-- Bad: h1 → h3 (skipped h2) -->
<!-- Good: h1 → h2 → h3 -->
```

### Headings in Sections
```html
<main>
  <h1>Blog</h1>
  
  <article>
    <h2>Post Title</h2>           <!-- Article has its own hierarchy -->
    <p>Intro paragraph...</p>
    
    <section>
      <h3>Section in Post</h3>
      <p>Content...</p>
    </section>
  </article>
  
  <aside>
    <h2>Related Posts</h2>        <!-- Aside can restart at h2 -->
  </aside>
</main>
```

## Images

### Basic Image
```html
<!-- Always include alt text -->
<img src="photo.jpg" alt="Descriptive text of what's in the image">

<!-- Decorative images: empty alt -->
<img src="decorative-border.png" alt="">

<!-- Dimensions help prevent layout shift -->
<img src="photo.jpg" alt="Description" width="800" height="600">

<!-- Lazy loading for below-fold images -->
<img src="photo.jpg" alt="Description" loading="lazy">

<!-- High priority for above-fold images -->
<img src="hero.jpg" alt="Description" fetchpriority="high">
```

### Responsive Images
```html
<!-- srcset for resolution switching -->
<img 
  src="photo-800.jpg"
  srcset="photo-400.jpg 400w,
          photo-800.jpg 800w,
          photo-1200.jpg 1200w"
  sizes="(max-width: 600px) 100vw,
         (max-width: 1200px) 50vw,
         800px"
  alt="Description"
>

<!-- picture for art direction -->
<picture>
  <source media="(min-width: 1200px)" srcset="hero-wide.jpg">
  <source media="(min-width: 768px)" srcset="hero-medium.jpg">
  <img src="hero-mobile.jpg" alt="Description">
</picture>

<!-- picture for format switching -->
<picture>
  <source srcset="photo.avif" type="image/avif">
  <source srcset="photo.webp" type="image/webp">
  <img src="photo.jpg" alt="Description">
</picture>
```

### Figure with Caption
```html
<figure>
  <img src="chart.png" alt="Bar chart showing sales growth from 2020-2024">
  <figcaption>Annual sales figures, 2020-2024. Source: Company reports.</figcaption>
</figure>
```

## Links

### Link Best Practices
```html
<!-- Descriptive link text -->
<!-- Bad -->
<a href="/report.pdf">Click here</a>

<!-- Good -->
<a href="/report.pdf">Download the 2024 Annual Report (PDF, 2.4MB)</a>

<!-- External links -->
<a href="https://example.com" target="_blank" rel="noopener noreferrer">
  External Site
  <span class="visually-hidden">(opens in new tab)</span>
</a>

<!-- Skip link for keyboard users -->
<a href="#main-content" class="skip-link">Skip to main content</a>

<!-- Download link -->
<a href="/files/document.pdf" download>Download Document</a>

<!-- Email link -->
<a href="mailto:contact@example.com">contact@example.com</a>

<!-- Phone link -->
<a href="tel:+16135551234">613-555-1234</a>
```

### Navigation
```html
<nav aria-label="Main navigation">
  <ul>
    <li><a href="/" aria-current="page">Home</a></li>
    <li><a href="/about">About</a></li>
    <li><a href="/services">Services</a></li>
    <li><a href="/contact">Contact</a></li>
  </ul>
</nav>

<!-- Breadcrumbs -->
<nav aria-label="Breadcrumb">
  <ol>
    <li><a href="/">Home</a></li>
    <li><a href="/products">Products</a></li>
    <li><a href="/products/widgets" aria-current="page">Widgets</a></li>
  </ol>
</nav>
```

## Forms

### Accessible Form Structure
```html
<form action="/submit" method="POST">
  <!-- Always associate labels with inputs -->
  <div class="form-group">
    <label for="name">Full Name <span aria-hidden="true">*</span></label>
    <input 
      type="text" 
      id="name" 
      name="name" 
      required
      autocomplete="name"
      aria-required="true"
    >
  </div>
  
  <div class="form-group">
    <label for="email">Email Address <span aria-hidden="true">*</span></label>
    <input 
      type="email" 
      id="email" 
      name="email" 
      required
      autocomplete="email"
      aria-required="true"
      aria-describedby="email-hint"
    >
    <small id="email-hint">We'll never share your email.</small>
  </div>
  
  <div class="form-group">
    <label for="phone">Phone Number</label>
    <input 
      type="tel" 
      id="phone" 
      name="phone"
      autocomplete="tel"
      pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"
      placeholder="123-456-7890"
    >
  </div>
  
  <div class="form-group">
    <label for="message">Message</label>
    <textarea id="message" name="message" rows="5"></textarea>
  </div>
  
  <button type="submit">Send Message</button>
</form>
```

### Input Types
```html
<!-- Use appropriate input types -->
<input type="text">           <!-- Generic text -->
<input type="email">          <!-- Email with validation -->
<input type="tel">            <!-- Phone (mobile keyboard) -->
<input type="url">            <!-- URL with validation -->
<input type="number">         <!-- Numeric with spinners -->
<input type="password">       <!-- Masked input -->
<input type="search">         <!-- Search with clear button -->
<input type="date">           <!-- Date picker -->
<input type="time">           <!-- Time picker -->
<input type="datetime-local"> <!-- Date and time -->
<input type="month">          <!-- Month/year -->
<input type="week">           <!-- Week number -->
<input type="color">          <!-- Color picker -->
<input type="range">          <!-- Slider -->
<input type="file">           <!-- File upload -->
<input type="hidden">         <!-- Hidden data -->
```

### Checkboxes and Radios
```html
<!-- Checkbox group -->
<fieldset>
  <legend>Notification Preferences</legend>
  
  <label>
    <input type="checkbox" name="notifications" value="email">
    Email notifications
  </label>
  
  <label>
    <input type="checkbox" name="notifications" value="sms">
    SMS notifications
  </label>
</fieldset>

<!-- Radio group -->
<fieldset>
  <legend>Preferred Contact Method</legend>
  
  <label>
    <input type="radio" name="contact" value="email" checked>
    Email
  </label>
  
  <label>
    <input type="radio" name="contact" value="phone">
    Phone
  </label>
</fieldset>
```

### Select and Datalist
```html
<!-- Select dropdown -->
<label for="country">Country</label>
<select id="country" name="country" autocomplete="country">
  <option value="">Select a country</option>
  <optgroup label="North America">
    <option value="CA">Canada</option>
    <option value="US">United States</option>
    <option value="MX">Mexico</option>
  </optgroup>
  <optgroup label="Europe">
    <option value="UK">United Kingdom</option>
    <option value="FR">France</option>
  </optgroup>
</select>

<!-- Datalist (autocomplete suggestions) -->
<label for="browser">Choose a browser:</label>
<input list="browsers" id="browser" name="browser">
<datalist id="browsers">
  <option value="Chrome">
  <option value="Firefox">
  <option value="Safari">
  <option value="Edge">
</datalist>
```

### Autocomplete Attributes
```html
<!-- Help browsers autofill correctly -->
<input type="text" name="name" autocomplete="name">
<input type="email" name="email" autocomplete="email">
<input type="tel" name="phone" autocomplete="tel">
<input type="text" name="address" autocomplete="street-address">
<input type="text" name="city" autocomplete="address-level2">
<input type="text" name="province" autocomplete="address-level1">
<input type="text" name="postal" autocomplete="postal-code">
<input type="text" name="country" autocomplete="country-name">
<input type="text" name="cc-name" autocomplete="cc-name">
<input type="text" name="cc-number" autocomplete="cc-number">
```

## Tables

### Accessible Tables
```html
<table>
  <caption>Monthly Sales Report, Q1 2024</caption>
  <thead>
    <tr>
      <th scope="col">Month</th>
      <th scope="col">Units Sold</th>
      <th scope="col">Revenue</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">January</th>
      <td>1,234</td>
      <td>$45,678</td>
    </tr>
    <tr>
      <th scope="row">February</th>
      <td>1,456</td>
      <td>$52,345</td>
    </tr>
    <tr>
      <th scope="row">March</th>
      <td>1,678</td>
      <td>$61,234</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <th scope="row">Total</th>
      <td>4,368</td>
      <td>$159,257</td>
    </tr>
  </tfoot>
</table>
```

### Complex Tables
```html
<!-- Use id/headers for complex relationships -->
<table>
  <caption>Employee Schedule</caption>
  <thead>
    <tr>
      <th id="empty"></th>
      <th id="mon">Monday</th>
      <th id="tue">Tuesday</th>
      <th id="wed">Wednesday</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="morning" scope="row">Morning</th>
      <td headers="mon morning">Alice</td>
      <td headers="tue morning">Bob</td>
      <td headers="wed morning">Carol</td>
    </tr>
    <tr>
      <th id="afternoon" scope="row">Afternoon</th>
      <td headers="mon afternoon">David</td>
      <td headers="tue afternoon">Eve</td>
      <td headers="wed afternoon">Frank</td>
    </tr>
  </tbody>
</table>
```

## Media

### Video
```html
<video 
  controls 
  width="640" 
  height="360"
  poster="video-thumbnail.jpg"
  preload="metadata"
>
  <source src="video.webm" type="video/webm">
  <source src="video.mp4" type="video/mp4">
  <track kind="captions" src="captions-en.vtt" srclang="en" label="English" default>
  <track kind="captions" src="captions-fr.vtt" srclang="fr" label="Français">
  <p>Your browser doesn't support HTML5 video. <a href="video.mp4">Download the video</a>.</p>
</video>
```

### Audio
```html
<audio controls preload="metadata">
  <source src="audio.ogg" type="audio/ogg">
  <source src="audio.mp3" type="audio/mpeg">
  <p>Your browser doesn't support HTML5 audio. <a href="audio.mp3">Download the audio</a>.</p>
</audio>
```

### Embedded Content
```html
<!-- Responsive iframe wrapper -->
<div class="video-wrapper" style="aspect-ratio: 16/9;">
  <iframe 
    src="https://www.youtube.com/embed/VIDEO_ID"
    title="Video title for accessibility"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
    allowfullscreen
    loading="lazy"
  ></iframe>
</div>
```

## Accessibility Essentials

### ARIA Landmarks
```html
<header role="banner">...</header>           <!-- Implicit in <header> -->
<nav role="navigation">...</nav>             <!-- Implicit in <nav> -->
<main role="main">...</main>                 <!-- Implicit in <main> -->
<aside role="complementary">...</aside>      <!-- Implicit in <aside> -->
<footer role="contentinfo">...</footer>      <!-- Implicit in <footer> -->
<form role="search">...</form>               <!-- Search form -->
<section role="region" aria-label="...">     <!-- Named region -->
```

### Common ARIA Patterns
```html
<!-- Expanded/collapsed state -->
<button aria-expanded="false" aria-controls="menu">Menu</button>
<ul id="menu" hidden>...</ul>

<!-- Current page in navigation -->
<a href="/about" aria-current="page">About</a>

<!-- Live regions for dynamic content -->
<div aria-live="polite" aria-atomic="true">
  <!-- Screen reader announces changes -->
</div>

<!-- Error messages -->
<input type="email" id="email" aria-invalid="true" aria-describedby="email-error">
<span id="email-error" role="alert">Please enter a valid email address.</span>

<!-- Loading state -->
<button aria-busy="true" aria-disabled="true">
  <span class="spinner"></span>
  Loading...
</button>

<!-- Hidden from screen readers -->
<span aria-hidden="true">decorative icon</span>

<!-- Visually hidden but announced -->
<span class="visually-hidden">Opens in new tab</span>
```

### Skip Links
```html
<body>
  <a href="#main-content" class="skip-link">Skip to main content</a>
  <a href="#main-nav" class="skip-link">Skip to navigation</a>
  
  <header>
    <nav id="main-nav">...</nav>
  </header>
  
  <main id="main-content">...</main>
</body>

<style>
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  padding: 8px 16px;
  background: #000;
  color: #fff;
  z-index: 100;
}
.skip-link:focus {
  top: 0;
}
</style>
```

## Meta Tags

### Essential Meta Tags
```html
<head>
  <!-- Character encoding -->
  <meta charset="UTF-8">
  
  <!-- Responsive viewport -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <!-- Page description (SEO) -->
  <meta name="description" content="150-160 character description">
  
  <!-- Page title -->
  <title>Page Title — Site Name</title>
  
  <!-- Canonical URL -->
  <link rel="canonical" href="https://example.com/page">
  
  <!-- Language alternatives -->
  <link rel="alternate" hreflang="en" href="https://example.com/page">
  <link rel="alternate" hreflang="fr" href="https://example.com/fr/page">
  <link rel="alternate" hreflang="x-default" href="https://example.com/page">
  
  <!-- Robots -->
  <meta name="robots" content="index, follow">
  <!-- Or noindex for pages that shouldn't appear in search -->
  <meta name="robots" content="noindex, nofollow">
  
  <!-- Theme color (browser chrome) -->
  <meta name="theme-color" content="#0066cc">
</head>
```

### Open Graph (Social Sharing)
```html
<meta property="og:type" content="website">
<meta property="og:url" content="https://example.com/page">
<meta property="og:title" content="Page Title">
<meta property="og:description" content="Page description">
<meta property="og:image" content="https://example.com/og-image.jpg">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:site_name" content="Site Name">
<meta property="og:locale" content="en_CA">
```

### Twitter Cards
```html
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:site" content="@username">
<meta name="twitter:title" content="Page Title">
<meta name="twitter:description" content="Page description">
<meta name="twitter:image" content="https://example.com/twitter-image.jpg">
```

## Performance

### Resource Hints
```html
<head>
  <!-- Preconnect to required origins -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  
  <!-- DNS prefetch for third parties -->
  <link rel="dns-prefetch" href="https://analytics.example.com">
  
  <!-- Preload critical resources -->
  <link rel="preload" href="/fonts/custom.woff2" as="font" type="font/woff2" crossorigin>
  <link rel="preload" href="/css/critical.css" as="style">
  
  <!-- Prefetch next page -->
  <link rel="prefetch" href="/next-page.html">
</head>
```

### Script Loading
```html
<!-- Defer: load after HTML parsed, maintain order -->
<script src="main.js" defer></script>

<!-- Async: load independently, execute when ready -->
<script src="analytics.js" async></script>

<!-- Module: automatically deferred -->
<script type="module" src="app.js"></script>

<!-- Inline critical scripts -->
<script>
  // Critical inline JS
</script>
```

## Best Practices Summary

1. **Use semantic elements** — Choose elements based on meaning, not appearance
2. **Maintain heading hierarchy** — One h1, logical nesting, don't skip levels
3. **Always include alt text** — Descriptive for content images, empty for decorative
4. **Associate labels with inputs** — Use `for`/`id` or wrap input in label
5. **Use appropriate input types** — email, tel, url, etc. for better UX
6. **Provide skip links** — Help keyboard users navigate
7. **Include language attribute** — `<html lang="en">`
8. **Optimize images** — Use responsive images, lazy loading, proper formats
9. **Write descriptive link text** — Not "click here" but meaningful text
10. **Test without CSS** — Content should still be logical and readable

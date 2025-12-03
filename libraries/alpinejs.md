# Alpine.js Conventions

## Core Concepts
- Use for lightweight interactivity
- Keep complex logic in external functions
- Prefer Alpine over heavy JS frameworks for simple interactions

## Common Patterns

### Basic Component
```html
<div x-data="{ open: false }">
  <button @click="open = !open">Toggle</button>
  <div x-show="open" x-transition>
    Content
  </div>
</div>
```

### Dropdown
```html
<div x-data="{ open: false }" @click.outside="open = false" class="relative">
  <button @click="open = !open">
    Menu
    <svg :class="{ 'rotate-180': open }" class="transition-transform">...</svg>
  </button>
  <ul 
    x-show="open" 
    x-transition:enter="transition ease-out duration-100"
    x-transition:enter-start="opacity-0 scale-95"
    x-transition:enter-end="opacity-100 scale-100"
    x-transition:leave="transition ease-in duration-75"
    x-transition:leave-start="opacity-100 scale-100"
    x-transition:leave-end="opacity-0 scale-95"
    class="dropdown-menu"
  >
    <li><a href="#">Item 1</a></li>
    <li><a href="#">Item 2</a></li>
  </ul>
</div>
```

### Mobile Menu
```html
<div x-data="{ mobileMenu: false }">
  <button 
    @click="mobileMenu = !mobileMenu" 
    class="lg:hidden"
    :aria-expanded="mobileMenu"
  >
    <span x-show="!mobileMenu">☰</span>
    <span x-show="mobileMenu">✕</span>
  </button>
  
  <nav 
    :class="mobileMenu ? 'block' : 'hidden lg:block'"
    @click.outside="mobileMenu = false"
  >
    <!-- Navigation items -->
  </nav>
</div>
```

### Tabs
```html
<div x-data="{ activeTab: 'tab1' }">
  <div role="tablist" class="flex border-b">
    <button 
      @click="activeTab = 'tab1'" 
      :class="activeTab === 'tab1' ? 'border-b-2 border-blue-500' : ''"
      :aria-selected="activeTab === 'tab1'"
      role="tab"
    >Tab 1</button>
    <button 
      @click="activeTab = 'tab2'" 
      :class="activeTab === 'tab2' ? 'border-b-2 border-blue-500' : ''"
      :aria-selected="activeTab === 'tab2'"
      role="tab"
    >Tab 2</button>
  </div>
  
  <div x-show="activeTab === 'tab1'" role="tabpanel">Tab 1 content</div>
  <div x-show="activeTab === 'tab2'" role="tabpanel">Tab 2 content</div>
</div>
```

### Accordion
```html
<div x-data="{ active: null }">
  <div class="border rounded">
    <button 
      @click="active = active === 1 ? null : 1"
      :aria-expanded="active === 1"
      class="w-full p-4 text-left flex justify-between"
    >
      <span>Section 1</span>
      <span x-text="active === 1 ? '−' : '+'"></span>
    </button>
    <div x-show="active === 1" x-collapse>
      <div class="p-4 border-t">Content 1</div>
    </div>
  </div>
  
  <div class="border rounded mt-2">
    <button 
      @click="active = active === 2 ? null : 2"
      :aria-expanded="active === 2"
      class="w-full p-4 text-left flex justify-between"
    >
      <span>Section 2</span>
      <span x-text="active === 2 ? '−' : '+'"></span>
    </button>
    <div x-show="active === 2" x-collapse>
      <div class="p-4 border-t">Content 2</div>
    </div>
  </div>
</div>
```

### Modal
```html
<div x-data="{ modalOpen: false }">
  <button @click="modalOpen = true">Open Modal</button>
  
  <div 
    x-show="modalOpen" 
    x-transition:enter="ease-out duration-300"
    x-transition:enter-start="opacity-0"
    x-transition:enter-end="opacity-100"
    x-transition:leave="ease-in duration-200"
    x-transition:leave-start="opacity-100"
    x-transition:leave-end="opacity-0"
    class="fixed inset-0 bg-black/50 z-40"
    @click="modalOpen = false"
  ></div>
  
  <div 
    x-show="modalOpen"
    x-transition
    @click.outside="modalOpen = false"
    @keydown.escape.window="modalOpen = false"
    class="fixed inset-0 flex items-center justify-center z-50"
    role="dialog"
    aria-modal="true"
  >
    <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
      <h2>Modal Title</h2>
      <p>Modal content</p>
      <button @click="modalOpen = false">Close</button>
    </div>
  </div>
</div>
```

### Form Validation
```html
<form 
  x-data="{ 
    email: '', 
    error: '',
    validate() {
      this.error = this.email.includes('@') ? '' : 'Invalid email';
      return !this.error;
    }
  }" 
  @submit.prevent="validate() && $el.submit()"
>
  <label>
    Email
    <input 
      type="email" 
      x-model="email" 
      @blur="validate"
      :class="error ? 'border-red-500' : ''"
    >
  </label>
  <span x-show="error" x-text="error" class="text-red-500 text-sm"></span>
  <button type="submit">Submit</button>
</form>
```

### Fetching Data
```html
<div x-data="{ 
  posts: [],
  loading: true,
  error: null,
  async init() {
    try {
      const response = await fetch('/api/posts');
      this.posts = await response.json();
    } catch (e) {
      this.error = 'Failed to load posts';
    } finally {
      this.loading = false;
    }
  }
}">
  <template x-if="loading">
    <p>Loading...</p>
  </template>
  <template x-if="error">
    <p x-text="error" class="text-red-500"></p>
  </template>
  <template x-for="post in posts" :key="post.id">
    <article>
      <h2 x-text="post.title"></h2>
      <p x-text="post.excerpt"></p>
    </article>
  </template>
</div>
```

### External Component Definition
```html
<script>
document.addEventListener('alpine:init', () => {
  Alpine.data('accordion', () => ({
    active: null,
    toggle(id) {
      this.active = this.active === id ? null : id;
    },
    isOpen(id) {
      return this.active === id;
    }
  }));
  
  Alpine.data('counter', (initialCount = 0) => ({
    count: initialCount,
    increment() { this.count++ },
    decrement() { this.count-- }
  }));
});
</script>

<div x-data="accordion">
  <button @click="toggle(1)">Section 1</button>
  <div x-show="isOpen(1)">Content 1</div>
</div>

<div x-data="counter(5)">
  <button @click="decrement">-</button>
  <span x-text="count"></span>
  <button @click="increment">+</button>
</div>
```

### Alpine Store (Global State)
```html
<script>
document.addEventListener('alpine:init', () => {
  Alpine.store('cart', {
    items: [],
    add(item) {
      this.items.push(item);
    },
    get count() {
      return this.items.length;
    }
  });
});
</script>

<span x-text="$store.cart.count"></span>
<button @click="$store.cart.add({ id: 1, name: 'Product' })">Add to Cart</button>
```

## Directives Quick Reference
| Directive | Purpose |
|-----------|---------|
| `x-data` | Define component state |
| `x-show` | Toggle visibility (CSS display) |
| `x-if` | Conditional rendering (removes from DOM) |
| `x-for` | Loop over items |
| `x-bind` / `:` | Bind attributes dynamically |
| `x-on` / `@` | Attach event listeners |
| `x-model` | Two-way data binding |
| `x-text` | Set text content |
| `x-html` | Set HTML content (use carefully) |
| `x-transition` | Apply enter/leave transitions |
| `x-init` | Run code on initialization |
| `x-ref` | Reference DOM elements |
| `x-cloak` | Hide until Alpine initializes |
| `x-ignore` | Skip Alpine processing |
| `x-effect` | React to data changes |
| `x-teleport` | Move element in DOM |

## Modifiers
```html
<!-- Event modifiers -->
@click.prevent        <!-- preventDefault -->
@click.stop           <!-- stopPropagation -->
@click.outside        <!-- Click outside element -->
@click.window         <!-- Listen on window -->
@click.document       <!-- Listen on document -->
@click.once           <!-- Only fire once -->
@click.debounce.500ms <!-- Debounce -->
@click.throttle.500ms <!-- Throttle -->

<!-- Keyboard modifiers -->
@keydown.enter
@keydown.escape
@keydown.shift.enter

<!-- Model modifiers -->
x-model.lazy          <!-- Update on change, not input -->
x-model.number        <!-- Parse as number -->
x-model.debounce.500ms
```

## Best Practices
- Keep x-data objects small and focused
- Extract complex logic to external functions/components
- Use x-transition for smooth UX
- Remember accessibility (keyboard nav, ARIA attributes)
- Use @click.outside for dismissible elements
- Prefer x-show over x-if for frequent toggling
- Use x-cloak to prevent flash of unstyled content

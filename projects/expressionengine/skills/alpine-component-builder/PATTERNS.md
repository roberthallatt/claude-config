# Alpine.js Component Patterns

## Dropdown Menu

```html
<div x-data="{ isOpen: false }" class="relative">
  <button
    @click="isOpen = !isOpen"
    class="px-4 py-2 bg-brand-green text-white rounded"
  >
    Menu
  </button>

  <div
    x-show="isOpen"
    @click.away="isOpen = false"
    class="absolute right-0 mt-2 w-48 bg-white rounded shadow-lg"
  >
    <a href="#" class="block px-4 py-2 hover:bg-gray-100">Option 1</a>
    <a href="#" class="block px-4 py-2 hover:bg-gray-100">Option 2</a>
  </div>
</div>
```

## Modal Dialog

```html
<div x-data="{ isOpen: false }">
  <button @click="isOpen = true" class="bg-brand-blue text-white px-4 py-2">
    Open Modal
  </button>

  <div
    x-show="isOpen"
    x-transition
    class="fixed inset-0 bg-black/50 flex items-center justify-center z-50"
  >
    <div class="bg-white rounded-lg p-8 max-w-md">
      <h2 class="text-2xl font-bold mb-4">Modal Title</h2>
      <p class="text-gray-700 mb-6">Modal content here</p>
      <button
        @click="isOpen = false"
        class="bg-brand-green text-white px-6 py-2 rounded"
      >
        Close
      </button>
    </div>
  </div>
</div>
```

## Accordion (Multiple Items)

```html
<div x-data="{ activeTab: null }">
  <template x-for="(item, index) in items" :key="index">
    <div class="border-b">
      <button
        @click="activeTab = activeTab === index ? null : index"
        class="w-full text-left px-4 py-3 font-bold hover:bg-gray-100"
      >
        <span x-text="item.title"></span>
        <span class="float-right" x-text="activeTab === index ? '−' : '+'"></span>
      </button>

      <div x-show="activeTab === index" class="px-4 py-3 bg-gray-50">
        <p x-text="item.content"></p>
      </div>
    </div>
  </template>
</div>
```

## Tab Component

```html
<div x-data="{ activeTab: 'tab1' }">
  <div class="flex border-b">
    <button
      @click="activeTab = 'tab1'"
      :class="{ 'border-b-2 border-brand-green': activeTab === 'tab1' }"
      class="px-4 py-2"
    >
      Tab 1
    </button>
    <button
      @click="activeTab = 'tab2'"
      :class="{ 'border-b-2 border-brand-green': activeTab === 'tab2' }"
      class="px-4 py-2"
    >
      Tab 2
    </button>
  </div>

  <div x-show="activeTab === 'tab1'" class="p-4">Content 1</div>
  <div x-show="activeTab === 'tab2'" class="p-4">Content 2</div>
</div>
```

## Form Input with Validation

```html
<div x-data="{ email: '', errors: {} }">
  <input
    x-model="email"
    @blur="errors.email = !email.includes('@') ? 'Invalid email' : ''"
    type="email"
    placeholder="Enter email"
    class="px-4 py-2 border rounded"
    :class="{ 'border-red-500': errors.email }"
  />
  <p x-show="errors.email" class="text-red-500 text-sm" x-text="errors.email"></p>
</div>
```

## Reactive List with Filtering

```html
<div x-data="{
  items: ['Apple', 'Banana', 'Cherry'],
  search: '',
  get filtered() {
    return this.items.filter(item =>
      item.toLowerCase().includes(this.search.toLowerCase())
    )
  }
}">
  <input
    x-model="search"
    type="text"
    placeholder="Search..."
    class="px-4 py-2 border rounded w-full mb-4"
  />

  <ul>
    <template x-for="item in filtered" :key="item">
      <li class="px-4 py-2 hover:bg-gray-100" x-text="item"></li>
    </template>
  </ul>
</div>
```

## Toggle with Transitions

```html
<div x-data="{ isVisible: true }">
  <button
    @click="isVisible = !isVisible"
    class="mb-4 bg-brand-orange text-white px-4 py-2 rounded"
  >
    Toggle
  </button>

  <div
    x-show="isVisible"
    x-transition:enter="transition ease-out duration-300"
    x-transition:leave="transition ease-in duration-200"
    class="p-6 bg-brand-light-green rounded"
  >
    <p>This content has smooth transitions!</p>
  </div>
</div>
```

## Language Switcher

```html
<div x-data="{ lang: 'en' }">
  <button @click="lang = 'en'" :class="{ 'font-bold': lang === 'en' }">
    English
  </button>
  <button @click="lang = 'fr'" :class="{ 'font-bold': lang === 'fr' }">
    Français
  </button>

  <div x-show="lang === 'en'">Welcome to the site</div>
  <div x-show="lang === 'fr'">Bienvenue sur le site</div>
</div>
```

# Livewire Component Generator

Creates Livewire components for Coilpack projects with Twig/Blade integration.

## Create Component

```bash
# Basic component
ddev artisan make:livewire ComponentName

# Nested component
ddev artisan make:livewire Forms/ContactForm
ddev artisan make:livewire Admin/UserTable
```

## File Structure

```
app/Livewire/
├── ContactForm.php           # Component class
├── SearchFilter.php
└── Forms/
    └── NewsletterSignup.php

resources/views/livewire/
├── contact-form.blade.php    # Component view
├── search-filter.blade.php
└── forms/
    └── newsletter-signup.blade.php
```

## Component Class Pattern

```php
<?php

namespace App\Livewire;

use Livewire\Component;
use Livewire\Attributes\Validate;

class ContactForm extends Component
{
    #[Validate('required|min:2')]
    public string $name = '';

    #[Validate('required|email')]
    public string $email = '';

    #[Validate('required|min:10')]
    public string $message = '';

    public bool $submitted = false;

    public function submit(): void
    {
        $this->validate();

        // Process form...
        
        $this->submitted = true;
        $this->reset(['name', 'email', 'message']);
    }

    public function render()
    {
        return view('livewire.contact-form');
    }
}
```

## Component View (Blade)

```blade
{{-- resources/views/livewire/contact-form.blade.php --}}
<div>
    @if($submitted)
        <div class="bg-green-100 text-green-800 p-4 rounded">
            {{ __('messages.form_success') }}
        </div>
    @else
        <form wire:submit="submit">
            <div class="mb-4">
                <label for="name">{{ __('messages.name') }}</label>
                <input type="text" wire:model="name" id="name" 
                       class="w-full border rounded p-2">
                @error('name') 
                    <span class="text-red-500 text-sm">{{ $message }}</span> 
                @enderror
            </div>

            <div class="mb-4">
                <label for="email">{{ __('messages.email') }}</label>
                <input type="email" wire:model="email" id="email"
                       class="w-full border rounded p-2">
                @error('email') 
                    <span class="text-red-500 text-sm">{{ $message }}</span> 
                @enderror
            </div>

            <div class="mb-4">
                <label for="message">{{ __('messages.message') }}</label>
                <textarea wire:model="message" id="message" rows="4"
                          class="w-full border rounded p-2"></textarea>
                @error('message') 
                    <span class="text-red-500 text-sm">{{ $message }}</span> 
                @enderror
            </div>

            <button type="submit" 
                    class="bg-blue-600 text-white px-4 py-2 rounded"
                    wire:loading.attr="disabled">
                <span wire:loading.remove>{{ __('messages.submit') }}</span>
                <span wire:loading>{{ __('messages.submitting') }}</span>
            </button>
        </form>
    @endif
</div>
```

## Using in Twig Templates

```twig
{# In your Twig template #}
<div class="contact-section">
    <h2>{{ __('messages.contact_us') }}</h2>
    @livewire('contact-form')
</div>

{# With parameters #}
@livewire('search-filter', ['category' => 'news'])

{# Full page component #}
@livewire('admin.user-table')
```

## Common Patterns

### Search/Filter Component
```php
<?php

namespace App\Livewire;

use Livewire\Component;
use Livewire\WithPagination;

class SearchFilter extends Component
{
    use WithPagination;

    public string $search = '';
    public string $category = '';
    public string $sortBy = 'date';

    // Reset pagination when filters change
    public function updatedSearch(): void
    {
        $this->resetPage();
    }

    public function updatedCategory(): void
    {
        $this->resetPage();
    }

    public function render()
    {
        $entries = ee('Model')
            ->get('ChannelEntry')
            ->filter('channel_id', 3)
            ->filter('title', 'LIKE', "%{$this->search}%")
            ->order($this->sortBy, 'desc')
            ->limit(10)
            ->all();

        return view('livewire.search-filter', [
            'entries' => $entries
        ]);
    }
}
```

### Newsletter Signup
```php
<?php

namespace App\Livewire\Forms;

use Livewire\Component;
use Livewire\Attributes\Validate;

class NewsletterSignup extends Component
{
    #[Validate('required|email|unique:newsletter_subscribers,email')]
    public string $email = '';

    public bool $subscribed = false;

    public function subscribe(): void
    {
        $this->validate();

        // Add to newsletter service
        // NewsletterService::subscribe($this->email);

        $this->subscribed = true;
    }

    public function render()
    {
        return view('livewire.forms.newsletter-signup');
    }
}
```

### Modal Component
```php
<?php

namespace App\Livewire;

use Livewire\Component;

class Modal extends Component
{
    public bool $show = false;
    public string $title = '';
    public string $content = '';

    protected $listeners = ['openModal', 'closeModal'];

    public function openModal(string $title, string $content): void
    {
        $this->title = $title;
        $this->content = $content;
        $this->show = true;
    }

    public function closeModal(): void
    {
        $this->show = false;
    }

    public function render()
    {
        return view('livewire.modal');
    }
}
```

## Livewire + Alpine.js Integration

```blade
<div x-data="{ open: false }">
    <button @click="open = true">Open</button>
    
    <div x-show="open" x-cloak>
        <form wire:submit="save">
            {{-- Livewire handles the form --}}
            <input wire:model="name">
            
            {{-- Alpine handles UI state --}}
            <button @click="open = false" type="button">Cancel</button>
            <button type="submit">Save</button>
        </form>
    </div>
</div>
```

## Bilingual Considerations

```php
// In component - get current locale
$locale = app()->getLocale();

// Use appropriate field
$titleField = $locale === 'fr' ? 'title_fr' : 'title_en';
```

## Prompt

When creating a Livewire component:
1. Create both the PHP class and Blade view
2. Use Laravel validation attributes
3. Include bilingual translation keys
4. Add Tailwind CSS styling
5. Consider Alpine.js for UI interactions
6. Follow Coilpack patterns for EE data access

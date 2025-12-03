# Vanilla JavaScript Conventions

## General Principles
- Use modern ES6+ features
- Prefer const over let; avoid var
- Use strict equality (=== and !==)
- Keep functions small and focused
- Use meaningful, descriptive names

## DOM Selection
```javascript
// Single element
const button = document.querySelector('.btn-primary');
const form = document.getElementById('contact-form');

// Multiple elements (returns NodeList)
const cards = document.querySelectorAll('.card');

// Convert NodeList to Array for array methods
const cardsArray = [...document.querySelectorAll('.card')];
// or
const cardsArray = Array.from(document.querySelectorAll('.card'));

// Scoped selection
const container = document.querySelector('.container');
const items = container.querySelectorAll('.item');

// Cache DOM references
const elements = {
  header: document.querySelector('.header'),
  nav: document.querySelector('.nav'),
  main: document.querySelector('.main'),
};
```

## Event Handling
```javascript
// Modern event listener
button.addEventListener('click', (e) => {
  e.preventDefault();
  // handle click
});

// Event delegation (better for dynamic content)
document.addEventListener('click', (e) => {
  if (e.target.matches('.btn-delete')) {
    handleDelete(e.target);
  }
  
  if (e.target.closest('.card')) {
    handleCardClick(e.target.closest('.card'));
  }
});

// Remove listener
const handleClick = () => { /* ... */ };
button.addEventListener('click', handleClick);
button.removeEventListener('click', handleClick);

// Once option
button.addEventListener('click', () => {
  // Only fires once
}, { once: true });

// Passive for scroll performance
window.addEventListener('scroll', handleScroll, { passive: true });
```

## DOM Manipulation
```javascript
// Create elements
const div = document.createElement('div');
div.className = 'card';
div.innerHTML = `
  <h3>${title}</h3>
  <p>${description}</p>
`;

// Better: use textContent for plain text (XSS safe)
div.textContent = userInput;

// Append
container.appendChild(div);
container.append(div1, div2, 'text'); // Multiple items

// Prepend
container.prepend(div);

// Insert at position
container.insertBefore(newElement, referenceElement);

// Insert adjacent
element.insertAdjacentHTML('beforeend', '<span>Hello</span>');
// Positions: 'beforebegin', 'afterbegin', 'beforeend', 'afterend'

// Remove
element.remove();

// Clone
const clone = element.cloneNode(true); // true = deep clone
```

## Classes and Attributes
```javascript
// Classes
element.classList.add('active', 'visible');
element.classList.remove('hidden');
element.classList.toggle('open');
element.classList.replace('old', 'new');
const hasClass = element.classList.contains('active');

// Attributes
element.setAttribute('data-id', '123');
const id = element.getAttribute('data-id');
element.removeAttribute('disabled');
const hasAttr = element.hasAttribute('required');

// Dataset (data-* attributes)
element.dataset.userId = '123';      // sets data-user-id="123"
const userId = element.dataset.userId;

// Styles
element.style.display = 'none';
element.style.cssText = 'color: red; font-size: 16px;';

// Better: toggle classes instead of inline styles
element.classList.add('hidden');
```

## Async/Await & Fetch
```javascript
// Basic fetch
async function getPosts() {
  try {
    const response = await fetch('/api/posts');
    
    if (!response.ok) {
      throw new Error(`HTTP error: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Failed to fetch posts:', error);
    throw error;
  }
}

// POST request
async function createPost(postData) {
  const response = await fetch('/api/posts', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(postData),
  });
  
  if (!response.ok) {
    const error = await response.json();
    throw new Error(error.message);
  }
  
  return response.json();
}

// With AbortController (cancellable)
const controller = new AbortController();

fetch('/api/data', { signal: controller.signal })
  .then(response => response.json())
  .catch(error => {
    if (error.name === 'AbortError') {
      console.log('Fetch cancelled');
    }
  });

// Cancel the request
controller.abort();
```

## Debounce & Throttle
```javascript
// Debounce: delay execution until pause in calls
function debounce(func, wait = 300) {
  let timeout;
  return function executedFunction(...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), wait);
  };
}

// Usage
const handleSearch = debounce((query) => {
  fetchResults(query);
}, 300);

searchInput.addEventListener('input', (e) => {
  handleSearch(e.target.value);
});

// Throttle: limit execution to once per interval
function throttle(func, limit = 300) {
  let inThrottle;
  return function executedFunction(...args) {
    if (!inThrottle) {
      func.apply(this, args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  };
}

// Usage
const handleScroll = throttle(() => {
  updateScrollPosition();
}, 100);

window.addEventListener('scroll', handleScroll, { passive: true });
```

## Local Storage
```javascript
// Set item (must be string)
localStorage.setItem('user', JSON.stringify({ name: 'John', id: 1 }));

// Get item
const user = JSON.parse(localStorage.getItem('user'));

// Remove item
localStorage.removeItem('user');

// Clear all
localStorage.clear();

// Helper functions
const storage = {
  get(key, defaultValue = null) {
    try {
      const item = localStorage.getItem(key);
      return item ? JSON.parse(item) : defaultValue;
    } catch {
      return defaultValue;
    }
  },
  
  set(key, value) {
    localStorage.setItem(key, JSON.stringify(value));
  },
  
  remove(key) {
    localStorage.removeItem(key);
  }
};
```

## URL & Query Params
```javascript
// Parse current URL
const url = new URL(window.location.href);

// Get query params
const params = new URLSearchParams(window.location.search);
const page = params.get('page');      // '1'
const tags = params.getAll('tag');    // ['js', 'css']
const hasPage = params.has('page');   // true

// Set query params
params.set('page', '2');
params.append('tag', 'html');
params.delete('sort');

// Update URL without reload
const newUrl = `${window.location.pathname}?${params}`;
history.pushState({}, '', newUrl);
// or replaceState to not add to history
history.replaceState({}, '', newUrl);
```

## Intersection Observer (Lazy Loading / Animations)
```javascript
const observer = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        // Optionally stop observing
        observer.unobserve(entry.target);
      }
    });
  },
  {
    root: null,           // viewport
    rootMargin: '0px',    // margin around root
    threshold: 0.1,       // 10% visible
  }
);

// Observe elements
document.querySelectorAll('.animate-on-scroll').forEach((el) => {
  observer.observe(el);
});

// Lazy load images
const imageObserver = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      const img = entry.target;
      img.src = img.dataset.src;
      img.classList.remove('lazy');
      imageObserver.unobserve(img);
    }
  });
});

document.querySelectorAll('img.lazy').forEach((img) => {
  imageObserver.observe(img);
});
```

## Module Pattern
```javascript
// ES Modules (recommended)
// utils.js
export function formatDate(date) {
  return new Intl.DateTimeFormat('en-CA').format(date);
}

export function slugify(text) {
  return text.toLowerCase().replace(/\s+/g, '-');
}

// main.js
import { formatDate, slugify } from './utils.js';

// Default export
// api.js
export default {
  async get(url) { /* ... */ },
  async post(url, data) { /* ... */ }
};

// main.js
import api from './api.js';
```

## Error Handling
```javascript
// Try/catch with async
async function loadData() {
  try {
    const data = await fetchData();
    renderData(data);
  } catch (error) {
    if (error instanceof TypeError) {
      showError('Network error');
    } else {
      showError('Something went wrong');
    }
    console.error(error);
  } finally {
    hideLoader();
  }
}

// Custom errors
class ValidationError extends Error {
  constructor(message, field) {
    super(message);
    this.name = 'ValidationError';
    this.field = field;
  }
}

throw new ValidationError('Email is required', 'email');
```

## Best Practices
- Cache DOM selections outside loops
- Use event delegation for dynamic content
- Debounce/throttle expensive operations
- Use const by default, let when reassignment needed
- Prefer template literals over concatenation
- Use optional chaining (?.) and nullish coalescing (??)
- Always handle promise rejections
- Use meaningful error messages
- Clean up event listeners and observers when done

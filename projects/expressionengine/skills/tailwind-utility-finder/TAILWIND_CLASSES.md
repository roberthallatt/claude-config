# Common Tailwind Utility Combinations

## Containers & Spacing

### Standard Container
```
<div class="container mx-auto px-4 py-8">
```

### Full Width with Padding
```
<section class="w-full px-4 py-12 md:py-20">
```

## Responsive Grids

### 2-Column Responsive
```
<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
```

### 3-Column Responsive
```
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
```

### 4-Column Responsive
```
<div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
```

## Flexbox Patterns

### Horizontal Layout (Responsive)
```
<div class="flex flex-col md:flex-row items-center justify-between gap-4">
```

### Centered Content
```
<div class="flex items-center justify-center min-h-screen">
```

### Space Between
```
<div class="flex items-center justify-between gap-4">
```

## Text Styling

### Heading
```
<h1 class="text-4xl md:text-5xl font-bold text-brand-green mb-4">
```

### Paragraph
```
<p class="text-lg text-gray-700 leading-relaxed mb-4">
```

### Small Text/Caption
```
<span class="text-sm text-gray-600">Caption</span>
```

## Button States

### Primary Button
```
class="px-6 py-3 bg-brand-green text-white rounded-lg hover:bg-opacity-90 transition-colors"
```

### Secondary Button
```
class="px-6 py-3 border-2 border-brand-blue text-brand-blue rounded-lg hover:bg-brand-blue hover:text-white transition-colors"
```

## Card Patterns

### Standard Card
```
<div class="bg-white rounded-lg shadow p-6 mb-6">
```

### Bordered Card
```
<div class="bg-white border-l-4 border-brand-green rounded p-6">
```

### Hover Effect Card
```
<div class="bg-white rounded-lg shadow hover:shadow-lg transition-shadow p-6">
```

## Visual Effects

### Gradients
```
class="bg-gradient-to-r from-brand-green to-brand-blue"
```

### Opacity Overlay
```
class="absolute inset-0 bg-brand-green/50 opacity-0 hover:opacity-100 transition-opacity"
```

### Rounded Corners
```
rounded-lg (default) | rounded-full | rounded-none
```

## Responsive Visibility

### Hide on Mobile
```
class="hidden md:block"
```

### Show Only on Mobile
```
class="md:hidden"
```

### Responsive Display
```
class="block md:inline-block lg:inline"
```

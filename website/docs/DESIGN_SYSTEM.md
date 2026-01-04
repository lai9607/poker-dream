# Poker Dream Design System

> The official design system and standards for the Poker Dream website.

---

## Table of Contents

1. [Design Principles](#design-principles)
2. [Color System](#color-system)
3. [Typography](#typography)
4. [Spacing System](#spacing-system)
5. [Layout & Grid](#layout--grid)
6. [Components](#components)
7. [Animation Guidelines](#animation-guidelines)
8. [Responsive Design](#responsive-design)
9. [Accessibility](#accessibility)

---

## Design Principles

### 1. Premium & Professional
The design should convey a high-end casino/poker experience with a dark, sophisticated aesthetic.

### 2. Clarity & Hierarchy
Information should be presented with clear visual hierarchy. Users should immediately understand what's most important.

### 3. Consistency
All components, spacing, and interactions should follow established patterns documented in this guide.

### 4. Performance
Animations should be smooth but not excessive. Images should be optimized. The site should feel fast.

---

## Color System

### Primary Colors
| Token | Value | Usage |
|-------|-------|-------|
| `--primary` | `#E53935` | Primary actions, CTAs, highlights |
| `--primary-dark` | `#C62828` | Hover states, gradients |
| `--primary-light` | `#EF5350` | Active states |

### Accent Colors (Gold)
| Token | Value | Usage |
|-------|-------|-------|
| `--gold` | `#FFD700` | Prizes, rankings, premium elements |
| `--gold-dark` | `#FFC107` | Gold hover states |
| `--gold-light` | `#FFEB3B` | Gold highlights |

### Background Colors
| Token | Value | Usage |
|-------|-------|-------|
| `--background` | `#0A0A0A` | Main page background |
| `--background-secondary` | `#121212` | Alternate sections, footer |
| `--background-tertiary` | `#1A1A1A` | Sponsors section, subtle contrast |
| `--surface` | `#1E1E1E` | Cards, elevated surfaces |
| `--surface-hover` | `#2A2A2A` | Surface hover states |

### Text Colors
| Token | Value | Usage |
|-------|-------|-------|
| `--foreground` | `#FFFFFF` | Primary text, headings |
| `--foreground-secondary` | `#B3B3B3` | Secondary text, descriptions |
| `--foreground-muted` | `#666666` | Muted text, timestamps |

### Border Colors
| Token | Value | Usage |
|-------|-------|-------|
| `--border` | `#333333` | Default borders |
| `--border-light` | `#444444` | Lighter borders, hover states |

### Status Colors
| Token | Value | Usage |
|-------|-------|-------|
| `--success` | `#4CAF50` | Success states, positive indicators |
| `--warning` | `#FF9800` | Warnings, caution states |
| `--error` | `#F44336` | Errors, live indicators |
| `--info` | `#2196F3` | Informational messages |

### Gradients
```css
--gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
--gradient-gold: linear-gradient(135deg, var(--gold) 0%, var(--gold-dark) 100%);
--gradient-dark: linear-gradient(180deg, var(--background) 0%, var(--background-secondary) 100%);
```

---

## Typography

### Font Family
```css
font-family: 'Space Grotesk', system-ui, sans-serif;
```

The Space Grotesk font is loaded via `next/font/google` in `layout.tsx` for optimal performance.

### Font Sizes
| Element | Size | Weight | Line Height |
|---------|------|--------|-------------|
| H1 | `3rem` (48px) | 700 | 1.2 |
| H2 | `2.25rem` (36px) | 700 | 1.2 |
| H3 | `1.875rem` (30px) | 700 | 1.2 |
| H4 | `1.5rem` (24px) | 700 | 1.2 |
| H5 | `1.25rem` (20px) | 700 | 1.2 |
| H6 | `1rem` (16px) | 700 | 1.2 |
| Body | `1rem` (16px) | 400 | 1.6 |
| Small | `0.875rem` (14px) | 400 | 1.5 |
| XSmall | `0.75rem` (12px) | 400 | 1.5 |

### Text Utility Classes
```css
.text-gradient-primary  /* Red gradient text */
.text-gradient-gold     /* Gold gradient text */
```

---

## Spacing System

### Base Scale (4px grid)
| Token | Value | Pixels |
|-------|-------|--------|
| `--spacing-xs` | `0.25rem` | 4px |
| `--spacing-sm` | `0.5rem` | 8px |
| `--spacing-md` | `1rem` | 16px |
| `--spacing-lg` | `1.5rem` | 24px |
| `--spacing-xl` | `2rem` | 32px |
| `--spacing-2xl` | `3rem` | 48px |
| `--spacing-3xl` | `4rem` | 64px |
| `--spacing-4xl` | `5rem` | 80px |
| `--spacing-5xl` | `6rem` | 96px |

### Section Spacing
| Token | Value | Usage |
|-------|-------|-------|
| `--section-padding-y` | `5rem` (80px) | Standard section vertical padding |
| `--section-padding-y-sm` | `4rem` (64px) | Smaller sections (sponsors) |
| `--section-header-gap` | `4rem` (64px) | Large gap after section headers |
| `--section-header-gap-sm` | `3rem` (48px) | Standard gap after section headers |

### Component Spacing
| Token | Value | Usage |
|-------|-------|-------|
| `--card-padding` | `1.5rem` (24px) | Internal card padding |
| `--card-gap` | `1.5rem` (24px) | Gap between cards |
| `--grid-gap` | `1.5rem` (24px) | Standard grid gap |
| `--grid-gap-lg` | `2rem` (32px) | Large grid gap |

### Section Utility Classes
```css
.section          /* py: 80px - standard sections */
.section-sm       /* py: 64px - smaller sections */
.section-header   /* mb: 48px - after section headers */
.section-header-lg /* mb: 64px - after large section headers */
```

### Usage Guidelines

**DO:**
```jsx
// Use semantic spacing classes for sections
<section className="section bg-[var(--background)]">

// Use CSS variables for custom spacing
<div className="py-[var(--spacing-2xl)]">

// Use consistent section headers
<div className="section-header">
```

**DON'T:**
```jsx
// Don't use arbitrary values
<section className="py-20">  // Bad - use .section instead

// Don't mix spacing scales
<div className="mb-12">  // Bad - use section-header or CSS var
```

---

## Layout & Grid

### Container
```css
.container {
  width: 100%;
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 1rem;      /* Mobile */
  padding: 0 1.5rem;    /* sm: 640px+ */
  padding: 0 2rem;      /* lg: 1024px+ */
}
```

### Grid Patterns

**3-Column Grid (Cards)**
```jsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-[var(--grid-gap)]">
```

**4-Column Grid (Footer)**
```jsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-[var(--grid-gap-lg)]">
```

**2-Column Grid (Content + Sidebar)**
```jsx
<div className="grid grid-cols-1 lg:grid-cols-3 gap-[var(--grid-gap-lg)]">
  <div className="lg:col-span-2">Main Content</div>
  <div>Sidebar</div>
</div>
```

---

## Components

### Button

**Variants:**
| Variant | Usage |
|---------|-------|
| `primary` | Main CTAs, form submissions |
| `secondary` | Secondary actions |
| `outline` | Alternative actions, less emphasis |
| `ghost` | Tertiary actions, minimal style |
| `gold` | Premium/special actions |

**Sizes:**
| Size | Padding | Font Size |
|------|---------|-----------|
| `sm` | `px-3 py-1.5` | `text-sm` |
| `md` | `px-5 py-2.5` | `text-base` |
| `lg` | `px-8 py-3.5` | `text-lg` |

**Usage:**
```jsx
import { Button } from "@/components/ui/button";

<Button variant="primary" size="lg">View Tournaments</Button>
<Button variant="outline" size="md">Learn More</Button>
<Button variant="gold" size="lg">Download App</Button>
```

### Card

**Variants:**
| Variant | Description |
|---------|-------------|
| `default` | Basic card with surface background |
| `bordered` | Card with border |
| `elevated` | Card with shadow |

**Sub-components:**
- `CardHeader` - Top section (p-6 pb-0)
- `CardContent` - Main content (p-6)
- `CardFooter` - Bottom section (p-6 pt-0)
- `CardImage` - Image with aspect ratio

**Usage:**
```jsx
import { Card, CardContent, CardImage } from "@/components/ui/card";

<Card hover variant="bordered">
  <CardImage src="/image.jpg" alt="Description" aspectRatio="16/9" />
  <CardContent>
    <h3>Card Title</h3>
    <p>Card description</p>
  </CardContent>
</Card>
```

### Badge

**Variants:**
| Variant | Color | Usage |
|---------|-------|-------|
| `default` | Gray | Default state |
| `primary` | Red | Primary category |
| `success` | Green | Success/active |
| `warning` | Orange | Warnings |
| `error` | Red | Errors |
| `gold` | Gold | Premium/featured |
| `live` | Red + pulse | Live events |

**Sizes:** `sm`, `md`, `lg`

**Usage:**
```jsx
import { Badge } from "@/components/ui/badge";

<Badge variant="live">LIVE NOW</Badge>
<Badge variant="gold" size="sm">FEATURED</Badge>
<Badge variant="primary">UPCOMING</Badge>
```

### Input

**Usage:**
```jsx
import { Input } from "@/components/ui/input";

<Input type="email" placeholder="Enter your email" />
```

---

## Animation Guidelines

### Framer Motion Standards

**Entrance Animations:**
```jsx
// Fade up animation
initial={{ opacity: 0, y: 20 }}
animate={{ opacity: 1, y: 0 }}
transition={{ duration: 0.6 }}

// Staggered children
const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.1 }
  }
};

const item = {
  hidden: { opacity: 0, y: 20 },
  show: { opacity: 1, y: 0 }
};
```

**Scroll-triggered Animations:**
```jsx
<motion.div
  initial={{ opacity: 0, y: 10 }}
  whileInView={{ opacity: 1, y: 0 }}
  viewport={{ once: true }}
>
```

**Transition Timing:**
| Type | Duration | Easing |
|------|----------|--------|
| Micro-interactions | 0.2s | ease |
| UI transitions | 0.3s | ease |
| Page elements | 0.5-0.6s | ease |
| Stagger delay | 0.1s | - |

### CSS Animations
```css
.animate-fadeIn   /* Fade in */
.animate-slideUp  /* Slide up with fade */
.animate-pulse    /* Pulsing opacity */
```

### Hover Effects
```css
.card-hover {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.card-hover:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
}
```

---

## Responsive Design

### Breakpoints
| Name | Min Width | Usage |
|------|-----------|-------|
| `sm` | 640px | Large phones, small tablets |
| `md` | 768px | Tablets |
| `lg` | 1024px | Small laptops |
| `xl` | 1280px | Desktops |
| `2xl` | 1536px | Large screens |

### Mobile-First Approach
Always write base styles for mobile, then add breakpoint modifiers:

```jsx
// Mobile: 1 col, Tablet: 2 col, Desktop: 3 col
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
```

### Responsive Typography
```jsx
// Responsive heading
<h1 className="text-4xl md:text-6xl lg:text-7xl">
```

### Responsive Spacing
```jsx
// Responsive padding
<div className="p-4 md:p-8 lg:p-16">
```

---

## Accessibility

### Color Contrast
- All text must meet WCAG 2.1 AA standards
- Primary text on dark backgrounds: minimum 4.5:1 ratio
- Large text (18px+): minimum 3:1 ratio

### Focus States
```css
:focus-visible {
  outline: 2px solid var(--primary);
  outline-offset: 2px;
}
```

### Interactive Elements
- All buttons must have clear hover/focus states
- Touch targets should be at least 44x44px
- Links should be distinguishable from regular text

### ARIA Labels
```jsx
// Always provide aria-labels for icon-only buttons
<button aria-label="Previous winner">
  <ChevronLeft />
</button>
```

### Keyboard Navigation
- All interactive elements must be keyboard accessible
- Focus order should follow visual order
- Modals should trap focus

---

## File Structure

```
src/
├── app/
│   ├── globals.css          # Design tokens & global styles
│   └── layout.tsx           # Font loading
├── components/
│   ├── ui/                   # Base UI components
│   │   ├── button.tsx
│   │   ├── card.tsx
│   │   ├── badge.tsx
│   │   └── input.tsx
│   ├── sections/             # Page sections
│   │   ├── hero.tsx
│   │   ├── featured-tournaments.tsx
│   │   ├── winners-carousel.tsx
│   │   ├── news-highlights.tsx
│   │   ├── cta-section.tsx
│   │   └── sponsors.tsx
│   └── layout/               # Layout components
│       ├── header.tsx
│       └── footer.tsx
└── lib/
    └── utils.ts              # Utility functions (cn, formatCurrency, etc.)
```

---

## Quick Reference

### Section Template
```jsx
export function MySection() {
  return (
    <section className="section bg-[var(--background)]">
      <div className="container">
        {/* Section Header */}
        <div className="section-header">
          <span className="text-[var(--primary)] font-semibold text-sm uppercase tracking-wider">
            Section Label
          </span>
          <h2 className="text-3xl md:text-4xl font-bold mt-2">
            Section Title
          </h2>
        </div>

        {/* Content Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-[var(--grid-gap)]">
          {/* Grid items */}
        </div>
      </div>
    </section>
  );
}
```

### Color Usage Summary
- **Red (`--primary`)**: CTAs, important actions, live badges
- **Gold (`--gold`)**: Prizes, rankings, premium features
- **White (`--foreground`)**: Headings, primary text
- **Gray (`--foreground-secondary`)**: Body text, descriptions
- **Dark Gray (`--foreground-muted`)**: Timestamps, tertiary info

---

*Last updated: January 2026*

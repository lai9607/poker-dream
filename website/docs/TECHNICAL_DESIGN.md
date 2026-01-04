# Poker Dream Website - Technical Design Document

**Version:** 1.0
**Last Updated:** 2026-01-04
**Document Owner:** Technical Team

---

## Table of Contents

1. [Overview](#overview)
2. [Technology Stack](#technology-stack)
3. [Design System](#design-system)
4. [Project Structure](#project-structure)
5. [Component Architecture](#component-architecture)
6. [Styling Approach](#styling-approach)
7. [Animation Strategy](#animation-strategy)
8. [Responsive Design](#responsive-design)
9. [Data Flow](#data-flow)
10. [Type System](#type-system)
11. [Routing Strategy](#routing-strategy)
12. [Future Considerations](#future-considerations)

---

## Overview

The Poker Dream website is a modern, high-performance web application built to showcase Asia's premier poker tournament series. The application serves as the primary digital presence for Poker Dream, providing tournament information, player rankings, news, and live updates.

### Key Features

- Tournament browsing and detailed information
- DPOY (Dream Poker of the Year) rankings
- Live tournament reporting
- News and media galleries
- Responsive design across all devices
- Smooth animations and transitions
- SEO-optimized pages

### Target Audience

- Poker players (amateur to professional)
- Tournament organizers
- Media and press
- Sponsors and partners

---

## Technology Stack

### Core Framework

- **Next.js 16.1.1**
  - App Router architecture (not Pages Router)
  - Server Components by default
  - File-based routing
  - Built-in image optimization
  - Automatic code splitting

- **React 19.2.3**
  - Latest features and performance improvements
  - Server and Client Components
  - Enhanced hooks and concurrency

### Language

- **TypeScript 5.x**
  - Strict mode enabled
  - Type-safe development
  - Enhanced IDE support
  - Path aliases configured (`@/*` → `./src/*`)

### Styling

- **Tailwind CSS 4.x**
  - Utility-first CSS framework
  - PostCSS integration via `@tailwindcss/postcss`
  - Custom design tokens
  - JIT (Just-In-Time) compilation

### Animation

- **Framer Motion 12.23.26**
  - Declarative animations
  - Gesture support
  - Layout animations
  - Scroll-triggered animations

### UI Libraries

- **Lucide React 0.562.0** - Icon library
- **clsx 2.1.1** - Conditional classNames utility
- **tailwind-merge 3.4.0** - Tailwind class merging utility

### Form Management

- **React Hook Form 7.69.0** - Form state management
- **Zod 4.3.4** - Schema validation
- **@hookform/resolvers 5.2.2** - Validation integration

### Utilities

- **axios 1.13.2** - HTTP client
- **date-fns 4.1.0** - Date formatting and manipulation
- **next-intl 4.7.0** - Internationalization support

### Development Tools

- **ESLint 9.x** - Code linting
- **TypeScript 5.x** - Type checking
- **PostCSS** - CSS processing

---

## Design System

The design system is centralized in `/src/app/globals.css` and uses CSS custom properties for consistent theming across the application.

### Color Palette

#### Primary Colors
```css
--primary: #E53935        /* Main brand color (red) */
--primary-dark: #C62828   /* Darker variant for hover states */
--primary-light: #EF5350  /* Lighter variant for accents */
```

#### Accent Colors (Gold)
```css
--gold: #FFD700           /* Primary gold for awards/prizes */
--gold-dark: #FFC107      /* Darker gold variant */
--gold-light: #FFEB3B     /* Lighter gold variant */
```

#### Neutral/Background Colors
```css
--background: #0A0A0A              /* Primary background (near black) */
--background-secondary: #121212    /* Secondary background */
--background-tertiary: #1A1A1A     /* Tertiary background */
--surface: #1E1E1E                 /* Card/component surfaces */
--surface-hover: #2A2A2A           /* Hover state for surfaces */
```

#### Text Colors
```css
--foreground: #FFFFFF              /* Primary text (white) */
--foreground-secondary: #B3B3B3    /* Secondary text (light gray) */
--foreground-muted: #666666        /* Muted text (dark gray) */
```

#### Border Colors
```css
--border: #333333                  /* Primary border color */
--border-light: #444444            /* Lighter border variant */
```

#### Status Colors
```css
--success: #4CAF50    /* Success states */
--warning: #FF9800    /* Warning states */
--error: #F44336      /* Error states */
--info: #2196F3       /* Info states */
```

### Shadows

Pre-defined shadow levels for elevation:

```css
--shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.5)
--shadow-md: 0 4px 6px rgba(0, 0, 0, 0.5)
--shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.5)
--shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.5)
```

### Gradients

Pre-defined gradient patterns:

```css
--gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%)
--gradient-gold: linear-gradient(135deg, var(--gold) 0%, var(--gold-dark) 100%)
--gradient-dark: linear-gradient(180deg, var(--background) 0%, var(--background-secondary) 100%)
```

### Typography

#### Font Family

- **Primary:** Space Grotesk (Google Fonts)
- **Fallback:** system-ui, sans-serif
- **Loading Strategy:** `display: swap` for better performance

#### Font Sizes (Headings)

```css
h1 { font-size: 3rem; }       /* 48px */
h2 { font-size: 2.25rem; }    /* 36px */
h3 { font-size: 1.875rem; }   /* 30px */
h4 { font-size: 1.5rem; }     /* 24px */
h5 { font-size: 1.25rem; }    /* 20px */
h6 { font-size: 1rem; }       /* 16px */
```

#### Typography Features

- **Line Height:** 1.6 (body), 1.2 (headings)
- **Font Weight:** 700 (headings), 400-600 (body)
- **Font Smoothing:** Antialiased on all browsers
- **Letter Spacing:** Uppercase text uses `tracking-wider`

### Utility Classes

#### Text Gradients

```css
.text-gradient-primary  /* Primary red gradient on text */
.text-gradient-gold     /* Gold gradient on text */
```

#### Background Gradients

```css
.bg-gradient-primary    /* Primary red gradient background */
.bg-gradient-gold       /* Gold gradient background */
```

#### Card Effects

```css
.card-hover             /* Adds hover lift effect with shadow */
```

#### Animations

```css
.animate-fadeIn         /* Fade in animation */
.animate-slideUp        /* Slide up animation */
.animate-pulse          /* Pulsing animation */
```

### Browser-Specific Styling

#### Scrollbar Customization

- **Width/Height:** 8px
- **Track:** Dark background
- **Thumb:** Border color with hover state
- **Border Radius:** 4px

#### Text Selection

- **Background:** Primary red
- **Color:** White

#### Focus States

- **Outline:** 2px solid primary color
- **Offset:** 2px from element

---

## Project Structure

The application follows Next.js 13+ App Router conventions with a feature-based organization.

```
/Users/clifflai/development/vsc-workspace/poker-dream/website/
├── public/                    # Static assets
├── src/
│   ├── app/                   # Next.js App Router
│   │   ├── globals.css        # Global styles and design system
│   │   ├── layout.tsx         # Root layout with metadata
│   │   ├── page.tsx           # Homepage
│   │   ├── about/             # About page
│   │   ├── careers/           # Careers page
│   │   ├── contact/           # Contact page
│   │   ├── dpoy/              # DPOY rankings
│   │   ├── gallery/           # Gallery pages
│   │   │   ├── page.tsx
│   │   │   ├── champions/
│   │   │   └── tournaments/
│   │   ├── live-reports/      # Live tournament reports
│   │   ├── news/              # News section
│   │   │   ├── page.tsx
│   │   │   └── [id]/          # Dynamic news article
│   │   ├── privacy/           # Privacy policy
│   │   ├── terms/             # Terms of service
│   │   └── tournaments/       # Tournament section
│   │       ├── page.tsx
│   │       └── [id]/          # Dynamic tournament page
│   ├── components/            # Reusable components
│   │   ├── layout/            # Layout components
│   │   │   ├── header.tsx
│   │   │   ├── footer.tsx
│   │   │   └── index.ts
│   │   ├── sections/          # Page sections
│   │   │   ├── hero.tsx
│   │   │   ├── featured-tournaments.tsx
│   │   │   ├── winners-carousel.tsx
│   │   │   ├── news-highlights.tsx
│   │   │   ├── cta-section.tsx
│   │   │   ├── sponsors.tsx
│   │   │   └── index.ts
│   │   └── ui/                # Base UI components
│   │       ├── button.tsx
│   │       ├── card.tsx
│   │       ├── badge.tsx
│   │       ├── input.tsx
│   │       └── index.ts
│   ├── config/                # Configuration files
│   │   └── navigation.ts      # Navigation and site config
│   ├── lib/                   # Utility functions
│   │   └── utils.ts           # Helper functions
│   └── types/                 # TypeScript types
│       └── index.ts           # All type definitions
├── docs/                      # Documentation
├── package.json               # Dependencies
├── tsconfig.json              # TypeScript config
├── next.config.ts             # Next.js config
├── postcss.config.mjs         # PostCSS config
└── eslint.config.mjs          # ESLint config
```

### Directory Conventions

#### `/app` - Next.js App Router

- Each folder can contain a `page.tsx` (route) or `layout.tsx` (shared layout)
- `[id]` folders indicate dynamic routes
- Automatic route generation based on folder structure
- Server Components by default

#### `/components` - Component Organization

- **`/layout`** - Components that define page structure (Header, Footer)
- **`/sections`** - Larger page sections (Hero, Featured Tournaments, etc.)
- **`/ui`** - Reusable primitive UI components (Button, Card, Badge, Input)
- Each directory contains an `index.ts` for clean exports

#### `/config` - Configuration Files

- Navigation structure
- Site metadata
- Constants and configuration objects

#### `/lib` - Utility Functions

- Helper functions (formatters, utilities)
- Shared business logic
- Common utilities used across components

#### `/types` - Type Definitions

- Centralized TypeScript type definitions
- Interfaces for data models
- API response types

---

## Component Architecture

### Component Categories

Components are organized into three main categories based on their purpose and complexity.

### 1. Layout Components

Located in `/src/components/layout/`

#### Header Component

**File:** `/src/components/layout/header.tsx`

**Purpose:** Global navigation bar with responsive mobile menu

**Features:**
- Fixed positioning with scroll-based styling changes
- Desktop dropdown navigation
- Mobile hamburger menu with slide-out drawer
- Active route highlighting
- Backdrop blur on scroll
- Call-to-action buttons

**Key Technologies:**
- Client Component (`"use client"`)
- Next.js `usePathname()` for active route detection
- React hooks (`useState`, `useEffect`) for scroll and menu state
- Conditional rendering for desktop/mobile layouts

**Component Props:** None (uses route-based configuration)

**State Management:**
```typescript
- isScrolled: boolean           // Track scroll position
- isMobileMenuOpen: boolean     // Mobile menu toggle
- openDropdown: string | null   // Active dropdown menu
```

#### Footer Component

**File:** `/src/components/layout/footer.tsx`

**Purpose:** Site-wide footer with links and contact information

**Features:**
- Multi-column link organization
- Social media links
- Contact information
- Copyright notice
- Newsletter signup (placeholder)

### 2. Section Components

Located in `/src/components/sections/`

These are larger, feature-specific components that compose multiple UI components.

#### Hero Section

**File:** `/src/components/sections/hero.tsx`

**Purpose:** Landing page hero with background image and key statistics

**Features:**
- Full-screen hero with background image
- Gradient overlays for text readability
- Animated content entrance
- Call-to-action buttons
- Statistics grid
- Scroll indicator

**Animations:**
- Staggered fade-in for text elements
- Smooth scroll indicator animation
- Initial render animations with delays

**Implementation Details:**
```typescript
// Motion variants for staggered animations
initial={{ opacity: 0, y: 20 }}
animate={{ opacity: 1, y: 0 }}
transition={{ duration: 0.6, delay: 0.1 }}
```

#### Featured Tournaments

**File:** `/src/components/sections/featured-tournaments.tsx`

**Purpose:** Display grid of upcoming and live tournaments

**Features:**
- Responsive grid layout (1/2/3 columns)
- Tournament cards with images
- Status badges (UPCOMING, LIVE)
- Prize pool and buy-in information
- Entry count display
- Staggered animation on scroll

**Data Structure:**
```typescript
Tournament {
  id, name, description,
  startDate, endDate,
  location, venue, status,
  prizePool, buyIn, totalEntries,
  imageUrl
}
```

**Animation Pattern:**
```typescript
// Container with staggered children
const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.1 }
  }
}
```

#### Winners Carousel

**File:** `/src/components/sections/winners-carousel.tsx`

**Purpose:** Showcase recent tournament winners in a carousel

**Features:**
- Auto-playing carousel (5s intervals)
- Manual navigation (arrows and dots)
- Slide animations with exit transitions
- Winner profile with country flag
- Prize amount display
- Responsive image layouts

**State Management:**
```typescript
- currentIndex: number    // Active slide index
- autoPlay: boolean       // Auto-advance toggle
```

**Animation Strategy:**
- `AnimatePresence` for exit animations
- Slide transitions with `x` axis movement
- Pause auto-play on user interaction

#### News Highlights

**File:** `/src/components/sections/news-highlights.tsx`

**Purpose:** Display latest news articles

**Features:**
- Grid of news cards
- Category badges
- Published date formatting
- Excerpt preview
- Link to full article

#### CTA Section

**File:** `/src/components/sections/cta-section.tsx`

**Purpose:** Call-to-action for tournament registration

**Features:**
- Prominent heading and description
- Primary action button
- Background gradient
- Centered layout

#### Sponsors Section

**File:** `/src/components/sections/sponsors.tsx`

**Purpose:** Display sponsor logos and partnerships

**Features:**
- Tiered sponsor display (Platinum, Gold, Silver, Bronze)
- Logo grid layouts
- Grayscale to color on hover
- Responsive columns

### 3. UI Components

Located in `/src/components/ui/`

Primitive, reusable components following a consistent API pattern.

#### Button Component

**File:** `/src/components/ui/button.tsx`

**API:**
```typescript
interface ButtonProps {
  variant?: "primary" | "secondary" | "outline" | "ghost" | "gold"
  size?: "sm" | "md" | "lg"
  isLoading?: boolean
  disabled?: boolean
  children: ReactNode
}
```

**Variants:**
- **primary:** Red background, white text (main actions)
- **secondary:** Dark surface background (secondary actions)
- **outline:** Red border, transparent background
- **ghost:** Transparent, minimal styling
- **gold:** Gold background, black text (premium actions)

**Sizes:**
- **sm:** `px-3 py-1.5 text-sm`
- **md:** `px-5 py-2.5 text-base`
- **lg:** `px-8 py-3.5 text-lg`

**Features:**
- Loading state with spinner
- Focus ring for accessibility
- Disabled state styling
- Transitions on all interactive states

#### Card Component

**File:** `/src/components/ui/card.tsx`

**Components:**
- `Card` - Main container
- `CardHeader` - Optional header section
- `CardContent` - Main content area
- `CardFooter` - Optional footer section
- `CardImage` - Image with aspect ratio control

**API:**
```typescript
interface CardProps {
  variant?: "default" | "bordered" | "elevated"
  hover?: boolean
}
```

**Variants:**
- **default:** Surface background, no border
- **bordered:** Surface background with border
- **elevated:** Surface background with shadow

**Hover Effect:**
- Lift animation (`translateY(-4px)`)
- Enhanced shadow
- Smooth transition (300ms)

#### Badge Component

**File:** `/src/components/ui/badge.tsx`

**API:**
```typescript
interface BadgeProps {
  variant?: "default" | "primary" | "success" | "warning" | "error" | "gold" | "live"
  size?: "sm" | "md" | "lg"
}
```

**Special Features:**
- **live** variant includes pulsing dot animation
- Rounded pill shape
- Color-coded by variant
- Multiple sizes

#### Input Component

**File:** `/src/components/ui/input.tsx`

**API:**
```typescript
interface InputProps {
  label?: string
  error?: string
  helperText?: string
}
```

**Features:**
- Optional label
- Error state with message
- Helper text
- Focus states
- Accessible form controls

### Component Composition Pattern

All section components follow a similar pattern:

1. **Import Dependencies**
   - UI components from `@/components/ui`
   - Utilities from `@/lib/utils`
   - Icons from `lucide-react`
   - Animation from `framer-motion`

2. **Define Data** (Mock or API)
   - Type-safe data structures
   - Will be replaced with API calls

3. **Animation Variants**
   - Define motion variants
   - Scroll-triggered animations

4. **Component Structure**
   ```tsx
   export function ComponentName() {
     return (
       <section className="py-20 bg-[var(--background)]">
         <div className="container">
           {/* Section Header */}
           {/* Main Content */}
         </div>
       </section>
     )
   }
   ```

5. **Responsive Layout**
   - Mobile-first approach
   - Tailwind responsive utilities

---

## Styling Approach

### Utility-First with Custom Properties

The application uses a hybrid approach combining Tailwind CSS utilities with CSS custom properties for theming.

#### CSS Custom Properties Strategy

**Definition Location:** `/src/app/globals.css`

**Integration with Tailwind:**
```css
@theme inline {
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --color-primary: var(--primary);
  /* ... more mappings */
}
```

**Usage in Components:**
```tsx
// Direct CSS variable usage
<div className="bg-[var(--background)] text-[var(--foreground)]">

// Via Tailwind utilities (when mapped)
<div className="bg-background text-foreground">
```

#### Benefits of This Approach

1. **Theme Consistency:** Single source of truth for colors
2. **Runtime Flexibility:** CSS variables can be changed dynamically
3. **Tailwind Integration:** Use both custom vars and Tailwind utilities
4. **Type Safety:** TypeScript ensures valid class names
5. **Developer Experience:** Autocomplete for Tailwind classes

### Tailwind CSS Configuration

**Version:** 4.x (latest)

**Configuration:** Via `@theme` directive in `globals.css`

**PostCSS Setup:**
```javascript
// postcss.config.mjs
{
  plugins: {
    "@tailwindcss/postcss": {}
  }
}
```

### Class Name Composition

**Utility Function:** `/src/lib/utils.ts`

```typescript
import { clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
```

**Purpose:**
- `clsx`: Conditional class name composition
- `twMerge`: Intelligently merges Tailwind classes, resolving conflicts

**Usage Example:**
```tsx
<button
  className={cn(
    "px-4 py-2 rounded",  // Base classes
    variant === "primary" && "bg-primary text-white",  // Conditional
    className  // Allow override from props
  )}
/>
```

### Responsive Design Utilities

**Breakpoints (Tailwind defaults):**
- **sm:** 640px
- **md:** 768px
- **lg:** 1024px
- **xl:** 1280px
- **2xl:** 1536px

**Usage Pattern:**
```tsx
<div className="text-sm md:text-base lg:text-lg">
```

### Container Class

**Definition:**
```css
.container {
  width: 100%;
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 1rem;  /* mobile */
}

@media (min-width: 640px) {
  .container { padding: 0 1.5rem; }
}

@media (min-width: 1024px) {
  .container { padding: 0 2rem; }
}
```

**Usage:** Wrap all section content for consistent layout

### Typography Utilities

**Font Loading:**
```tsx
// layout.tsx
import { Space_Grotesk } from "next/font/google"

const spaceGrotesk = Space_Grotesk({
  subsets: ["latin"],
  display: "swap",
  variable: "--font-space-grotesk",
})
```

**Application:**
```tsx
<html className={spaceGrotesk.variable}>
  <body className={spaceGrotesk.className}>
```

---

## Animation Strategy

### Framer Motion Integration

**Version:** 12.23.26

**Usage Pattern:** Client Components only

### Animation Patterns

#### 1. Entrance Animations

**Fade In:**
```tsx
<motion.div
  initial={{ opacity: 0, y: 20 }}
  animate={{ opacity: 1, y: 0 }}
  transition={{ duration: 0.6 }}
>
```

**Staggered Children:**
```tsx
const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.1 }
  }
}

const item = {
  hidden: { opacity: 0, y: 20 },
  show: { opacity: 1, y: 0 }
}

<motion.div variants={container} initial="hidden" animate="show">
  {items.map(item => (
    <motion.div key={item.id} variants={item}>
  ))}
</motion.div>
```

#### 2. Scroll-Triggered Animations

**Using Viewport Detection:**
```tsx
<motion.h2
  initial={{ opacity: 0, y: 10 }}
  whileInView={{ opacity: 1, y: 0 }}
  viewport={{ once: true }}  // Only animate once
  transition={{ delay: 0.1 }}
>
```

**Benefits:**
- Animations trigger when element enters viewport
- `once: true` prevents re-animation on scroll
- Improves performance by not animating off-screen elements

#### 3. Exit Animations

**Using AnimatePresence:**
```tsx
<AnimatePresence mode="wait">
  <motion.div
    key={currentIndex}
    initial={{ opacity: 0, x: 100 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: -100 }}
    transition={{ duration: 0.5 }}
  >
```

**Mode Options:**
- `wait`: New element waits for old to exit
- `sync`: Elements transition simultaneously
- `popLayout`: Maintain layout during exit

#### 4. Continuous Animations

**Scroll Indicator:**
```tsx
<motion.div
  animate={{ y: [0, 12, 0] }}
  transition={{
    duration: 1.5,
    repeat: Infinity
  }}
/>
```

**Pulse Effect (CSS Alternative):**
```css
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.animate-pulse {
  animation: pulse 2s ease-in-out infinite;
}
```

#### 5. Hover Animations

**Button Hover:**
```tsx
<motion.button
  whileHover={{ scale: 1.05 }}
  whileTap={{ scale: 0.95 }}
/>
```

**Card Hover (CSS-based):**
```css
.card-hover {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card-hover:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
}
```

### Performance Considerations

1. **Use CSS when possible:** Simple transitions use CSS instead of JS
2. **Limit animated properties:** Prefer transforms and opacity
3. **Viewport detection:** Only animate visible elements
4. **Once flag:** Prevent re-animations (`viewport={{ once: true }}`)
5. **Layout animations:** Use `layout` prop sparingly (performance cost)

### Animation Timing

**Standard Durations:**
- **Fast:** 0.2s - 0.3s (hover states, toggles)
- **Medium:** 0.5s - 0.6s (entrance animations)
- **Slow:** 1s - 1.5s (continuous animations)

**Easing:**
- Default: `ease` (smooth acceleration/deceleration)
- Bounce: For playful interactions
- Linear: For continuous loops

---

## Responsive Design

### Mobile-First Approach

All components are designed mobile-first, with styles progressively enhanced for larger screens.

### Breakpoint Strategy

**Tailwind Breakpoints:**
```
sm:   640px   (Small tablets)
md:   768px   (Tablets)
lg:   1024px  (Small desktops)
xl:   1280px  (Desktops)
2xl:  1536px  (Large desktops)
```

### Responsive Patterns

#### 1. Grid Layouts

**Tournament Cards:**
```tsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
```

**Pattern:**
- Mobile: 1 column
- Tablet: 2 columns
- Desktop: 3 columns

#### 2. Typography Scaling

**Headings:**
```tsx
<h1 className="text-4xl md:text-6xl lg:text-7xl">
```

**Pattern:**
- Mobile: Smaller text
- Tablet: Medium text
- Desktop: Largest text

#### 3. Layout Changes

**Hero Statistics:**
```tsx
<div className="grid grid-cols-3 gap-8">  {/* Always 3 cols */}
  <p className="text-3xl md:text-4xl">    {/* Scale text */}
```

#### 4. Conditional Display

**Navigation:**
```tsx
<div className="hidden lg:flex">  {/* Desktop nav */}
<button className="lg:hidden">    {/* Mobile menu button */}
```

#### 5. Spacing Adjustments

**Section Padding:**
```tsx
<section className="py-12 md:py-16 lg:py-20">
```

**Container Padding:**
```css
.container {
  padding: 0 1rem;      /* mobile */
}
@media (min-width: 640px) {
  padding: 0 1.5rem;    /* tablet */
}
@media (min-width: 1024px) {
  padding: 0 2rem;      /* desktop */
}
```

#### 6. Flex Direction Changes

**Winner Carousel:**
```tsx
<div className="flex flex-col md:flex-row">
```

**Pattern:**
- Mobile: Stack vertically
- Desktop: Side-by-side

### Container Widths

**Max Widths:**
```css
.container {
  max-width: 1280px;  /* Matches xl breakpoint */
}
```

**Full Width Sections:**
```tsx
<section className="w-full">
  <div className="container">  {/* Constrained content */}
```

### Touch Considerations

**Mobile Menu:**
- Tap targets minimum 44x44px
- Larger padding on mobile buttons
- Swipe gestures for carousel

**Hover States:**
- Hover effects only on devices that support it
- Touch feedback for mobile interactions

### Image Responsiveness

**Next.js Image Component:**
```tsx
<img
  src={imageUrl}
  alt={description}
  className="w-full h-full object-cover"
/>
```

**Aspect Ratios:**
```tsx
<div style={{ aspectRatio: "16/9" }}>
```

### Testing Breakpoints

**Recommended Test Widths:**
- 375px (iPhone SE)
- 768px (iPad)
- 1024px (iPad Pro)
- 1280px (Desktop)
- 1920px (Large Desktop)

---

## Data Flow

### Current Implementation (Mock Data)

Currently, all data is statically defined within components as TypeScript constants.

#### Mock Data Locations

**Featured Tournaments:**
```typescript
// src/components/sections/featured-tournaments.tsx
const featuredTournaments: Tournament[] = [
  {
    id: "1",
    name: "Poker Dream 18 Main Event",
    prizePool: 5000000,
    // ...
  }
]
```

**Winners:**
```typescript
// src/components/sections/winners-carousel.tsx
const winners: Winner[] = [
  {
    id: "1",
    name: "Michael Chen",
    prize: 1250000,
    // ...
  }
]
```

### Future API Integration Points

The application is structured to easily transition to API-based data fetching.

#### Recommended Architecture

**1. API Client Setup**

```typescript
// src/lib/api-client.ts (to be created)
import axios from 'axios'

const apiClient = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json'
  }
})

export default apiClient
```

**2. API Service Functions**

```typescript
// src/services/tournaments.ts (to be created)
import apiClient from '@/lib/api-client'
import { Tournament, ApiResponse } from '@/types'

export async function getFeaturedTournaments(): Promise<Tournament[]> {
  const response = await apiClient.get<ApiResponse<Tournament[]>>(
    '/tournaments/featured'
  )
  return response.data.data
}

export async function getTournamentById(id: string): Promise<Tournament> {
  const response = await apiClient.get<ApiResponse<Tournament>>(
    `/tournaments/${id}`
  )
  return response.data.data
}
```

**3. Server Component Data Fetching**

```typescript
// src/app/tournaments/page.tsx (future implementation)
import { getFeaturedTournaments } from '@/services/tournaments'

export default async function TournamentsPage() {
  const tournaments = await getFeaturedTournaments()

  return (
    <TournamentList tournaments={tournaments} />
  )
}
```

**4. Client Component with State**

```typescript
// For dynamic/interactive data
"use client"
import { useState, useEffect } from 'react'
import { getTournamentStandings } from '@/services/tournaments'

export function LiveStandings({ tournamentId }: { tournamentId: string }) {
  const [standings, setStandings] = useState([])

  useEffect(() => {
    async function fetchStandings() {
      const data = await getTournamentStandings(tournamentId)
      setStandings(data)
    }
    fetchStandings()
  }, [tournamentId])

  return (/* ... */)
}
```

#### API Endpoints to Implement

**Tournaments:**
- `GET /tournaments/featured` - Featured tournaments
- `GET /tournaments/:id` - Tournament details
- `GET /tournaments/:id/standings` - Live standings
- `GET /tournaments/:id/structure` - Blind structure

**Players:**
- `GET /players/:id` - Player profile
- `GET /players/dpoy` - DPOY rankings

**News:**
- `GET /news` - List articles (paginated)
- `GET /news/:id` - Article details

**Live Reports:**
- `GET /live-reports/:tournamentId` - Live updates
- `WS /live-reports/:tournamentId/stream` - WebSocket for real-time updates

**Gallery:**
- `GET /gallery/tournaments` - Tournament photos
- `GET /gallery/champions` - Champion photos

**Contact:**
- `POST /contact` - Submit contact form

### Environment Variables

**To be configured:**
```env
# .env.local
NEXT_PUBLIC_API_URL=https://api.pokerdream.com
NEXT_PUBLIC_WS_URL=wss://api.pokerdream.com
```

### Caching Strategy

**Next.js Server Components:**
- Automatic caching for `fetch()` requests
- Revalidation intervals configurable

**Example:**
```typescript
fetch('https://api.pokerdream.com/tournaments', {
  next: { revalidate: 60 }  // Revalidate every 60 seconds
})
```

### Error Handling

**API Error Types:**
```typescript
// src/types/index.ts (add to existing types)
export interface ApiError {
  message: string
  code: string
  statusCode: number
}
```

**Error Boundary:**
```typescript
// src/app/error.tsx (to be created)
'use client'

export default function Error({
  error,
  reset,
}: {
  error: Error
  reset: () => void
}) {
  return (
    <div>
      <h2>Something went wrong!</h2>
      <button onClick={reset}>Try again</button>
    </div>
  )
}
```

### Loading States

**Page-level Loading:**
```typescript
// src/app/tournaments/loading.tsx (to be created)
export default function Loading() {
  return <TournamentsSkeleton />
}
```

**Component-level Loading:**
```tsx
{isLoading ? <Spinner /> : <TournamentCard tournament={data} />}
```

---

## Type System

### Type Organization

All types are centralized in `/src/types/index.ts` for easy maintenance and reusability.

### Core Data Types

#### Tournament Types

```typescript
interface Tournament {
  id: string
  name: string
  description: string
  startDate: string
  endDate: string
  location: string
  venue: string
  status: TournamentStatus
  prizePool: number
  buyIn: number
  totalEntries: number
  imageUrl?: string
  structure?: TournamentStructure
  standings?: Standing[]
}

type TournamentStatus = "UPCOMING" | "LIVE" | "COMPLETED" | "CANCELLED"

interface TournamentStructure {
  id: string
  levels: BlindLevel[]
  startingChips: number
  lateRegistrationLevel: number
}

interface BlindLevel {
  level: number
  smallBlind: number
  bigBlind: number
  ante: number
  duration: number  // minutes
}
```

#### Player Types

```typescript
interface Player {
  id: string
  name: string
  country: string
  countryCode: string
  profileImage?: string
  totalEarnings?: number
  dpoyPoints?: number
  rank?: number
}

interface Standing {
  id: string
  tournamentId: string
  player: Player
  rank: number
  chips: number
  isSurvivor: boolean
  prizeAmount?: number
}

interface DPOYEntry {
  rank: number
  player: Player
  points: number
  eventsPlayed: number
  bestFinish: number
}
```

#### News Types

```typescript
interface NewsArticle {
  id: string
  title: string
  summary: string
  content: string
  imageUrl?: string
  category: NewsCategory
  author: string
  publishedAt: string
  createdAt: string
  updatedAt: string
}

type NewsCategory =
  | "TOURNAMENT"
  | "STRATEGY"
  | "PLAYER_INTERVIEW"
  | "ANNOUNCEMENT"
  | "PROMOTION"
```

#### Other Types

```typescript
// Navigation
interface NavItem {
  label: string
  href: string
  children?: NavItem[]
}

// Sponsors
interface Sponsor {
  id: string
  name: string
  logoUrl: string
  website?: string
  tier: SponsorTier
  displayOrder: number
}

type SponsorTier = "PLATINUM" | "GOLD" | "SILVER" | "BRONZE"

// Gallery
interface GalleryImage {
  id: string
  url: string
  thumbnailUrl: string
  caption?: string
  tournamentId?: string
  type: GalleryType
  createdAt: string
}

type GalleryType = "TOURNAMENT" | "CHAMPION" | "EVENT"
```

### API Response Types

```typescript
interface ApiResponse<T> {
  data: T
  message?: string
  success: boolean
}

interface PaginatedResponse<T> {
  data: T[]
  total: number
  page: number
  limit: number
  totalPages: number
}
```

### Type Usage Examples

**Component Props:**
```typescript
interface TournamentCardProps {
  tournament: Tournament
  onClick?: () => void
}

export function TournamentCard({ tournament, onClick }: TournamentCardProps) {
  // ...
}
```

**API Functions:**
```typescript
async function getTournaments(): Promise<ApiResponse<Tournament[]>> {
  // ...
}
```

---

## Routing Strategy

### App Router Architecture

The application uses Next.js 13+ App Router with file-based routing.

### Route Structure

```
/                          → Homepage (app/page.tsx)
/tournaments               → Tournament list (app/tournaments/page.tsx)
/tournaments/[id]          → Tournament detail (app/tournaments/[id]/page.tsx)
/dpoy                      → DPOY rankings (app/dpoy/page.tsx)
/live-reports              → Live reports (app/live-reports/page.tsx)
/news                      → News list (app/news/page.tsx)
/news/[id]                 → News article (app/news/[id]/page.tsx)
/gallery                   → Gallery overview (app/gallery/page.tsx)
/gallery/tournaments       → Tournament photos (app/gallery/tournaments/page.tsx)
/gallery/champions         → Champion photos (app/gallery/champions/page.tsx)
/about                     → About page (app/about/page.tsx)
/contact                   → Contact page (app/contact/page.tsx)
/careers                   → Careers page (app/careers/page.tsx)
/privacy                   → Privacy policy (app/privacy/page.tsx)
/terms                     → Terms of service (app/terms/page.tsx)
```

### Dynamic Routes

**Tournament Detail:**
```typescript
// app/tournaments/[id]/page.tsx
export default function TournamentPage({
  params
}: {
  params: { id: string }
}) {
  // Access tournament ID via params.id
}
```

**News Article:**
```typescript
// app/news/[id]/page.tsx
export default function NewsArticlePage({
  params
}: {
  params: { id: string }
}) {
  // Access article ID via params.id
}
```

### Metadata Configuration

**Root Layout:**
```typescript
// app/layout.tsx
export const metadata: Metadata = {
  title: {
    default: "Poker Dream - Asia's Premier Poker Tournament Series",
    template: "%s | Poker Dream"
  },
  description: "Asia's Premier Poker Tournament Series",
  keywords: ["poker", "tournament", "malaysia poker", "asia poker"],
  openGraph: {
    type: "website",
    locale: "en_US",
    siteName: "Poker Dream"
  },
  robots: {
    index: true,
    follow: true
  }
}
```

**Page-specific Metadata:**
```typescript
// app/tournaments/page.tsx
export const metadata: Metadata = {
  title: "Tournaments",
  description: "Browse upcoming and live poker tournaments"
}
```

### Navigation Configuration

**File:** `/src/config/navigation.ts`

```typescript
export const mainNavigation: NavItem[] = [
  { label: "Home", href: "/" },
  { label: "Tournaments", href: "/tournaments" },
  { label: "DPOY", href: "/dpoy" },
  { label: "Live Reports", href: "/live-reports" },
  {
    label: "Gallery",
    href: "/gallery",
    children: [
      { label: "Tournament Photos", href: "/gallery/tournaments" },
      { label: "Champions", href: "/gallery/champions" }
    ]
  },
  { label: "News", href: "/news" }
]
```

### Link Component Usage

```typescript
import Link from 'next/link'

<Link href="/tournaments">View Tournaments</Link>
<Link href={`/tournaments/${tournament.id}`}>Details</Link>
```

### Active Route Detection

```typescript
import { usePathname } from 'next/navigation'

const pathname = usePathname()
const isActive = pathname === item.href
```

---

## Future Considerations

### Performance Optimizations

1. **Image Optimization**
   - Migrate to Next.js `<Image>` component
   - Implement responsive images with `srcset`
   - Lazy load images below the fold
   - Use modern formats (WebP, AVIF)

2. **Code Splitting**
   - Dynamic imports for heavy components
   - Route-based code splitting (automatic)
   - Lazy load third-party libraries

3. **Caching Strategy**
   - Implement Redis for API caching
   - Configure ISR (Incremental Static Regeneration)
   - Client-side caching with SWR or React Query

4. **Bundle Analysis**
   - Regular bundle size monitoring
   - Tree-shaking optimization
   - Remove unused dependencies

### Feature Enhancements

1. **Real-time Updates**
   - WebSocket integration for live standings
   - Server-Sent Events for live reports
   - Optimistic UI updates

2. **User Authentication**
   - Player registration and login
   - User profiles and history
   - Saved favorites and notifications

3. **Internationalization**
   - Multi-language support (already has next-intl)
   - Region-specific content
   - Currency localization

4. **Search Functionality**
   - Global search for tournaments, players, news
   - Advanced filters
   - Search suggestions

5. **Analytics**
   - Google Analytics integration
   - User behavior tracking
   - A/B testing framework

### Accessibility Improvements

1. **ARIA Labels**
   - Comprehensive aria-label usage
   - Landmark regions
   - Screen reader optimization

2. **Keyboard Navigation**
   - Full keyboard support
   - Focus management
   - Skip links

3. **Color Contrast**
   - WCAG AA compliance
   - High contrast mode
   - Colorblind-friendly palette

### SEO Enhancements

1. **Structured Data**
   - JSON-LD for events
   - Rich snippets for tournaments
   - Organization schema

2. **Sitemap Generation**
   - Dynamic sitemap
   - Regular updates
   - Submit to search engines

3. **Open Graph**
   - Dynamic OG images
   - Social media previews
   - Twitter cards

### Testing Strategy

1. **Unit Tests**
   - Jest + React Testing Library
   - Component testing
   - Utility function testing

2. **Integration Tests**
   - API integration tests
   - E2E user flows

3. **Visual Regression**
   - Screenshot testing
   - Cross-browser testing

4. **Performance Testing**
   - Lighthouse CI
   - Core Web Vitals monitoring

### Backend API Requirements

**Recommended Endpoints:**

```
GET    /api/tournaments                    # List tournaments
GET    /api/tournaments/:id                # Tournament details
GET    /api/tournaments/:id/standings      # Live standings
POST   /api/tournaments/:id/register       # Player registration

GET    /api/players/dpoy                   # DPOY rankings
GET    /api/players/:id                    # Player profile

GET    /api/news                           # News articles
GET    /api/news/:id                       # Article details

GET    /api/live-reports/:tournamentId    # Live updates
WS     /api/live-reports/:tournamentId    # WebSocket stream

GET    /api/gallery/tournaments            # Tournament photos
GET    /api/gallery/champions              # Champion photos

POST   /api/contact                        # Contact form
GET    /api/sponsors                       # Sponsor list
```

### Monitoring and Observability

1. **Error Tracking**
   - Sentry or similar service
   - Error boundaries
   - User feedback collection

2. **Performance Monitoring**
   - Core Web Vitals
   - API response times
   - Client-side metrics

3. **Logging**
   - Structured logging
   - Log aggregation
   - Alert configuration

### Security Considerations

1. **Input Validation**
   - Client-side validation with Zod
   - Server-side validation
   - Sanitize user inputs

2. **API Security**
   - HTTPS only
   - Rate limiting
   - CORS configuration
   - Authentication tokens

3. **Data Protection**
   - Privacy policy compliance
   - Cookie consent
   - Data encryption

---

## Changelog

### Version 1.0 (2026-01-04)

- Initial technical design document
- Documented technology stack
- Defined design system
- Outlined component architecture
- Specified styling approach
- Detailed animation strategy
- Documented responsive design
- Outlined data flow and API integration points
- Defined type system
- Documented routing strategy
- Listed future considerations

---

## Appendices

### Related Documentation

- README.md - Project setup and development guide
- package.json - Dependency specifications
- tsconfig.json - TypeScript configuration

### External Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Framer Motion Documentation](https://www.framer.com/motion/)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)

### Contact

For questions or clarifications about this technical design:
- **Email:** info@pokerdream.com
- **Project Repository:** [GitHub URL]

---

**Document End**

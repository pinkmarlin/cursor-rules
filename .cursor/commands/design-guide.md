---
description: Opinionated design system for building modern, professional UIs. Use when creating or reviewing UI components, layouts, styling, or any visual design work.
---

# Design Guide

Opinionated design principles for building modern, professional UIs that are clean, minimal, and polished.

## Core Principles

### 1. Clean and Minimal
- Generous white space—don't fear emptiness
- Each element has breathing room
- Remove anything that doesn't serve a purpose
- Less is more

### 2. Color Palette
**Base colors:**
- Grays: `#F9FAFB` (lightest), `#F3F4F6`, `#E5E7EB`, `#D1D5DB`, `#9CA3AF`, `#6B7280`, `#4B5563`, `#374151`, `#1F2937`, `#111827` (darkest)
- Off-whites for backgrounds: `#FAFAFA`, `#F8F9FA`
- True black/white sparingly: `#000000`, `#FFFFFF`

**Accent color:**
- Choose ONE accent color for the entire app
- Use sparingly for CTAs, links, important actions
- Good choices: `#10B981` (green), `#F59E0B` (amber), `#EF4444` (red), `#3B82F6` (blue)
- Avoid: generic purple/blue gradients

**Usage rules:**
- 90% neutral grays
- 8% accent color
- 2% semantic colors (success/error/warning)

### 3. Spacing System (8px Grid)
All spacing must use multiples of 8:
- `8px` - Tight spacing (icon + text)
- `16px` - Standard spacing (between elements)
- `24px` - Medium spacing (between sections)
- `32px` - Large spacing (between major sections)
- `48px` - Extra large (page sections)
- `64px` - Maximum (major page divisions)

**Apply to:**
- Padding
- Margins
- Gap between elements
- Component dimensions where possible

### 4. Typography
**Hierarchy:**
- Heading 1: 32-48px, bold
- Heading 2: 24-32px, semibold
- Heading 3: 20-24px, semibold
- Body: 16px (minimum), regular
- Small: 14px, regular
- Tiny: 12px (use sparingly, never below this)

**Rules:**
- Body text minimum 16px (never smaller for readability)
- Maximum 2 fonts per app
- Line height: 1.5 for body, 1.2 for headings
- Letter spacing: -0.01em for headings, normal for body

**Font pairing:**
- System fonts work great: `-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif`
- Or: Inter + Inter (single font, varies weights)
- Or: Heading font + system body font

### 5. Shadows
Subtle elevation, not heavy drop shadows.

**Levels:**
```css
/* Small - cards, buttons */
box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06);

/* Medium - dropdowns, modals */
box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07), 0 2px 4px rgba(0, 0, 0, 0.05);

/* Large - overlays */
box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1), 0 4px 6px rgba(0, 0, 0, 0.05);
```

**Rules:**
- Prefer subtle over dramatic
- Use sparingly to show hierarchy
- Don't shadow everything

### 6. Rounded Corners
**Border radius scale:**
- `4px` - Small (buttons, inputs, tags)
- `8px` - Medium (cards, larger buttons)
- `12px` - Large (modals, containers)
- `16px` - Extra large (hero sections)

**Rules:**
- Not everything needs to be rounded
- Consistency matters more than amount
- Rectangle buttons are fine

### 7. Interactive States
Every clickable element needs clear states:

**Buttons:**
- Default: base color
- Hover: slightly darker (10-15%)
- Active: even darker (20-25%)
- Disabled: 50% opacity, no hover
- Focus: outline ring in accent color

**Links:**
- Default: accent color or dark gray
- Hover: underline or slightly darker
- Visited: slightly muted (optional)

**Inputs:**
- Default: gray border
- Focus: accent color border + ring
- Error: red border
- Disabled: gray background

### 8. Mobile-First
- Design for 375px width first
- Scale up, don't scale down
- Touch targets minimum 44px × 44px
- Adequate spacing for fingers
- Test all interactions on actual mobile device

## Component Guidelines

### Buttons

**Primary button (CTA):**
```css
/* Good example */
background: [accent-color];
color: white;
padding: 12px 24px; /* 8px grid */
border-radius: 4px;
font-weight: 600;
box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);

/* Hover */
background: [accent-color-darker];
box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
```

**Secondary button:**
```css
background: transparent;
color: [gray-700];
border: 1px solid [gray-300];
padding: 12px 24px;
border-radius: 4px;
```

**Don't:**
- Gradient backgrounds
- Multiple shadows
- Tiny padding (< 8px)
- Garish colors

### Cards

**Good example:**
```css
background: white;
border: 1px solid [gray-200];
border-radius: 8px;
padding: 24px;
/* OR use shadow, not both */
box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
```

**Don't:**
- Heavy borders AND shadows
- Gradients
- Too much padding (> 32px on mobile)

### Forms

**Input fields:**
```css
/* Good */
border: 1px solid [gray-300];
border-radius: 4px;
padding: 12px 16px;
font-size: 16px; /* minimum */
background: white;

/* Focus */
border-color: [accent-color];
box-shadow: 0 0 0 3px rgba([accent], 0.1);

/* Error */
border-color: [red-500];
```

**Labels:**
```css
font-size: 14px;
font-weight: 500;
margin-bottom: 8px;
color: [gray-700];
```

**Spacing:**
- Between fields: 24px
- Label to input: 8px
- Error message: 8px below input

**Don't:**
- Floating labels (confusing)
- Placeholder-only inputs (accessibility issue)
- Tiny inputs (< 16px text)

### Navigation

**Header:**
```css
background: white;
border-bottom: 1px solid [gray-200];
padding: 16px 24px;
```

**Nav links:**
```css
color: [gray-600];
font-weight: 500;
padding: 8px 16px;

/* Hover */
color: [gray-900];

/* Active */
color: [accent-color];
```

**Don't:**
- Too many nav items (max 5-6)
- Tiny click targets
- Poor mobile menu

## Common Mistakes to Avoid

### ❌ Rainbow gradients everywhere
```css
/* BAD */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```
Use solid colors. Gradients are trendy today, dated tomorrow.

### ❌ Tiny unreadable text
```css
/* BAD */
font-size: 12px; /* Too small for body text */
```
Minimum 16px for body text. Always.

### ❌ Inconsistent spacing
```jsx
{/* BAD */}
<div className="mb-5">
  <div className="mt-3 mb-7">
```
Use the 8px system consistently.

### ❌ Every element is a different color
```css
/* BAD */
.button-1 { background: blue; }
.button-2 { background: purple; }
.button-3 { background: green; }
```
One accent color for the whole app.

### ❌ Heavy shadows
```css
/* BAD */
box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
```
Subtle shadows only. Less is more.

### ❌ Over-rounded corners
```css
/* BAD - looks like pills */
border-radius: 50px;
```
4-12px is usually enough.

### ❌ Poor hover states
```css
/* BAD - no visual feedback */
button {
  background: blue;
}
/* Missing hover state */
```
Every interactive element needs clear hover/focus/active states.

## Tailwind CSS Quick Reference

Common classes aligned with this guide:

**Spacing:**
- `p-2` (8px), `p-4` (16px), `p-6` (24px), `p-8` (32px)
- `space-y-2`, `space-y-4`, `space-y-6`, `space-y-8`
- `gap-2`, `gap-4`, `gap-6`, `gap-8`

**Colors:**
- Text: `text-gray-600`, `text-gray-900`
- Background: `bg-white`, `bg-gray-50`, `bg-gray-100`
- Borders: `border-gray-200`, `border-gray-300`
- Accent: `text-blue-600`, `bg-blue-600` (or your chosen accent)

**Typography:**
- `text-sm` (14px), `text-base` (16px), `text-lg` (18px)
- `font-normal`, `font-medium`, `font-semibold`, `font-bold`

**Shadows:**
- `shadow-sm`, `shadow`, `shadow-md`

**Borders:**
- `rounded` (4px), `rounded-lg` (8px), `rounded-xl` (12px)

## Review Checklist

When reviewing or building any UI component, verify:

- [ ] Uses 8px spacing grid consistently
- [ ] Body text is ≥16px
- [ ] Uses grays as base, one accent color sparingly
- [ ] No gradients (unless truly necessary)
- [ ] Shadows are subtle
- [ ] Interactive states are clear (hover, focus, disabled)
- [ ] Works on mobile (375px width)
- [ ] Adequate white space
- [ ] Maximum 2 fonts
- [ ] Consistent border radius values

## Quick Decision Framework

**When choosing:**

**Color:**
- Default → gray
- Important action → accent color
- Destructive → red
- Success → green

**Spacing:**
- Tight → 8px
- Standard → 16px
- Between sections → 24-32px

**Shadow:**
- None → flat elements (tables, lists)
- Subtle → cards, buttons
- Medium → dropdowns, popovers

**Border radius:**
- Small elements → 4px
- Standard → 8px
- Large containers → 12px

When in doubt: go simpler, use more white space, stick to grays.

<!--
  Sync Impact Report
  ═══════════════════
  Version change: 1.0.0 → 1.1.0 (full English rewrite)
  Modified principles:
    - All 8 principles (I–VIII) translated from pt-BR to English
    - No semantic changes to any principle
  Added sections: N/A
  Removed sections: N/A
  Templates requiring updates:
    - .specify/templates/plan-template.md — ✅ no changes needed (already in English)
    - .specify/templates/spec-template.md — ✅ no changes needed (already in English)
    - .specify/templates/tasks-template.md — ✅ no changes needed (already in English)
  Follow-up TODOs: none
-->

# ZionKit Site Constitution

## Core Principles

### I. Token-Driven Theming

Every visual property — color, typography, spacing, shadow, border-radius,
transition duration, and z-index — MUST be expressed as a CSS custom property
defined in `src/styles/tokens.css`. Hardcoded values in component styles
are prohibited except inside `tokens.css` itself.

**Rationale**: A centralized token system ensures visual consistency across
all components, enables future theming (e.g., light mode) by changing a
single file, and prevents visual drift as the site grows.

**Rules**:
- New colors MUST follow the existing semantic naming convention
  (`--color-{category}-{variant}`)
- Aurora gradients MUST exclusively use the `--color-aurora-*` variables
- New breakpoints or typographic scales MUST be added to tokens.css
  before being referenced in components

### II. Component Architecture

Components MUST follow the established directory hierarchy with clear,
non-overlapping responsibilities:

| Directory | Responsibility | Technology |
|-----------|---------------|------------|
| `sections/` | Full page sections with narrative content | Astro |
| `ui/` | Reusable interface elements (cards, headers, badges) | Astro |
| `layout/` | Page structure (nav, footer, progress, filters) | Astro |
| `diagrams/` | Interactive data/concept visualizations | React (.tsx) |
| `animations/` | Visual effects and animation control | Astro |

**Rules**:
- Astro components (.astro) MUST be used for static content and layout;
  React (.tsx) MUST be restricted to interactivity that requires
  client-side state
- Each component MUST be self-contained: typed props via interface,
  scoped styles, no global state dependency
- `sections/` components MUST compose components from `ui/`, `diagrams/`,
  and `animations/` — never the reverse
- New components MUST be placed in the correct directory per the table
  above; creating new directories requires documented justification

### III. Astro-First, React Islands

The site MUST follow the Astro Islands architecture: components are rendered
as static HTML by default. Client-side JavaScript MUST be added only when
real interactivity is required.

**Rules**:
- React (.tsx) MUST be used only for components that require: reactive
  state, complex event handlers, or JS libraries such as @xyflow/react
- React diagrams MUST use the `client:visible` directive for lazy
  hydration (load JS only when the component enters the viewport)
- If a component can be implemented with CSS and semantic HTML alone,
  it MUST be an Astro component, not React
- Adding new runtime JavaScript dependencies requires explicit
  justification that the functionality cannot be achieved with CSS/HTML

### IV. Borealis Visual Identity

The Borealis theme (dark-first with aurora gradients) MUST be preserved as
the site's visual identity. All visual additions MUST be coherent with this
design language.

**Rules**:
- Primary background MUST remain dark (`--color-bg-primary: #0a0e17`)
- Visual accents MUST use the aurora palette (green, cyan, blue, violet, pink)
- Gradient text MUST use the existing `.gradient-text` utility class
- Glow effects MUST use the existing `--shadow-glow-*` variables
- New decorative colors MUST be added to the aurora section of tokens.css
  and follow the same luminosity and saturation range
- Sections MUST alternate between `section-odd` and `section-even` for
  visual rhythm

### V. Accessibility First

Accessibility is not optional. Every component MUST meet WCAG 2.1 AA as a
minimum requirement before being considered complete.

**Rules**:
- Every animation MUST respect `prefers-reduced-motion: reduce` —
  disabling or simplifying the effect
- Navigation MUST have `aria-label`; interactive elements MUST have
  `aria-expanded`/`aria-controls` where applicable
- The skip link (`<a href="#main-content">`) MUST remain the first
  focusable element on the page
- Text contrast MUST meet a minimum ratio of 4.5:1 for normal text
  and 3:1 for large text
- Sections MUST use `aria-labelledby` pointing to the section heading
- Decorative images and icons MUST have `aria-hidden="true"`
- Forms and interactive elements MUST have descriptive labels

### VI. Progressive Depth System

The 3-layer depth system MUST be maintained and consistently applied
to all new content:

| Layer | Label | Audience |
|-------|-------|----------|
| 1 | Essential | Everyone — overview and key concepts |
| 2 | Detailed | Those interested in understanding the "how" |
| 3 | Technical | Implementers and architects |

**Rules**:
- Every new section MUST declare its depth layer via the `depth` prop
  on the `SectionHeader` component
- The `DepthFilter` component MUST control layer visibility —
  individual components MUST NOT implement their own filtering logic
- Layer 1 content MUST be understandable without context from layers
  2 and 3
- New sections MUST function independently, without dependency on
  content from other sections at the same layer

### VII. Section Composition Pattern

Page sections MUST follow the established compositional pattern to
ensure narrative and visual consistency across the site.

**Rules**:
- Every section MUST have a unique `id` for deep-linking and navigation
- Every section MUST start with `SectionHeader` containing: `sectionNumber`,
  `title`, and `depth`
- Narrative content MUST be wrapped by `ScrollReveal` with incremental
  delays (0, 0.15, 0.3, 0.45...)
- Diagrams MUST be wrapped by `DiagramContainer` with a descriptive
  `label` and `title`
- When adding a new section, it MUST be registered in:
  1. `src/pages/index.astro` (in the correct narrative order)
  2. `StickyNav.astro` (`sections` array with `id` and `label`)
- The `sectionNumber` MUST follow the existing sequence (incrementing
  from the last section)

### VIII. Performance & Progressive Enhancement

The site MUST load fast and work without JavaScript for static content.
JavaScript MUST enhance the experience, not be a requirement for consuming
the content.

**Rules**:
- Sections below the fold MUST use `content-visibility: auto` for lazy
  rendering (already applied via global CSS)
- Fonts MUST be loaded via `@fontsource` (self-hosted), never via an
  external Google Fonts CDN
- New npm dependencies MUST have their bundle impact justified; prefer
  CSS-only solutions when possible
- React diagrams MUST use `client:visible` (not `client:load`) to avoid
  blocking initial page load
- Images MUST use optimized formats (WebP/AVIF) with explicit dimensions
  to prevent layout shift

## Architectural Constraints

### Technology Stack

| Layer | Technology | Minimum Version |
|-------|-----------|-----------------|
| Framework | Astro | 6.x |
| Islands | React | 19.x |
| Styling | Tailwind CSS + CSS custom properties | 4.x |
| Diagrams | @xyflow/react | 12.x |
| Animations | GSAP + CSS animations | 3.x |
| Fonts | @fontsource/inter, @fontsource/jetbrains-mono | latest |
| Build | Vite (via Astro) | — |
| Deploy | GitHub Pages (base: /zion-kit) | — |

**Rules**:
- Adding new frameworks or runtimes (e.g., Vue, Svelte, another bundler)
  requires a constitutional amendment
- Major version upgrades of any core dependency (Astro, React, Tailwind)
  require a documented migration plan
- Content language is pt-BR; `lang="pt-BR"` MUST be maintained on the
  `<html>` element

### File Organization

```
src/
├── components/
│   ├── animations/   # Visual effects (Astro)
│   ├── diagrams/     # Interactive visualizations (React .tsx)
│   ├── layout/       # Page structure (Astro)
│   ├── sections/     # Narrative sections (Astro)
│   └── ui/           # Reusable elements (Astro)
├── layouts/          # Base layout (BaseLayout.astro)
├── lib/
│   └── diagrams/     # Data configurations for diagrams
├── pages/            # Routes (index.astro)
└── styles/
    ├── base.css      # Reset + global utilities
    ├── tokens.css    # Design tokens (visual source of truth)
    └── animations.css # Global keyframes
```

## Development Workflow

### Adding a New Section

1. Create component at `src/components/sections/NewSectionSection.astro`
2. Define props, include `SectionHeader` with `depth` and `sectionNumber`
3. Register in `src/pages/index.astro` at the correct narrative position
4. Add to the `sections` array in `StickyNav.astro`
5. If the section contains an interactive diagram:
   a. Create React component at `src/components/diagrams/NewDiagram.tsx`
   b. Create data configuration at `src/lib/diagrams/new-diagram.ts`
   c. Wrap with `DiagramContainer` and use `client:visible`
6. Verify accessibility (aria, reduced-motion, contrast)

### Adding New Tokens

1. Add the CSS variable to `src/styles/tokens.css` in the correct
   semantic section
2. Follow the existing naming convention (`--{category}-{group}-{variant}`)
3. Use the new variable via `var(--token-name)` in components

### Adding a New UI Component

1. Create at `src/components/ui/NewComponent.astro`
2. Define a typed Props interface
3. Use design tokens exclusively for visual values
4. Keep styles scoped (inside `<style>`)
5. Test across all depth layers if applicable

## Governance

### Amendments

- Any change to this constitution MUST be documented with justification
  and update the Sync Impact Report at the top of the file
- Adding new principles = MINOR version bump
- Removing or redefining principles = MAJOR version bump
- Wording adjustments with no semantic change = PATCH version bump

### Compliance

- Every new component and feature MUST be verified against the principles
  of this constitution before being considered complete
- The Constitution Check in the plan template (`plan-template.md`) MUST
  validate adherence to Principles I–VIII
- Violations MUST be justified and documented in the Complexity Tracking
  section of the implementation plan

### Runtime Guidance

For real-time development guidance, refer to the `CLAUDE.md` file at the
project root (when present).

**Version**: 1.1.0 | **Ratified**: 2026-04-07 | **Last Amended**: 2026-04-07

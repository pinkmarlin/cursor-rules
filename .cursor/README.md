# Cursor Configuration

This directory contains AI assistant rules for Cursor that automatically apply to all projects.

## Structure

### Always-Applied Rules (`.cursor/rules/`)

These rules automatically apply to every Cursor session:

**Core Standards:**
- `engineering-philosophy.mdc` - Core principles and golden rules
- `file-structure.mdc` - File size limits, components, imports, theming
- `styling-ux.mdc` - UX guidelines, modals, navigation, design system
- `typescript-linting.mdc` - TypeScript strictness and linting
- `naming-conventions.mdc` - File, component, function, variable naming patterns

**Framework & Stack:**
- `nextjs-conventions.mdc` - Next.js App Router conventions
- `tech-stack.mdc` - Required stack (Next.js, Tailwind, Convex, etc.)
- `state-management.mdc` - When to use useState, Context, URL state, Zustand

**Code Quality:**
- `error-handling.mdc` - Error boundaries, try-catch, user feedback, logging
- `accessibility.mdc` - WCAG compliance, semantic HTML, ARIA, keyboard nav
- `performance.mdc` - Core Web Vitals, bundle size, lazy loading

**Quality & Operations:**
- `testing-quality.mdc` - Test coverage, snapshots, E2E, build verification
- `security-compliance.mdc` - Secrets, data privacy, auth validation
- `documentation.mdc` - JSDoc, changelogs, READMEs
- `api-backend.mdc` - API contracts, error handling, caching
- `developer-experience.mdc` - Code formatting, commits, branching
- `observability.mdc` - Logging, monitoring, alerts
- `project-lifecycle.mdc` - PRDs, deprecation, migrations

### Specialized Skills (Manual Invocation)

These rules are invoked via @-mention when needed:

- `design-guide.mdc` - @design-guide - UI/UX design system
- `idea-validator.mdc` - @idea-validator - Product validation
- `launch-planner.mdc` - @launch-planner - MVP planning
- `marketing-writer.mdc` - @marketing-writer - Marketing content
- `roadmap-builder.mdc` - @roadmap-builder - Feature prioritization

### Commands

Custom commands available in `.cursor/commands/`:
- Commands are shortcuts or workflows you can invoke in Cursor
- Add `.md` or `.mdc` files to this directory for custom commands

## Usage

### Automatic Application

All core rules (with `alwaysApply: true`) are automatically loaded by Cursor in every session. No action needed.

### Specialized Skills

Invoke specialized skills by @-mentioning them in Cursor Chat:
- `@design-guide` - When working on UI/UX
- `@idea-validator` - When evaluating product ideas
- `@launch-planner` - When planning MVPs
- `@marketing-writer` - When writing marketing content
- `@roadmap-builder` - When prioritizing features

## Syncing to Projects

There are three scripts depending on your use case:

### Option 1: Link to Global Config (Recommended for most users)
```bash
cd ~/Documents/code/dotfiles
./scripts/link-cursor-rules-selective.sh
```
**What it does:**
- Symlinks rules and commands to `~/.cursor/`
- Makes them available globally to all projects
- Updates automatically when you modify dotfiles
- Preserves Cursor app config files

**Use when:** You want global standards that stay in sync across all projects.

---

### Option 2: Copy to Project (For project-specific customization)
```bash
cd ~/Documents/code/my-project
~/Documents/code/dotfiles/scripts/copy-cursor-rules.sh
```
**What it does:**
- **Copies** (not symlinks) rules to `./cursor/rules/`
- Creates independent files you can modify
- Won't overwrite existing files
- Changes don't affect dotfiles or other projects

**Use when:** You need project-specific rule modifications.

---

### Option 3: Link Entire `.cursor` Directory (For new projects)
```bash
cd ~/Documents/code/dotfiles
./scripts/link-cursor-rules.sh ~/path/to/project
```
**What it does:**
- Symlinks entire `.cursor` directory to project
- Project always uses exact dotfiles config
- Simplest setup for new projects

**Use when:** Starting a new project that should always match dotfiles.

## Rule Metadata

Each `.mdc` file contains YAML frontmatter:

```yaml
---
description: Brief description of the rule
globs:  # Optional file patterns
  - "**/*.tsx"
  - "**/app/**"
alwaysApply: true  # or false for manual invocation
---
```

- `alwaysApply: true` - Automatically loaded in every session
- `alwaysApply: false` - Requires @-mention to activate
- `globs` - Optional file patterns to scope the rule

# 🎯 Cursor Configuration Toolkit

A curated collection of **Cursor AI rules** and **sync scripts** for maintaining consistent, world-class development standards across all your projects.

---

## 📂 What's Inside

### `.cursor/rules/` - Engineering Standards

23 condensed, high-quality rule files covering:

- **Core Development**: Engineering philosophy, file structure, naming conventions
- **Frontend**: Next.js conventions, styling/UX, accessibility, performance
- **Quality**: TypeScript/linting, testing, error handling, security
- **Architecture**: State management, API/backend, observability
- **Product**: Documentation, project lifecycle, developer experience
- **Specialized**: Design guide, idea validator, launch planner, marketing writer, roadmap builder

All rules are **optimized for readability** with ~70% reduction in verbosity while preserving 100% of the essential guidance.

### `scripts/` - Sync Utilities

Four powerful scripts to keep your Cursor configuration in sync:

---

## 🛠️ Scripts Overview

### 1️⃣ `link-cursor-rules.sh`

**Purpose**: Create symlinks to global Cursor config (stays in sync with dotfiles)

**Use when**: You want updates to this repo to automatically propagate everywhere

**How it works**:
- Creates symlinks from target directory to this repo
- Any changes here instantly affect all linked projects
- Perfect for maintaining consistent global standards

**Usage**:
```bash
# Link to global ~/.cursor (default)
./scripts/link-cursor-rules.sh

# Link to specific project
./scripts/link-cursor-rules.sh ~/Documents/code/my-project

# Link to project's .cursor directory explicitly
./scripts/link-cursor-rules.sh ~/Documents/code/my-project/.cursor
```

**What it does**:
- ✅ Creates symlinks for all `.mdc` and `.md` files in `rules/` and `commands/`
- ✅ Prompts before overwriting existing files
- ✅ Shows detailed summary of linked/skipped files
- ✅ Updates stay in sync automatically

---

### 2️⃣ `copy-cursor-rules.sh`

**Purpose**: Copy files (not symlinks) for project-specific customization

**Use when**: You want to modify rules for a specific project without affecting others

**How it works**:
- Copies actual files to target directory
- Changes won't sync back to this repo
- Perfect for project-specific tweaks

**Usage**:
```bash
# Copy to current directory
./scripts/copy-cursor-rules.sh

# Copy to specific project
./scripts/copy-cursor-rules.sh ~/Documents/code/my-project
```

**What it does**:
- ✅ Copies all `.mdc` and `.md` files from `rules/` and `commands/`
- ✅ Never overwrites existing files (skips them)
- ✅ Shows detailed summary of copied/skipped files
- ✅ Safe to run multiple times

**Note**: Files are independent copies. Updates to this repo won't automatically apply.

---

### 3️⃣ `link-cursor-rules-selective.sh`

**Purpose**: Link entire `.cursor` directory at once (fastest setup)

**Use when**: Starting a new project that should always use global config

**How it works**:
- Creates single symlink to entire `.cursor` directory
- Most aggressive sync option
- Simplest setup

**Usage**:
```bash
./scripts/link-cursor-rules-selective.sh ~/Documents/code/my-new-project
```

**What it does**:
- ✅ Links entire `.cursor` directory as one symlink
- ✅ Prompts before overwriting
- ✅ Shows detailed list of included rules
- ✅ Instant global sync for everything

---

### 4️⃣ `link-ai-assistants.sh`

**Purpose**: Link AI assistant configurations (`.codex`, `.claude`)

**Use when**: You have AI assistant configs you want to link to `$HOME`

**How it works**:
- Links `.codex` and `.claude` directories/files to home directory
- Handles backups of existing files
- Uses Python for cross-platform path resolution

**Usage**:
```bash
./scripts/link-ai-assistants.sh
```

**What it links**:
- `.codex/AGENTS.md`
- `.codex/commands.json`
- `.codex/instructions.md`
- `.codex/commands/`
- `.codex/subagents/`
- `.claude/CLAUDE.md`
- `.claude/commands/`
- `.claude/subagents/`

---

## 🤔 Which Script Should I Use?

```
┌─────────────────────────────────────────────────────────────┐
│                    Decision Tree                             │
└─────────────────────────────────────────────────────────────┘

Want changes to sync automatically?
├─ YES → Use link-cursor-rules.sh (symlinks individual files)
│        OR link-cursor-rules-selective.sh (symlink whole dir)
│
└─ NO  → Use copy-cursor-rules.sh (independent copies)


Setting up a new project?
├─ Use link-cursor-rules-selective.sh (fastest)
│
Setting up global config?
├─ Use link-cursor-rules.sh with no args
│
Need project-specific rules?
└─ Use copy-cursor-rules.sh, then customize
```

---

## 📋 Quick Start

### For New Projects
```bash
# Link entire .cursor directory (recommended)
./scripts/link-cursor-rules-selective.sh ~/Documents/code/my-new-project
```

### For Global Config
```bash
# Link to ~/.cursor
./scripts/link-cursor-rules.sh

# Link AI assistants to ~/ 
./scripts/link-ai-assistants.sh
```

### For Custom Projects
```bash
# Copy rules, then modify as needed
./scripts/copy-cursor-rules.sh ~/Documents/code/special-project
```

---

## 📊 File Statistics

| Category | Count | Lines |
|----------|-------|-------|
| **Core Rules** | 12 files | ~400 lines |
| **Specialized Rules** | 5 files | ~400 lines |
| **Foundation Rules** | 6 files | ~200 lines |
| **Total** | **23 rules** | **~1000 lines** |

**Optimization**: All rules condensed to ~70% less verbosity while maintaining 100% of essential guidance.

---

## 🎨 Rule Categories

### Always Applied (Core Standards)
- Accessibility
- API & Backend
- Developer Experience
- Documentation
- Engineering Philosophy
- Error Handling
- File Structure
- Naming Conventions
- Next.js Conventions
- Observability
- Performance
- Project Lifecycle
- Security & Compliance
- State Management
- Styling & UX
- Tech Stack
- Testing & Quality
- TypeScript & Linting

### On-Demand (Specialized Modes)
- Design Guide (via `@design-guide`)
- Idea Validator (via `@idea-validator`)
- Launch Planner (via `@launch-planner`)
- Marketing Writer (via `@marketing-writer`)
- Roadmap Builder (via `@roadmap-builder`)

---

## 🔄 Updating Rules

### If Using Symlinks
Just edit files in this repo—changes propagate automatically to all linked projects.

### If Using Copies
Re-run the copy script to update (won't overwrite existing files, so you may need to manually merge).

---

## 🏗️ Project Philosophy

**World-class engineering and UX design standards**
- Professional, elegant, consistent
- Readability and maintainability over speed
- Craftsmanship: simple, tested, extensible
- Every addition should feel like it always belonged

---

## 📝 License

Feel free to use, modify, and distribute these rules and scripts for your own projects.

---

## 🤝 Contributing

These rules represent opinionated best practices. Feel free to:
- Fork and customize for your needs
- Submit suggestions for improvements
- Share your own condensed rule formats

---

**Happy Coding!** 🚀


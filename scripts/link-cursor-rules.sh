#!/bin/bash
# Link entire .cursor directory to a project (for new projects)
# This creates a symlink to the entire dotfiles .cursor directory
# Use this for projects that should always use global config

if [ -z "$1" ]; then
  echo "Usage: $0 <project-directory>"
  echo "Example: $0 ~/Documents/code/my-project"
  exit 1
fi

PROJECT_DIR="$1"
DOTFILES_DIR="$HOME/Documents/code/dotfiles"

# Check if project directory exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Error: Project directory does not exist: $PROJECT_DIR"
  exit 1
fi

# Create symlink for .cursor directory
if [ -d "$PROJECT_DIR/.cursor" ]; then
  echo "Warning: .cursor directory already exists in $PROJECT_DIR"
  read -p "Overwrite? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$PROJECT_DIR/.cursor"
    ln -s "$DOTFILES_DIR/.cursor" "$PROJECT_DIR/.cursor"
    echo "✓ Linked .cursor directory"
  else
    echo "Skipped .cursor directory"
  fi
else
  ln -s "$DOTFILES_DIR/.cursor" "$PROJECT_DIR/.cursor"
  echo "✓ Linked .cursor directory"
fi

echo ""
echo "✓ Global Cursor rules linked to $PROJECT_DIR"
echo ""
echo "Always-applied rules (automatic):"
echo "  • Engineering philosophy & golden rules"
echo "  • File structure & components"
echo "  • Styling & UX guidelines"
echo "  • Naming conventions"
echo "  • Next.js App Router conventions"
echo "  • Tech stack standards"
echo "  • State management patterns"
echo "  • Error handling & recovery"
echo "  • Accessibility (a11y)"
echo "  • Performance optimization"
echo "  • TypeScript & linting"
echo "  • Testing & quality"
echo "  • Security & compliance"
echo "  • Documentation"
echo "  • API & backend"
echo "  • Developer experience"
echo "  • Observability"
echo "  • Project lifecycle"
echo ""
echo "Specialized skills (via @-mention):"
echo "  • @design-guide"
echo "  • @idea-validator"
echo "  • @launch-planner"
echo "  • @marketing-writer"
echo "  • @roadmap-builder"


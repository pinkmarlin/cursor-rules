#!/bin/bash
# Copy Cursor rules and commands to project's .cursor directory
# This copies files (not symlinks) for project-specific customization
# Use this when you want to modify rules per-project without affecting dotfiles

DOTFILES_DIR="$HOME/Documents/code/dotfiles"
SOURCE_CURSOR_DIR="$DOTFILES_DIR/.cursor"

# Default to current directory if no argument provided
if [ -z "$1" ]; then
  TARGET_BASE_DIR="$(pwd)/.cursor"
  echo "No target specified, using current directory: $(pwd)/.cursor"
else
  TARGET_BASE_DIR="$1"
  
  # If target is a project directory (not already .cursor), append .cursor
  if [[ ! "$TARGET_BASE_DIR" =~ \.cursor$ ]]; then
    TARGET_BASE_DIR="$TARGET_BASE_DIR/.cursor"
  fi
fi

# Check if source .cursor directory exists
if [ ! -d "$SOURCE_CURSOR_DIR" ]; then
  echo "Error: Source .cursor directory not found: $SOURCE_CURSOR_DIR"
  exit 1
fi

# Create target .cursor directory if it doesn't exist
if [ ! -d "$TARGET_BASE_DIR" ]; then
  mkdir -p "$TARGET_BASE_DIR"
  echo "✓ Created $TARGET_BASE_DIR"
fi

# Function to copy files from a source subdirectory to target subdirectory
copy_subdirectory() {
  local subdir_name=$1
  local source_subdir="$SOURCE_CURSOR_DIR/$subdir_name"
  local target_subdir="$TARGET_BASE_DIR/$subdir_name"
  
  # Skip if source doesn't exist
  if [ ! -d "$source_subdir" ]; then
    echo "0 0 0 0"
    return 0
  fi
  
  # Create target subdirectory if it doesn't exist
  if [ ! -d "$target_subdir" ]; then
    mkdir -p "$target_subdir" >&2
    echo "✓ Created $target_subdir" >&2
  fi
  
  local copied=0
  local skipped=0
  local updated=0
  local total=0
  
  echo "" >&2
  echo "Copying $subdir_name from dotfiles to $target_subdir" >&2
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
  
  # Copy each .mdc or .md file individually
  shopt -s nullglob
  for source_file in "$source_subdir"/*.mdc "$source_subdir"/*.md; do
    # Skip if file doesn't exist
    [ -e "$source_file" ] || continue
    
    total=$((total + 1))
    
    # Get just the filename
    filename=$(basename "$source_file")
    target_file="$target_subdir/$filename"
    
    # Check if target already exists
    if [ -e "$target_file" ]; then
      echo "  ⏭  $filename (already exists, skipping)" >&2
      skipped=$((skipped + 1))
    else
      # Copy file
      cp "$source_file" "$target_file"
      echo "  ✓ $filename (copied)" >&2
      copied=$((copied + 1))
    fi
  done
  
  if [ $total -eq 0 ]; then
    echo "  (no files found)" >&2
  fi
  
  # Return counts for summary (only to stdout, not stderr)
  echo "$copied $updated $skipped $total"
}

# Track overall stats
TOTAL_COPIED=0
TOTAL_UPDATED=0
TOTAL_SKIPPED=0
TOTAL_FILES=0

RULES_COPIED=0
RULES_UPDATED=0
RULES_SKIPPED=0
RULES_TOTAL=0

COMMANDS_COPIED=0
COMMANDS_UPDATED=0
COMMANDS_SKIPPED=0
COMMANDS_TOTAL=0

# Copy rules
if [ -d "$SOURCE_CURSOR_DIR/rules" ]; then
  stats=$(copy_subdirectory "rules")
  read RULES_COPIED RULES_UPDATED RULES_SKIPPED RULES_TOTAL <<< "$stats"
  TOTAL_COPIED=$((TOTAL_COPIED + RULES_COPIED))
  TOTAL_UPDATED=$((TOTAL_UPDATED + RULES_UPDATED))
  TOTAL_SKIPPED=$((TOTAL_SKIPPED + RULES_SKIPPED))
  TOTAL_FILES=$((TOTAL_FILES + RULES_TOTAL))
fi

# Copy commands
if [ -d "$SOURCE_CURSOR_DIR/commands" ]; then
  stats=$(copy_subdirectory "commands")
  read COMMANDS_COPIED COMMANDS_UPDATED COMMANDS_SKIPPED COMMANDS_TOTAL <<< "$stats"
  TOTAL_COPIED=$((TOTAL_COPIED + COMMANDS_COPIED))
  TOTAL_UPDATED=$((TOTAL_UPDATED + COMMANDS_UPDATED))
  TOTAL_SKIPPED=$((TOTAL_SKIPPED + COMMANDS_SKIPPED))
  TOTAL_FILES=$((TOTAL_FILES + COMMANDS_TOTAL))
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Summary:"
echo "  Rules:"
echo "    • Copied: $RULES_COPIED | Skipped (existing): $RULES_SKIPPED | Total: $RULES_TOTAL"
echo ""
echo "  Commands:"
echo "    • Copied: $COMMANDS_COPIED | Skipped (existing): $COMMANDS_SKIPPED | Total: $COMMANDS_TOTAL"
echo ""
echo "  Overall:"
echo "    • Total copied: $TOTAL_COPIED"
echo "    • Total skipped: $TOTAL_SKIPPED"
echo "    • Total files: $TOTAL_FILES"
echo ""

echo "Files have been copied to: $TARGET_BASE_DIR"
echo ""
echo "⚠️  Note: These are COPIES, not symlinks."
echo "   • You can modify these files without affecting dotfiles"
echo "   • Updates to dotfiles won't automatically apply here"
echo "   • Good for project-specific customization"
echo ""
echo "To update from dotfiles later, run this script again."
echo "Existing files are preserved (never overwritten)."








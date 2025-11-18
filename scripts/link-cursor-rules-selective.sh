#!/bin/bash
# Link global Cursor rules and commands to ~/.cursor (or specified directory)
# This creates symlinks so updates to dotfiles automatically propagate everywhere
# Use this for global config that should stay in sync with dotfiles

DOTFILES_DIR="$HOME/Documents/code/dotfiles"
SOURCE_CURSOR_DIR="$DOTFILES_DIR/.cursor"

# Default to global ~/.cursor if no argument provided
if [ -z "$1" ]; then
  TARGET_BASE_DIR="$HOME/.cursor"
  echo "No target specified, using global Cursor config: ~/.cursor"
else
  TARGET_BASE_DIR="$1"
  
  # If target is a project directory (not already .cursor), append .cursor
  if [[ ! "$TARGET_BASE_DIR" =~ \.cursor$ ]]; then
    TARGET_BASE_DIR="$TARGET_BASE_DIR/.cursor"
  fi
fi

# Check if target directory exists, create if needed
if [ ! -d "$TARGET_BASE_DIR" ]; then
  mkdir -p "$TARGET_BASE_DIR"
  echo "✓ Created $TARGET_BASE_DIR"
fi

# Check if source .cursor directory exists
if [ ! -d "$SOURCE_CURSOR_DIR" ]; then
  echo "Error: Source .cursor directory not found: $SOURCE_CURSOR_DIR"
  exit 1
fi

# Function to link files from a source subdirectory to target subdirectory
link_subdirectory() {
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
  
  local linked=0
  local skipped=0
  local updated=0
  local total=0
  
  echo "" >&2
  echo "Linking $subdir_name from dotfiles to $target_subdir" >&2
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
  
  # Link each .mdc or .md file individually
  shopt -s nullglob
  for source_file in "$source_subdir"/*.mdc "$source_subdir"/*.md; do
    # Skip if file doesn't exist (nullglob handles this but just in case)
    [ -e "$source_file" ] || continue
    
    total=$((total + 1))
    
    # Get just the filename
    filename=$(basename "$source_file")
    target_file="$target_subdir/$filename"
    
    # Check if target already exists
    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
      # Check if it's already a symlink to our source
      if [ -L "$target_file" ]; then
        existing_link=$(readlink "$target_file")
        if [ "$existing_link" = "$source_file" ]; then
          echo "  ⏭  $filename (already linked)" >&2
          skipped=$((skipped + 1))
          continue
        fi
      fi
      
      # Ask to overwrite
      echo "" >&2
      echo "  ⚠️  $filename already exists" >&2
      read -p "     Overwrite? (y/n) " -n 1 -r
      echo >&2
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -f "$target_file"
        ln -s "$source_file" "$target_file"
        echo "  ✓ $filename (updated)" >&2
        updated=$((updated + 1))
      else
        echo "  ⏭  $filename (skipped)" >&2
        skipped=$((skipped + 1))
      fi
    else
      # Create new symlink
      ln -s "$source_file" "$target_file"
      echo "  ✓ $filename" >&2
      linked=$((linked + 1))
    fi
  done
  
  if [ $total -eq 0 ]; then
    echo "  (no files found)" >&2
  fi
  
  # Return counts for summary (only to stdout, not stderr)
  echo "$linked $updated $skipped $total"
}

# Track overall stats
TOTAL_LINKED=0
TOTAL_UPDATED=0
TOTAL_SKIPPED=0
TOTAL_FILES=0

RULES_LINKED=0
RULES_UPDATED=0
RULES_SKIPPED=0
RULES_TOTAL=0

COMMANDS_LINKED=0
COMMANDS_UPDATED=0
COMMANDS_SKIPPED=0
COMMANDS_TOTAL=0

# Link rules
if [ -d "$SOURCE_CURSOR_DIR/rules" ]; then
  stats=$(link_subdirectory "rules")
  read RULES_LINKED RULES_UPDATED RULES_SKIPPED RULES_TOTAL <<< "$stats"
  TOTAL_LINKED=$((TOTAL_LINKED + RULES_LINKED))
  TOTAL_UPDATED=$((TOTAL_UPDATED + RULES_UPDATED))
  TOTAL_SKIPPED=$((TOTAL_SKIPPED + RULES_SKIPPED))
  TOTAL_FILES=$((TOTAL_FILES + RULES_TOTAL))
fi

# Link commands
if [ -d "$SOURCE_CURSOR_DIR/commands" ]; then
  stats=$(link_subdirectory "commands")
  read COMMANDS_LINKED COMMANDS_UPDATED COMMANDS_SKIPPED COMMANDS_TOTAL <<< "$stats"
  TOTAL_LINKED=$((TOTAL_LINKED + COMMANDS_LINKED))
  TOTAL_UPDATED=$((TOTAL_UPDATED + COMMANDS_UPDATED))
  TOTAL_SKIPPED=$((TOTAL_SKIPPED + COMMANDS_SKIPPED))
  TOTAL_FILES=$((TOTAL_FILES + COMMANDS_TOTAL))
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Summary:"
echo "  Rules:"
echo "    • New: $RULES_LINKED | Updated: $RULES_UPDATED | Skipped: $RULES_SKIPPED | Total: $RULES_TOTAL"
echo ""
echo "  Commands:"
echo "    • New: $COMMANDS_LINKED | Updated: $COMMANDS_UPDATED | Skipped: $COMMANDS_SKIPPED | Total: $COMMANDS_TOTAL"
echo ""
echo "  Overall:"
echo "    • Total new links: $TOTAL_LINKED"
echo "    • Total updated: $TOTAL_UPDATED"
echo "    • Total skipped: $TOTAL_SKIPPED"
echo "    • Total files: $TOTAL_FILES"
echo ""

if [ "$TARGET_BASE_DIR" = "$HOME/.cursor" ]; then
  echo "Global Cursor config is now linked!"
  echo "Rules and commands will apply to all projects by default."
else
  echo "Project-specific config linked to: $TARGET_BASE_DIR"
fi

echo ""
echo "Files are symlinked from dotfiles, so any updates to"
echo "dotfiles/.cursor will automatically apply everywhere."


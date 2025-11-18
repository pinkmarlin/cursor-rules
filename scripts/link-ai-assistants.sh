#!/usr/bin/env bash
set -euo pipefail

# Link curated .codex and .claude assets from this repo into $HOME.
# Useful after cloning/pulling to ensure AI assistants use the saved configuration.

resolve_root() {
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  echo "$(cd "${script_dir}/.." && pwd)"
}

ensure_python() {
  if ! command -v python3 >/dev/null 2>&1; then
    echo "python3 is required for path resolution; please install it before running this script." >&2
    exit 1
  fi
}

realpath_py() {
  python3 - "$1" <<'PY'
import os
import sys

target = sys.argv[1]
print(os.path.realpath(target))
PY
}

link_path() {
  local repo_root="$1"
  local rel_path="$2"
  local source="${repo_root}/${rel_path}"
  local destination="${HOME}/${rel_path}"

  if [ ! -e "${source}" ]; then
    echo "Skipping missing source ${rel_path}" >&2
    return
  fi

  mkdir -p "$(dirname "${destination}")"

  if [ -L "${destination}" ]; then
    local link_target
    link_target="$(realpath_py "${destination}")"
    local source_target
    source_target="$(realpath_py "${source}")"

    if [ "${link_target}" = "${source_target}" ]; then
      echo "Already linked: ${destination}"
      return
    fi

    rm "${destination}"
  fi

  if [ -e "${destination}" ]; then
    local backup="${destination}.bak.$(date +%Y%m%d%H%M%S)"
    mv "${destination}" "${backup}"
    echo "Existing ${destination} moved to ${backup}"
  fi

  ln -s "${source}" "${destination}"
  echo "Linked ${destination} -> ${source}"
}

main() {
  ensure_python

  local repo_root
  repo_root="$(resolve_root)"

  local items=(
    ".codex/AGENTS.md"
    ".codex/commands.json"
    ".codex/instructions.md"
    ".codex/commands"
    ".codex/subagents"
    ".claude/CLAUDE.md"
    ".claude/commands"
    ".claude/subagents"
  )

  for item in "${items[@]}"; do
    link_path "${repo_root}" "${item}"
  done

  echo "All requested links processed."
}

main "$@"

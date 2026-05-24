#!/usr/bin/env bash
# eos-business-workspace-template setup
# Symlinks the 12 EOS skill folders into ~/.claude/skills/ so Claude Code can
# discover them as native slash-commands (/eos-run-level-10, /eos-rocks, etc.).
#
# Idempotent. Re-run any time to refresh symlinks.
#
# Usage:
#   ./setup.sh             Install skill symlinks
#   ./setup.sh --uninstall Remove symlinks (the source files in this repo stay)
#   ./setup.sh --help      Show this help

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_SKILLS_DIR="$SCRIPT_DIR/.agents/skills"
DEST_SKILLS_DIR="$HOME/.claude/skills"

usage() {
  cat <<'HELP'
eos-business-workspace-template setup

Usage:
  ./setup.sh             Install skill symlinks to ~/.claude/skills/
  ./setup.sh --uninstall Remove the symlinks (source files in this repo stay)
  ./setup.sh --help      Show this help

What it does:
  Symlinks every directory in .agents/skills/ into ~/.claude/skills/ so Claude
  Code discovers them as native slash-commands. After running, /eos-run-level-10,
  /eos-set-quarterly-rocks, /eos-bootstrap-business, etc. work from any
  directory in any Claude Code session.

  Source files stay in this repo. The symlinks point back here, so editing
  a skill in .agents/skills/ updates the live skill immediately.

  Skip this script entirely if you prefer to invoke skills via AGENTS.md
  rather than as global slash-commands. Both work.
HELP
}

uninstall() {
  echo "Removing eos-* and sync-with-upstream symlinks from $DEST_SKILLS_DIR..."
  removed=0
  for src_skill in "$SRC_SKILLS_DIR"/*/; do
    [[ -d "$src_skill" ]] || continue
    name="$(basename "$src_skill")"
    dest="$DEST_SKILLS_DIR/$name"
    if [[ -L "$dest" ]] && [[ "$(readlink "$dest")" == "$src_skill"* ]]; then
      rm "$dest"
      echo "  removed $name"
      ((removed++))
    fi
  done
  echo
  echo "$removed symlink(s) removed. Source files in $SRC_SKILLS_DIR are untouched."
}

install() {
  if [[ ! -d "$SRC_SKILLS_DIR" ]]; then
    echo "ERROR: $SRC_SKILLS_DIR does not exist. Are you running from the repo root?"
    exit 1
  fi

  mkdir -p "$DEST_SKILLS_DIR"

  echo "Symlinking skills from $SRC_SKILLS_DIR to $DEST_SKILLS_DIR..."
  echo

  linked=0
  skipped=0
  conflicted=0

  for src_skill in "$SRC_SKILLS_DIR"/*/; do
    [[ -d "$src_skill" ]] || continue
    name="$(basename "$src_skill")"
    dest="$DEST_SKILLS_DIR/$name"

    # Strip trailing slash from src_skill for symlink target (cleaner).
    src_skill_clean="${src_skill%/}"

    if [[ -L "$dest" ]]; then
      if [[ "$(readlink "$dest")" == "$src_skill_clean" ]]; then
        echo "  ✓ $name (already linked)"
        ((skipped++))
      else
        echo "  ! $name (different symlink exists, skipping; remove manually if you want this one)"
        ((conflicted++))
      fi
    elif [[ -e "$dest" ]]; then
      echo "  ! $name (real file/dir at $dest, NOT a symlink; skipping)"
      ((conflicted++))
    else
      ln -s "$src_skill_clean" "$dest"
      echo "  + $name"
      ((linked++))
    fi
  done

  echo
  echo "Linked: $linked    Already linked: $skipped    Conflicts: $conflicted"
  echo
  if [[ $conflicted -gt 0 ]]; then
    echo "Conflicts mean a skill with the same name already exists at $DEST_SKILLS_DIR/."
    echo "Either rename or remove the existing one, or live with the conflict (your"
    echo "existing skill wins; this repo's version is not linked)."
    echo
  fi

  echo "Done. In any Claude Code session, you can now invoke skills as slash-commands:"
  echo
  echo "  /eos-bootstrap-business"
  echo "  /eos-run-level-10"
  echo "  /eos-set-quarterly-rocks"
  echo "  /eos-people-analyzer"
  echo "  /eos-build-accountability-chart"
  echo "  /eos-design-scorecard"
  echo "  /eos-document-core-process"
  echo "  /eos-ids-single-issue"
  echo "  /eos-quarterly-conversation-prep"
  echo "  /eos-update-vto"
  echo "  /eos-business-health-snapshot"
  echo "  /sync-with-upstream"
}

case "${1:-install}" in
  --help|-h)
    usage
    ;;
  --uninstall)
    uninstall
    ;;
  install|"")
    install
    ;;
  *)
    echo "Unknown argument: $1"
    usage
    exit 1
    ;;
esac

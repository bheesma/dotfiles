#!/usr/bin/env bash
# Installs AI instructions/skills and the shared gitconfig into $HOME. Safe to re-run.
set -euo pipefail
REPO="$(cd "$(dirname "$0")" && pwd)"

# AI files: copy repo .ai -> ~/.ai, then symlink each tool to it
mkdir -p ~/.ai ~/.claude/skills ~/.copilot/skills ~/.copilot/instructions
cp -R "$REPO/.ai/." ~/.ai/
ln -sfn ~/.ai/claude.md ~/.claude/CLAUDE.md
ln -sfn ~/.ai/copilot.instructions.md ~/.copilot/instructions/lean.instructions.md
for dir in ~/.ai/skills/*/; do
  name="$(basename "$dir")"
  ln -sfn "${dir%/}" ~/.claude/skills/"$name"
  ln -sfn "${dir%/}" ~/.copilot/skills/"$name"
done
[ -e ~/.claude/settings.json ] || cp "$REPO/claude/settings.json" ~/.claude/settings.json

# Git aliases: include the repo gitconfig, keep [user] local
if ! git config --global --get-all include.path | grep -qxF "$REPO/.gitconfig"; then
  git config --global --add include.path "$REPO/.gitconfig"
fi
echo "Done."

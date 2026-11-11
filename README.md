# dotfiles
Git, shell, VSCode and AI-tool settings for macOS.

## Install
```
./install.sh
```
Safe to re-run. It:
- copies `.ai/` to `~/.ai` and symlinks Claude and Copilot to it
- generates the Copilot instructions file from `.ai/instructions.md`
- adds this repo's `.gitconfig` (aliases) to `~/.gitconfig` via `[include]`; `[user]` stays local
- copies `claude/settings.json` to `~/.claude/` if missing

## Layout
- `.ai/instructions.md` - single source of AI rules (Claude imports it; Copilot gets a generated copy)
- `.ai/claude.md` - one-line import of `instructions.md`
- `.ai/skills/` - skills shared by Claude and Copilot
- `claude/settings.json` - Claude Code settings
- `.gitconfig`, `.zshrc`, `.p10k.zsh`, `Ocean 2.terminal`, `vscode/` - git, shell, terminal, editor
- `Brewfile` - `brew bundle` to install apps

## Editing AI rules
Edit `.ai/instructions.md` here, then run `./install.sh`. Editing `~/.ai` directly gets overwritten.

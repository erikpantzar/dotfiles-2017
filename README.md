# dotfiles

## Layout
- `nvim/` — LazyVim config, symlinked to `~/.config/nvim`.
- `.zshrc` — symlinked to `~/.zshrc`.
- `.claude/` — portable Claude Code config only; see `.claude/README.md` for
  what's tracked vs. gitignored (this repo is public, so secrets/session
  state never get committed).
- `.oh-my-zsh/` — placeholder, not the actual framework (install oh-my-zsh
  separately via its own installer; `.zshrc` expects it at `~/.oh-my-zsh`).
- `webstorm/` — WebStorm settings export.

## Setup on a new machine

```sh
git clone https://github.com/erikpantzar/dotfiles.git ~/dev/dotfiles

ln -sfn ~/dev/dotfiles/nvim ~/.config/nvim
ln -sf  ~/dev/dotfiles/.zshrc ~/.zshrc

mkdir -p ~/.claude
ln -sf ~/dev/dotfiles/.claude/settings.json ~/.claude/settings.json
ln -sf ~/dev/dotfiles/.claude/statusline-command.sh ~/.claude/statusline-command.sh
```

Back up anything already in those locations first — see each subfolder's
notes for machine-specific setup steps (e.g. `.claude/README.md`).

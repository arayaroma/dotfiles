#!/bin/bash
# Arch Linux setup. Run from the dotfiles repo root.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> git config"
ln -sf "$DOTFILES/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES/.gitmessage" ~/.gitmessage

echo "==> packages (neovim, kitty, alacritty, tmux)"
if command -v pacman >/dev/null; then
  sudo pacman -S --needed --noconfirm neovim kitty alacritty tmux
else
  echo "not on Arch (no pacman) — install neovim/kitty/alacritty/tmux manually" >&2
fi

echo "==> app configs"
mkdir -p ~/.config
ln -sfn "$DOTFILES/.config/nvim" ~/.config/nvim
ln -sfn "$DOTFILES/.config/kitty" ~/.config/kitty
ln -sfn "$DOTFILES/.config/alacritty" ~/.config/alacritty

echo "==> nvim plugins (headless sync)"
nvim --headless "+Lazy! sync" +qa || true

echo "==> kitty as default terminal (xdg-terminal-exec spec)"
mkdir -p ~/.config
echo "kitty.desktop" > ~/.config/xdg-terminals.list

echo "==> GNOME dock: swap GNOME Console for kitty (best-effort, GNOME only)"
if command -v gsettings >/dev/null; then
  current="$(gsettings get org.gnome.shell favorite-apps 2>/dev/null || echo '')"
  if [ -n "$current" ] && echo "$current" | grep -q "org.gnome.Console.desktop"; then
    new="${current//org.gnome.Console.desktop/kitty.desktop}"
    gsettings set org.gnome.shell favorite-apps "$new"
  fi
fi

echo "done. Open a NEW kitty window for terminal/mouse changes to take effect."

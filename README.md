# dotfiles

Arch Linux. Run `./setup.sh` after cloning on a fresh install.

## What it sets up

- `~/.gitconfig`, `~/.gitmessage`
- `~/.config/nvim` — lazy.nvim, LSP, telescope + telescope-frecency (recent-first
  find), nvim-tree (auto-syncs to the file you're editing), alpha-nvim dashboard,
  native tab/split keymaps (`<leader>sv/sh` split, `<C-hjkl>` move, `<leader>tn/tc`
  tabs, `<leader>tt` terminal). `mouse=a` enabled.
- `~/.config/kitty`, `~/.config/alacritty` — terminal emulators (mouse/SGR support
  is why kitty replaced GNOME Console as default)
- kitty set as default terminal via `~/.config/xdg-terminals.list` + GNOME dock
  favorite swapped (GNOME-only, best-effort)
- `neovim`, `kitty`, `alacritty`, `tmux` installed via `pacman`

## Not automated by setup.sh (do manually if needed)

These depend on other repos/paths that won't exist on a fresh machine, so
they're documented here instead of scripted:

### ether-pro job automation (systemd user timer)

If `~/wrkspc/ether-pro` is set up and you want the `repo-review-job` skill
running unattended on a schedule:

```bash
mkdir -p ~/.local/bin ~/.local/share ~/.config/systemd/user
cp systemd-user/repo-review-cron.sh ~/.local/bin/
chmod +x ~/.local/bin/repo-review-cron.sh

# systemd user unit + timer (every 2h at :17, catches up after downtime)
cp systemd-user/repo-review-job.service systemd-user/repo-review-job.timer ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now repo-review-job.timer

# survive logout — user systemd instance normally dies on logout otherwise
loginctl enable-linger "$USER"
```

Check it ran: `systemctl --user status repo-review-job.timer`, `cat ~/.local/share/repo-review-cron.log`.

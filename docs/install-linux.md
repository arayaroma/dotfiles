# Instalar en Linux (Arch)

1. Cloná el repo:
   ```bash
   git clone git@github.com:arayaroma/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Corré el instalador:
   ```bash
   ./setup.sh
   ```
   Esto instala `neovim`, `kitty`, `alacritty`, `tmux` (vía `pacman`),
   enlaza los configs (`~/.gitconfig`, `~/.config/nvim`, `~/.config/kitty`,
   `~/.config/alacritty`), sincroniza los plugins de nvim, y pone kitty
   como terminal por defecto (dock de GNOME + `xdg-terminals.list`).

3. Abrí una terminal **nueva** (kitty) — los cambios de terminal/mouse no
   aplican a la ventana que ya tenías abierta.

4. Listo. Probá `nvim` — debería abrir con el dashboard de ETHER.

## Opcional: automatización de ether-pro (systemd timer)

Solo si tenés `~/wrkspc/ether-pro` clonado y querés el `repo-review-job`
corriendo solo cada 2 horas — ver sección al final del [README.md](../README.md).

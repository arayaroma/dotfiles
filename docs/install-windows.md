# Instalar en Windows

![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)

1. Abrí PowerShell (como administrador si podés — hace falta para
   symlinks; si no, el script copia los archivos igual, solo que después
   hay que re-correrlo cada vez que edites algo en el repo).

2. Cloná el repo:
   ```powershell
   git clone git@github.com:arayaroma/dotfiles.git $HOME\dotfiles
   cd $HOME\dotfiles
   ```

3. Corré el instalador:
   ```powershell
   .\setup.ps1
   ```
   Esto instala `Neovim` y `Alacritty` (vía `winget`), enlaza los configs
   (`~/.gitconfig`, `~\AppData\Local\nvim`, `~\AppData\Roaming\alacritty`),
   y sincroniza los plugins de nvim.

   Si PowerShell bloquea la ejecución del script:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   .\setup.ps1
   ```

4. Abrí Alacritty (o Windows Terminal, también anda bien) y corré `nvim`.

## Qué NO se instala en Windows

kitty (no tiene build nativo), tmux, y todo lo de systemd/GNOME — son
Linux-only, se saltean solos. El resto (splits, tabs, sidebar, atajos)
funciona igual, es toda config Lua sin nada específico de sistema
operativo.

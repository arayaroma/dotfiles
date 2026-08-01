# Windows/PowerShell setup. Run from the dotfiles repo root (elevated
# PowerShell recommended — symlinks need admin or Developer Mode enabled;
# falls back to copying if symlink creation fails).
$ErrorActionPreference = 'Stop'
$Dotfiles = $PSScriptRoot

function Link-Or-Copy($source, $dest) {
    $destDir = Split-Path $dest -Parent
    if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
    if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
    try {
        New-Item -ItemType SymbolicLink -Path $dest -Target $source -Force | Out-Null
        Write-Host "linked  $dest -> $source"
    } catch {
        Copy-Item $source $dest -Recurse -Force
        Write-Host "copied  $dest (symlink failed, no admin/Dev Mode — re-run this script after editing $source)"
    }
}

Write-Host "==> git config"
Link-Or-Copy "$Dotfiles\.gitconfig" "$env:USERPROFILE\.gitconfig"
Link-Or-Copy "$Dotfiles\.gitmessage" "$env:USERPROFILE\.gitmessage"

Write-Host "==> packages (Neovim, Alacritty — kitty has no native Windows build)"
if (Get-Command winget -ErrorAction SilentlyContinue) {
    winget install --id Neovim.Neovim -e --accept-source-agreements --accept-package-agreements
    winget install --id Alacritty.Alacritty -e --accept-source-agreements --accept-package-agreements
} else {
    Write-Warning "winget not found — install Neovim and Alacritty manually"
}

Write-Host "==> nvim config"
Link-Or-Copy "$Dotfiles\.config\nvim" "$env:LOCALAPPDATA\nvim"

Write-Host "==> alacritty config"
Link-Or-Copy "$Dotfiles\.config\alacritty" "$env:APPDATA\alacritty"

Write-Host "==> nvim plugins (headless sync)"
try { nvim --headless "+Lazy! sync" +qa } catch { Write-Warning "nvim not on PATH yet — open a new shell and run: nvim --headless `"+Lazy! sync`" +qa" }

Write-Host "done. Open a NEW terminal (Alacritty or Windows Terminal) for changes to take effect."
Write-Host "Not ported: kitty (no Windows build, use Alacritty or Windows Terminal instead), tmux/systemd/GNOME bits (Linux-only, skipped)."

# nvim config

Minimal from-scratch Neovim config. Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-bootstraps on first launch).

## Includes

- LSP via `mason.nvim` + `nvim-lspconfig` (`ts_ls`, `biome`)
- Formatting on save via `conform.nvim` (uses project's `biome.json` when present)
- `nvim-treesitter` (main branch, new API)
- File explorer: `oil.nvim` (`-` to open parent dir)
- Fuzzy finder: `telescope.nvim` (`<leader>ff` files, `<leader>fg` grep, `<leader>fb` buffers)

## Requirements

- neovim >= 0.11
- git, ripgrep, nodejs/npm (for LSP servers via mason)
- tree-sitter-cli + a C compiler (gcc/cc) for treesitter parsers

## Install

```sh
git clone <this-repo-url> ~/.config/nvim
nvim
```

Plugins install automatically on first launch. Run `:Lazy sync` to update, `:Mason` to check LSP servers.

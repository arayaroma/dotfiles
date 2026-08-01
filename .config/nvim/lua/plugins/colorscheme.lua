return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
          telescope = true,
        },
      })
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },
  { 'folke/tokyonight.nvim', lazy = true },
  { 'ellisonleao/gruvbox.nvim', lazy = true },
  { 'rebelot/kanagawa.nvim', lazy = true },
  { 'navarasu/onedark.nvim', lazy = true },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = true },
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      { '<leader>th', '<cmd>Telescope colorscheme enable_preview=true<cr>', desc = 'Pick colorscheme (live preview)' },
    },
  },
}

return {
  {
    'williamboman/mason.nvim',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim' },
    opts = {
      ensure_installed = { 'ts_ls', 'biome' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason-lspconfig.nvim' },
    config = function()
      vim.lsp.enable({ 'ts_ls', 'biome' })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
        float = { border = 'rounded' },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      })

      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic under cursor' })
      vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Next diagnostic' })
      vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Prev diagnostic' })
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics list (buffer+project)' },
    },
    opts = {},
  },
}

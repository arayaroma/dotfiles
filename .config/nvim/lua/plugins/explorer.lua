return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 30,
        preserve_window_proportions = true,
      },
    },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file tree sidebar' },
    },
    config = function(_, opts)
      require('nvim-tree').setup(opts)
      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          if bufname == '' or vim.bo.buftype ~= '' then
            return
          end
          local api_ok, api = pcall(require, 'nvim-tree.api')
          if api_ok and api.tree.is_visible() then
            api.tree.find_file(bufname)
          end
        end,
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent dir' },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-frecency.nvim' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({})
      telescope.load_extension('frecency')
    end,
    keys = {
      {
        '<leader>ff',
        function()
          local reveal_in_tree = function(_, map)
            local actions = require('telescope.actions')
            local function open_and_reveal(prompt_bufnr)
              actions.select_default(prompt_bufnr)
              local ok, api = pcall(require, 'nvim-tree.api')
              if ok then
                api.tree.open()
                api.tree.find_file(vim.api.nvim_buf_get_name(0))
              end
            end
            map('i', '<CR>', open_and_reveal)
            map('n', '<CR>', open_and_reveal)
            return true
          end
          -- frecency: most recently/frequently opened files first, scoped to cwd
          require('telescope').extensions.frecency.frecency({
            workspace = 'CWD',
            attach_mappings = reveal_in_tree,
          })
        end,
        desc = 'Find files, most recent first (reveals in tree sidebar)',
      },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    },
  },
}

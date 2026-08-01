return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      tab = {
        sync = {
          open = true,
          close = false,
        },
      },
      view = {
        width = 30,
        preserve_window_proportions = true,
      },
      actions = {
        -- root cause of the sidebar snapping back to its configured width
        -- on every file open: this option explicitly calls view.resize()
        -- with no args, which resets to the configured width and discards
        -- any manual resize. Off = manual resizes persist.
        open_file = {
          resize_window = false,
        },
      },
    },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file tree sidebar' },
    },
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
                api.tree.open() -- no-op if already open, doesn't resize
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

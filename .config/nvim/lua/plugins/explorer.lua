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

      -- find_file() re-renders the tree window, which snaps it back to the
      -- configured view.width and discards any manual resize. Capture and
      -- reapply the width around the call so manual resizes survive.
      _G.__nvim_tree_find_file_preserve_width = function(path)
        local api_ok, api = pcall(require, 'nvim-tree.api')
        if not api_ok or not api.tree.is_visible() then
          return
        end
        local win = api.tree.winid and api.tree.winid()
        local width = win and vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_width(win) or nil
        api.tree.find_file(path)
        if width then
          vim.schedule(function()
            local new_win = api.tree.winid and api.tree.winid()
            if new_win and vim.api.nvim_win_is_valid(new_win) then
              vim.api.nvim_win_set_width(new_win, width)
            end
          end)
        end
      end

      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          if bufname == '' or vim.bo.buftype ~= '' then
            return
          end
          _G.__nvim_tree_find_file_preserve_width(bufname)
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
                if _G.__nvim_tree_find_file_preserve_width then
                  _G.__nvim_tree_find_file_preserve_width(vim.api.nvim_buf_get_name(0))
                else
                  api.tree.find_file(vim.api.nvim_buf_get_name(0))
                end
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

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
    keys = {
      { '<leader>gb', function() require('gitsigns').blame_line({ full = true }) end, desc = 'Git blame line' },
      { '<leader>gB', function() require('gitsigns').toggle_current_line_blame() end, desc = 'Toggle inline blame' },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'TODOs list' },
    },
  },
}

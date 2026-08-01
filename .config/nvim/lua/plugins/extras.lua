return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
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

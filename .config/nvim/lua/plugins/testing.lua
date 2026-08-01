return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/nvim-nio',
    'nvim-neotest/neotest-jest',
    'marilari88/neotest-vitest',
  },
  opts = function()
    return {
      adapters = {
        require('neotest-jest')({
          jestCommand = 'npx jest',
        }),
        require('neotest-vitest'),
      },
      -- pass/fail shown inline at the end of each test's line, plus
      -- gutter signs — no separate window needed to see results
      status = {
        virtual_text = true,
        signs = true,
      },
    }
  end,
  config = function(_, opts)
    require('neotest').setup(opts)
  end,
  keys = {
    { '<leader>tr', function() require('neotest').run.run() end, desc = 'Run nearest test' },
    { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run tests in file' },
    { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Test summary' },
    { '<leader>to', function() require('neotest').output.open({ enter = true }) end, desc = 'Show test output' },
    { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle output panel' },
  },
}

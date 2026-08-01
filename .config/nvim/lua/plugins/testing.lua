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
    -- neotest-jest's own jest-config auto-detection uses vim.fn.glob(),
    -- a Vimscript function, from inside neotest's async runner — nvim
    -- forbids that (E5560) and it crashes every real test run. Supply the
    -- config path ourselves with a plain synchronous filesystem walk
    -- (vim.uv.fs_stat, not glob) so neotest-jest never needs to probe.
    local function find_jest_config(file_path)
      local dir = vim.fs.dirname(file_path)
      local candidates = { 'jest.config.ts', 'jest.config.cts', 'jest.config.js', 'jest.config.cjs' }
      while dir and dir ~= '/' do
        for _, name in ipairs(candidates) do
          local path = dir .. '/' .. name
          if vim.uv.fs_stat(path) then
            return path
          end
        end
        dir = vim.fs.dirname(dir)
      end
      return nil
    end

    return {
      adapters = {
        require('neotest-jest')({
          jestCommand = 'npx jest',
          jestConfigFile = find_jest_config,
        }),
        require('neotest-vitest'),
      },
      -- pass/fail shown inline at the end of each test's line, plus
      -- gutter signs — no separate window needed to see results
      status = {
        virtual_text = true,
        signs = true,
      },
      -- In an Nx monorepo (web/api/mobile), background discovery scans
      -- every project eagerly, including apps that trip up neotest-jest's
      -- adapter probing (missing treesitter parsers, missing package.json
      -- in subdirs). Only discover tests in files you actually open/run.
      discovery = {
        enabled = false,
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

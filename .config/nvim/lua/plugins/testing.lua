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
    -- Walk up to the filesystem root. Comparing `dir ~= '/'` only holds on
    -- POSIX — Windows roots look like 'C:/' and never equal '/', which
    -- would loop forever. `vim.fs.dirname` of a root returns the root
    -- itself on every platform, so stopping when it stops changing is the
    -- portable way to detect "reached the top".
    local function walk_up(start_dir, check)
      local dir = start_dir
      while dir do
        local result = check(dir)
        if result then
          return result
        end
        local parent = vim.fs.dirname(dir)
        if parent == dir then
          return nil
        end
        dir = parent
      end
      return nil
    end

    local function find_jest_config(file_path)
      local candidates = { 'jest.config.ts', 'jest.config.cts', 'jest.config.js', 'jest.config.cjs' }
      return walk_up(vim.fs.dirname(file_path), function(dir)
        for _, name in ipairs(candidates) do
          local path = dir .. '/' .. name
          if vim.uv.fs_stat(path) then
            return path
          end
        end
        return nil
      end)
    end

    -- neotest-jest's default isTestFile also probes package.json for a
    -- "jest" dependency to decide if a file belongs to it — broken in an
    -- Nx monorepo where per-app package.json files (apps/web, apps/api,
    -- apps/mobile) don't list jest (only the workspace root does), so it
    -- falls into a buggy fallback path and errors with "cannot read
    -- package.json". We already know this workspace uses jest everywhere;
    -- just match by filename, skip the broken probe entirely.
    local function is_jest_test_file(file_path)
      return file_path ~= nil and (file_path:match('%.spec%.[jt]sx?$') ~= nil or file_path:match('%.test%.[jt]sx?$') ~= nil)
    end

    -- `npx jest` spawns via npm's `npm exec` wrapper, which is known to
    -- leave a lingering parent process when spawned non-interactively
    -- (no TTY) — jest itself finishes and force-exits, but npm's wrapper
    -- process never returns, so neotest waits forever for a result that
    -- already happened. Call the local jest binary directly instead.
    local function find_jest_bin(file_path)
      -- npm's .bin shim is a POSIX shell script named plain `jest` on
      -- Linux/macOS, but `jest.CMD` (a batch file) on Windows — the
      -- extensionless one isn't directly spawnable there.
      local bin_name = vim.fn.has('win32') == 1 and 'jest.CMD' or 'jest'
      return walk_up(vim.fs.dirname(file_path), function(dir)
        local bin = dir .. '/node_modules/.bin/' .. bin_name
        return vim.uv.fs_stat(bin) and bin or nil
      end) or 'npx jest' -- fallback, shouldn't be hit in this workspace
    end

    return {
      adapters = {
        require('neotest-jest')({
          jestCommand = find_jest_bin,
          jestConfigFile = find_jest_config,
          isTestFile = is_jest_test_file,
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

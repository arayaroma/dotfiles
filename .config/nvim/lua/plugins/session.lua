return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    -- restore tabs/splits/buffers/cwd, not folds (avoid stale fold state)
    options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'winpos', 'terminal' },
  },
  keys = {
    { '<leader>qs', function() require('persistence').load() end, desc = 'Restore session (this dir)' },
    { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore last session (any dir)' },
    { '<leader>qd', function() require('persistence').stop() end, desc = "Don't save session on exit" },
  },
  -- Not auto-loading on VimEnter on purpose: it would race the alpha-nvim
  -- dashboard (both hook VimEnter) and either flash the dashboard then
  -- replace it, or skip it silently depending on load order. Restore
  -- explicitly with <leader>qs/<leader>ql instead — one keystroke, no
  -- surprise buffers when you just wanted the dashboard.
}

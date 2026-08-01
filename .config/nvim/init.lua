vim.g.mapleader = ' '
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 300
vim.opt.clipboard = 'unnamedplus'
vim.opt.foldlevelstart = 99
vim.opt.scrolloff = 999

-- Splits (windows within a tabpage)
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split vertical' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split horizontal' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to split below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to split above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right split' })

-- Tabpages (like browser tabs — each can hold its own splits)
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>', { desc = 'Previous tab' })

-- Embedded terminal, in a split
vim.keymap.set('n', '<leader>tt', ':split | terminal<CR>i', { desc = 'Terminal in split' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal insert mode' })

require('config.lazy')

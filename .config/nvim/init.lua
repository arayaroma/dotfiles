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
vim.opt.equalalways = false

-- Splits (windows within a tabpage)
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split vertical' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split horizontal' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to split below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to split above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right split' })

-- Resize splits
vim.keymap.set('n', '<A-h>', ':vertical resize -2<CR>', { desc = 'Shrink split width' })
vim.keymap.set('n', '<A-l>', ':vertical resize +2<CR>', { desc = 'Grow split width' })
vim.keymap.set('n', '<A-j>', ':resize -2<CR>', { desc = 'Shrink split height' })
vim.keymap.set('n', '<A-k>', ':resize +2<CR>', { desc = 'Grow split height' })

-- Tabpages (like browser tabs — each can hold its own splits)
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>', { desc = 'Previous tab' })

-- Tabline: label each tab with its file's name, not "NvimTree" even when
-- the sidebar is the last-focused window in that tab (default vim tabline
-- would pick that).
vim.opt.showtabline = 2
function _G.__tabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    local buflist = vim.fn.tabpagebuflist(i)
    local name = '[No Name]'
    for _, bufnr in ipairs(buflist) do
      if vim.bo[bufnr].filetype ~= 'NvimTree' and vim.bo[bufnr].buftype == '' then
        local bufname = vim.fn.bufname(bufnr)
        name = bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]'
        break
      end
    end
    local hl = i == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#'
    s = s .. hl .. ' ' .. i .. ': ' .. name .. ' '
  end
  return s .. '%#TabLineFill#'
end
vim.opt.tabline = '%!v:lua.__tabline()'

-- Embedded terminal, in a split
vim.keymap.set('n', '<leader>tt', ':split | terminal<CR>i', { desc = 'Terminal in split' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal insert mode' })

require('config.lazy')

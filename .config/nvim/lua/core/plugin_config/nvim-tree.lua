local g                 = vim.g

g.loaded_netrw          = 1
g.loaded_netrwPlugin    = 1

require('nvim-tree').setup()

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')

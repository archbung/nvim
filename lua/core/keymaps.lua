local map = require('utils').map
local g = vim.g

g.mapleader = [[ ]]
g.maplocalleader = [[\]]

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<leader>gg', '<cmd>Neogit<cr>', silent)
map({'n','v'}, 'y+', '<cmd>set opfunc=util#clipboard_yank<cr>g@', silent)

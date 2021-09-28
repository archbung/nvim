-- vim:set ts=2 sts=2 sw=2 et:
local g, cmd = vim.g, vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo
local utils = require('config.utils')
local opt, autocmd, map = utils.opt, utils.autocmd, utils.map

-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[\]]

-- Disable unwanted built-in plugins
local disabled_builtins = {
  'gzip', 'man', 'matchit', 'matchparen', 'shada_plugin', 'tarPlugin',
  'tar', 'zipPlugin', 'zip', 'netrwPlugin',
}
for _, b in ipairs(disabled_builtins) do
  g['loaded_' .. b] = 1
end

-- Commands
cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

-- Settings
local buffer, window = { o, bo }, { o, wo }
opt('scrolloff', 7)
opt('wildmode', 'longest,full')
opt('whichwrap', o.whichwrap .. '<,>,h,l')
opt('inccommand', 'nosplit')
opt('lazyredraw', true)
opt('showmatch', true)
opt('ignorecase', true)
opt('smartcase', true)
opt('tabstop', 2, buffer)
opt('softtabstop', 0, buffer)
opt('expandtab', true, buffer)
opt('shiftwidth', 2, buffer)
opt('number', true, window)
opt('smartindent', true, buffer)
opt('laststatus', 2)
opt('showmode', false)
opt('shada', [['20,<50,s10,h,/100]])
opt('hidden', true)
opt('shortmess', o.shortmess .. 'c')
vim.opt_global.shortmess:remove('F')
opt('completeopt', 'menuone,noselect')
opt('joinspaces', false)
opt('guicursor', [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]])
opt('updatetime', 500)
opt('conceallevel', 2, window)
opt('concealcursor', 'nc', window)
opt('previewheight', 5)
opt('undofile', true, buffer)
opt('synmaxcol', 500, buffer)
opt('display', 'msgsep')
opt('modeline', false, buffer)
opt('mouse', 'nivh')
opt('signcolumn', 'yes:1', window)

-- Colorscheme
opt('termguicolors', true)
opt('background', 'dark')
g.onedark_terminal_italics = 1
cmd [[colorscheme onedark]]

-- Keybindings
map('n', '<c-h>', '<c-w>h')
map('n', '<c-l>', '<c-w>l')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('', '<F1>', '<cmd>FloatermToggle<cr>')
map('t', 'jj', [[<C-\><C-n>]])
map('n', '<leader>gg', '<cmd>Neogit<cr>', silent)
map({ 'n', 'v', }, 'y+', '<cmd>set opfunc=util#clipboard_yank<cr>g@', silent)

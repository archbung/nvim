local g, cmd = vim.g, vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo
local utils = require('utils')
local opt, autocmd, map = utils.opt, utils.autocmd, utils.map

local buffer, window = { o, bo }, { o, wo }

opt('mouse', 'nivh')
opt('clipboard', 'unnamedplus')
opt('swapfile', false)
opt('completeopt', 'menuone,noselect')

opt('scrolloff', 7)
opt('wildmode', 'longest,full')
opt('whichwrap', o.whichwrap .. '<,>,h,l')
opt('inccommand', 'nosplit')
opt('number', true, window)
opt('showmatch', true)
opt('foldmethod', 'marker')
opt('colorcolumn', '80')
opt('splitright', true)
opt('splitbelow', true)
opt('ignorecase', true)
opt('smartcase', true)
opt('linebreak', true)
opt('shortmess', o.shortmess .. 'c')
opt('joinspaces', false)
opt('smartindent', true, buffer)
opt('expandtab', true, buffer)
opt('shiftwidth', 4, buffer)
opt('tabstop', 4, buffer)
opt('termguicolors', true)

opt('hidden', true)
opt('lazyredraw', true)
opt('synmaxcol', 240)

-- Remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- Don't autocommenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- Remove column marker for selected filetypes
cmd [[autocmd FileType text,markdown setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-- Disable builtin plugins
local disabled_builtins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_builtins) do
  g["loaded_" .. plugin] = 1
end

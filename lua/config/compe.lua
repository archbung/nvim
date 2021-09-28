local g, fn = vim.g, vim.fn
g.loaded_compe_treesitter = true
g.loaded_compe_snippets_nvim = true
g.loaded_compe_spell = true
g.loaded_compe_tags = true
g.loaded_compe_ultisnips = true
g.loaded_compe_vim_lsc = true
g.loaded_compe_vim_lsp = true

require('compe').setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'always',
  documentation = { border = 'single', },
  source = {
    path = true,
    buffer = true,
    calc = false,
    nvim_lsp = true,
    vsnip = false,
    nvim_lua = true,
    luasnip = true,
    ultisnips = false,
  },
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
    return true
  else
    return false
  end
end

local luasnip = require('luasnip')
_G.tab_complete = function()
  if fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return fn['compe#complete()']()
  end
end

_G.s_tab_complete = function()
  if fn.pumvisible() == 1 then
    return '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

local map = require('config.utils').map
local opts = { noremap = true, silent = true, expr = true }
--map('i', '<Tab>', '[[v:lua.tab_complete()]]', opts)
--map('s', '<Tab>', '[[v:lua.tab_complete()]]', opts)
--map('i', '<S-Tab>', '[[v:lua.s_tab_complete()]]', opts)
--map('s', '<S-Tab>', '[[v:lua.s_tab_complete()]]', opts)
map('i', '<c-space>', [[compe#complete()]], opts)
map('i', '<cr>', [[compe#confirm('<cr>')]], opts)

local lsp, buf_keymap, cmd = vim.lsp, vim.api.nvim_buf_set_keymap, vim.cmd

local kind_symbols = {
  Text = '',
  Method = 'Ƒ',
  Function = 'ƒ',
  Constructor = '',
  Variable = '',
  Class = '',
  Interface = 'ﰮ',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '了',
  Keyword = '',
  Snippet = '﬌',
  Color = '',
  File = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
}

require('lspkind').init { symbol_map = kind_symbols, }
require('trouble').setup()

local keymap_opts = { noremap = true, silent = true, }
local on_attach = function(client, bufnr)
  require('lsp_signature').on_attach { bind = true, handler_opts = { border = 'single', }, }
  buf_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', keymap_opts)
  buf_keymap(0, 'n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions<cr>', keymap_opts)
  buf_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', keymap_opts)
  buf_keymap(0, 'n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations<cr>', keymap_opts)
  buf_keymap(0, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', keymap_opts)
  buf_keymap(0, 'n', 'gTD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', keymap_opts)
  buf_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', keymap_opts)
  buf_keymap(0, 'n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references<cr>', keymap_opts)
  buf_keymap(0, 'n', 'gA', '<cmd>lua require("telescope.builtin").lsp_code_actions<cr>', keymap_opts)
  buf_keymap(0, 'n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', keymap_opts)
  buf_keymap(0, 'n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', keymap_opts)

  if client.resolved_capabilities.document_formatting then
    buf_keymap(0, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', keymap_opts)
  end

  cmd 'augroup lsp_autocmds'
  if client.resolved_capabilities.document_highlight == true then
    cmd 'au CursorHold <buffer> lua vim.lsp.buf.document_highlight()'
    cmd 'au CursorMoved <buffer> lua vim.lsp.buf.clear_references()'
  end
  cmd 'augroup END'
end

local lspconfig = require('lspconfig')
local servers = {
  'hls', 'rust_analyzer', 'pyright', 'texlab', 'metals',
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150, },
  }
end

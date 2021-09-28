local map = require('config.utils').map
local bufferline = require('bufferline')

local diagnostics_signs = {
  ['error'] = '',
  warning = '',
  default = '',
},

bufferline.setup {
  options = {
    always_show_bufferline = false,
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dicts, ctx)
      local s = ' '
      for e, n in pairs(diagnostics_dicts) do
        local sym = diagnostics_dicts[e] or diagnostics_signs.default
        s = s .. (#s > 1 and ' ' or '') .. sym .. ' ' .. n
      end
      return s
    end,
    separator_style = 'slant',
  },
}

local opts = { silent = true, nowait = true, }
map('n', '<leader>bl', '<cmd>BufferLinePick<cr>', opts)
map('n', '<leader>bd', '<cmd>bdelete!<cr>', opts)

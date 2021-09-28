require('gitsigns').setup {
  signs = {
    add = { hl = 'GreenSign', numhl = 'GitSignsAddNr' },
    change = { hl = 'BlueSign', numhl = 'GitSignsChangeNr' },
    delete = { hl = 'RedSign', numhl = 'GitSignsDeleteNr' },
    topdelete = { hl = 'RedSign', numhl = 'GitSignsDeleteNr' },
    changedelete = { hl = 'PurpleSign', numhl = 'GitSignsChangeNr' },
  },
  keymaps = {},
}

local telescope = require('telescope')
telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
  },
  file_sorter = require('telescope.sorters').get_fzy_sorter,
  generic_sorter = require('telescope.sorters').get_fzy_sorter,
  pickers = {
    lsp_references = { theme = 'dropdown', },
    lsp_code_actions = { theme = 'dropdown', },
    lsp_definitions = { theme = 'dropdown', },
    lsp_implementations = { theme = 'dropdown', },
    buffers = {
      sort_lastused = true,
      previewer = false,
    },
  },
}

telescope.load_extension('frecency')
telescope.load_extension('fzy_native')

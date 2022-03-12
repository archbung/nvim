local telescope = require('telescope')

telescope.setup {
  defaults = { layout_strategy = 'flex', scroll_strategy = 'cycle' },
  file_sorter = require('telescope/sorters').get_fzy_sorter,
  generic_sorter = require('telescope/sorters').get_fzy_sorter,
}

telescope.load_extension('frecency')
telescope.load_extension('fzy_native')

local map = require('config.utils').map
local silent = { silent = true }
map('n', '<leader>bb', [[<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>]], silent)
map('n', '<leader>fr', [[<cmd>Telescope frecency theme=get_dropdown<cr>]], silent)
map('n', '<leader>fg', [[<cmd>Telescope git_files theme=get_dropdown<cr>]], silent)
map('n', '<leader>ff', [[<cmd>Telescope find_files theme=get_dropdown<cr>]], silent)
map('n', '<leader>sp', [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], silent)
map('n', '<leader>sb', [[<cmd>Telescope current_buffer_fuzzy_find theme=get_dropdown<cr>]], silent)

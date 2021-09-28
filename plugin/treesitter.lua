require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained', 
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true, },
  incremental_selection = {
    enable = true,
  },
  refactor = {
    -- smart_rename = { enable = true, keymaps = { smart_rename 'grr', }, },
    highlight_definitions = { enable = true, },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['iF'] = {
          python = '(function_definition) @function',
          c = '(function_definition) @function',
          java = '(function_declaration) @function',
        },
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['ae'] = '@block.outer',
        ['ie'] = '@block.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['as'] = '@statement.outer',
        ['is'] = '@statement.inner',
        ['am'] = '@call.outer',
        ['im'] = '@call.inner',
        ['ad'] = '@comment.outer',
      },
    },
  },
}

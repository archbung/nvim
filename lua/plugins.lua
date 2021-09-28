-- vim:set ts=2 sts=2 sw=2 et:
local execute, fn = vim.api.nvim_command, vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  execute 'packad packer.nvim'
end

local packer = nil
local function init()
  if packer == nil then
    packer = require('packer')
    packer.init { 
      disable_commands = true,
      max_jobs = 16,
      display = {
        open_fn = function()
          return require('packer.util').float({ border = 'single' })
        end,
      },
    }
  end

  local use = packer.use
  packer.reset()

  -- Let packer manage itself
  use 'wbthomason/packer.nvim'

  -- Movements
  use { 'chaoren/vim-wordmotion', 'justinmk/vim-sneak' }

  -- Wrapping/delimiters
  use {
    'andymass/vim-matchup',
    setup = [[require('config.matchup')]],
    event = 'User ActuallyEditing',
  }

  -- Terminal
  use 'voldikss/vim-floaterm'

  -- Path navigation
  use {
    'justinmk/vim-dirvish',
    {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
    },
  }

  -- Search
  use { 
    'romainl/vim-cool',
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzy-native.nvim',
      },
      wants = {
        'popup.nvim',
        'plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzy-native.nvim',
      },
      setup = [[require('config.telescope_setup')]],
      config = [[require('config.telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      after = 'telescope.nvim',
      requires = { 'tami5/sql.nvim', 'kyazdani42/nvim-web-devicons', },
    },
    {
      'nvim-telescope/telescope-fzy-native.nvim',
      run = 'git submodule update --init --recursive',
    },
  }

  -- Completion and linting
  use {
    'neovim/nvim-lspconfig',
    'onsails/lspkind-nvim',
    'ray-x/lsp_signature.nvim',
    {
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
    },
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    {
      'hrsh7th/nvim-compe',
      config = [[require('config.compe')]],
      event = 'InsertEnter *',
    },
    'mfussenegger/nvim-lint',
  }

  -- Highlights and eye candies
  use {
    'lukas-reineke/indent-blankline.nvim',
    {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      run = ':TSUpdate',
    },
    'joshdick/onedark.vim',
    'psliwka/vim-smoothie',
  }

  -- Git
  use {
    {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim', },
      config = [[require('config.gitsigns')]],
    },
    {
      'TimUntersberger/neogit',
      cmd = 'Neogit',
    },
  }

  -- Buffer management
  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = [[require('config.bufferline')]],
    event = 'User ActuallyEditing',
  }

  -- Haskell
  use {
    'neovimhaskell/haskell-vim',
    setup = [[require('config.haskell')]],
  }
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end
})

return plugins

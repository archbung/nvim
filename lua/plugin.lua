local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git','clone','--depth','1','https://github.com/wbthomason/packer.nvim', install_path})
end

local cmd = vim.cmd
cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Faster filetype
  use 'nathom/filetype.nvim'

  use {
    'windwp/nvim-autopairs',
    config = [[require('config/autopairs')]]
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
        'telescope-fzy-native.nvim'
      },
      wants = {
        'popup.nvim',
        'plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzy-native.nvim'
      },
      setup = [[require('config/telescope_setup')]],
      config = [[require('config/telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      after = 'telescope.nvim',
      requires = { 'tami5/sql.nvim', 'kyazdani42/nvim-web-devicons' }
    },
    {
      'nvim-telescope/telescope-fzy-native.nvim',
      run = 'git submodule update --init --recursive'
    }
  }

  -- Completion
  use {
    'neovim/nvim-lspconfig',
    {
      'hrsh7th/nvim-cmp',
      requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip'
      },
      config = [[require('config/cmp')]]
    }
  }

  -- Highlights and eye candies
  use {
    'lukas-reineke/indent-blankline.nvim',
    {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects'
      },
      run = ':TSUpdate'
    },
    'navarasu/onedark.nvim',
    {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('config/lualine')]]
    }
  }

  -- Navigation
  use {
    'chaoren/vim-wordmotion',
    {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' }
    },
    {
      'phaazon/hop.nvim',
      branch = v1,
      config = [[require('config/hop')]]
    }
  }

  -- Buffer management
  use {
    'akinsho/nvim-bufferline.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = [[require('config/bufferline')]],
    event = 'User ActuallyEditing'
  }

  -- Git
  use {
    {
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim'
    },
    {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = [[require('config/gitsigns')]]
    },
    { 'TimUntersberger/neogit', cmd = 'Neogit' }
  }

  -- LaTeX
  use {
    'lervag/vimtex',
    opt = true,
    ft = 'tex',
    config = [[require('config/vimtex')]]
  }
end)

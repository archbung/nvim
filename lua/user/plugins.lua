local fn = vim.fn

-- Bootstrap packer.nvim
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd [[packadd packer.nvim]]
end

-- Reloads nvim on plugins.lua save
vim.cmd [[
  augroup packer_cfg
    autocmd!
    autocmd BufwritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

packer.init {
  max_jobs = nil,
  display = {
    open_fn = function()
      return require("packer.util").float({
        border = "single",
      })
    end,
  }
}

return packer.startup(function(use)

  use "wbthomason/packer.nvim"

  use "echasnovski/mini.nvim"

  use "nathom/filetype.nvim"

  use "lewis6991/impatient.nvim"

  use "windwp/nvim-autopairs"


  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use {
    "nvim-treesitter/nvim-treesitter-refactor",
    requires = "nvim-treesitter/nvim-treesitter",
  }

  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter/nvim-treesitter",
  }

  use {
    "nvim-treesitter/nvim-treesitter-context",
    requires = "nvim-treesitter/nvim-treesitter",
  }

  use {
    "p00f/nvim-ts-rainbow",
    requires = "nvim-treesitter/nvim-treesitter",
  }


  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
    },
  }

  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
    }
  }

  use {
    "nvim-telescope/telescope-fzy-native.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
    },
    run = "git submodule update --init --recursive",
  }


  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"


  -- Snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"


  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "RRethy/vim-illuminate"


  -- which-key
  use "folke/which-key.nvim"


  -- Git
  use {
    "TimUntersberger/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }

  use "lewis6991/gitsigns.nvim"


  -- Eye candies
  use {
    "catppuccin/nvim",
    as = "catppuccin",
  }

  use "folke/tokyonight.nvim"

  use "lukas-reineke/indent-blankline.nvim"

  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    tag = "nightly",
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true,
    },
  }

  if PACKER_BOOTSTRAP then
    packer.sync()
  end

end)

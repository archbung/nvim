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

  use "lukas-reineke/indent-blankline.nvim"

  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    tag = "nightly",
  }

  if PACKER_BOOTSTRAP then
    packer.sync()
  end

end)

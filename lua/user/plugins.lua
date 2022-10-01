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

  use {
    "wbthomason/packer.nvim", 
    commit = "6afb67460283f0e990d35d229fd38fdc04063e0a",
  }

  use {
    "nathom/filetype.nvim",
    commit = "b522628a45a17d58fc0073ffd64f9dc9530a8027",
  }

  use {
    "lewis6991/impatient.nvim",
    commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6",
  }

  use {
    "windwp/nvim-autopairs",
    commit = "14cc2a4fc6243152ba085cc2059834113496c60a",
  }


  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "8ec59aee8097c64fcf27d1dbd77ea181c50846c5",
    run = ":TSUpdate",
  }

  use { 
    "nvim-treesitter/nvim-treesitter-refactor", 
    commit = "75f5895cc662d61eb919da8050b7a0124400d589",
    requires = "nvim-treesitter/nvim-treesitter",
  }

  use { 
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "e63c2ff8e38fad77299dd74e14c7c9360e1b3181",
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
    commit = "d51c7631dcc0f598692676f554c4e79d7596d541",
    requires = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
    }
  }

  use {
    "nvim-telescope/telescope-fzy-native.nvim",
    commit = "282f069504515eec762ab6d6c89903377252bf5b",
    requires = {
      "nvim-telescope/telescope.nvim",
    },
    run = "git submodule update --init --recursive", 
  }


  -- which-key
  use {
    "folke/which-key.nvim",
    commit = "6885b669523ff4238de99a7c653d47b081b5506d",
  }  


  -- Lang
  -- neorg
  use {
    "nvim-neorg/neorg",
    tag = "*", 
    requires = "nvim-lua/plenary.nvim",
  }

  if PACKER_BOOTSTRAP then
    packer.sync()
  end

end)

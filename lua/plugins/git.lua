return {
  {
    "TimUntersberger/neogit",
    event = "VeryLazy",
    config = function()
      require("neogit").setup({
        use_magit_keybindings = true,
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup()
    end,
  },
}

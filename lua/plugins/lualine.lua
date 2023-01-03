return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        -- section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        icons_enabled = true,
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "lazy" } },
      },
      sections = {
        -- lualine_a = { { "mode", separator = { left = "" } } },
        lualine_b = { "branch" },
        lualine_c = {
          { "diagnostics", sources = { "nvim_diagnostic" } },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          {
            function()
              local navic = require("nvim-navic")
              local ret = navic.get_location()
              return ret:len() > 2000 and "navic error" or ret
            end,
            cond = function()
              if package.loaded["nvim-navic"] then
                local navic = require("nvim-navic")
                return navic.is_available()
              end
            end,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          },
        },
      },
      extensions = { "nvim-tree" },
    })
  end,
}

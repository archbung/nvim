return {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup({ 
      check_ts = true,
      ts_config = {
        lua = { "string", "source", },
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel", },
      fast_wrap = {
        map = "<m-e>",
        chars = { "{", "[", "(", '"', "'", },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })
  end,
}

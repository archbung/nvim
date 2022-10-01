local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then return end

npairs.setup {
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
}

local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then return end

tokyonight.setup {
  style = "storm",
  light_style = "day",
}

vim.api.nvim_command "colorscheme tokyonight"

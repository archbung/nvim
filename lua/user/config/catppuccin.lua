local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then return end

catppuccin.setup {
  flavour = "macchiato",
  integrations = {
    gitsigns = true,
    neogit = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    ts_rainbow = true,
    which_key = true,
    indent_blankline = { enabled = true, },
  },
}
vim.api.nvim_command "colorscheme catppuccin"

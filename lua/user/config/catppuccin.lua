local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then return end

vim.g.catpuccin_flavour = "macchiato"
catppuccin.setup {
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

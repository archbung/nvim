local status_ok, nvim_tree = pcall(require "nvim-tree")
if not status_ok then return end

nvim_tree.setup {
  sort_by = "case_sensitive",
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    adaptive_size = true,
  },
}

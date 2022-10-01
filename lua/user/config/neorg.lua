local status_ok, neorg = pcall(require, "neorg")
if not status_ok then return end

neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          personal = "~/org/personal",
          work = "~/org/work",
        },
      },
    },
  },
}

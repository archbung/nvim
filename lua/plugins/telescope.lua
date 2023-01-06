return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope", },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = "kkharji/sqlite.lua",
    },
    {
      "nvim-telescope/telescope-fzy-native.nvim",
      build = "make",
    },
    {
      "jvgrootveld/telescope-zoxide",
      dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
      },
    },
  },
  config = function()
    local actions = require("telescope.actions")
    local z_utils = require("telescope._extensions.zoxide.utils")

    require("telescope").setup({
      path_display = { "smart", },
      defaults = {
        layout_strategy = "flex",
        scroll_strategy = "cycle",
      },
      mappings = {
        i = {
          ["<c-n>"] = actions.cycle_history_next,
          ["<c-p>"] = actions.cycle_history_prev,
          ["<c-j>"] = actions.move_selection_next,
          ["<c-k>"] = actions.move_selection_previous,
          ["<c-c>"] = actions.close,
          ["<down>"] = actions.move_selection_next,
          ["<up>"] = actions.move_selection_previous,
          ["<cr>"] = actions.select_default,
          ["<c-x>"] = actions.select_horizontal,
          ["<c-v>"] = actions.select_vertical,
          ["<c-t>"] = actions.select_tab,
          ["<c-u>"] = actions.preview_scrolling_up,
          ["<c-d>"] = actions.preview_scrolling_down,
          ["<pageup>"] = actions.preview_scrolling_up,
          ["<pagedown>"] = actions.preview_scrolling_down,
          ["<tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<s-tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<m-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<c-l>"] = actions.complete_tag,
          ["<c-_>"] = actions.which_key,
        },

        n = {
          ["<esc>"] = actions.close,
          ["<cr>"] = actions.select_default,
          ["<c-x>"] = actions.select_horizontal,
          ["<c-v>"] = actions.select_vertical,
          ["<c-t>"] = actions.select_tab,
          ["<tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<s-tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<m-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["<s-h>"] = actions.move_to_top,
          ["<s-m>"] = actions.move_to_middle,
          ["<s-l>"] = actions.move_to_bottom,
          ["<down>"] = actions.move_selection_next,
          ["<up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["<s-g>"] = actions.move_to_bottom,
          ["<c-u>"] = actions.preview_scrolling_up,
          ["<c-d>"] = actions.preview_scrolling_down,
          ["?"] = actions.which_key,
        }
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
        zoxide = {
          mappings = {
            default = {
              after_action = function(selection)
                print("Update to (" .. selection.z_score .. ") " .. selection.path)
              end
            },
            ["<C-s>"] = {
              before_action = function() print("before C-s") end,
              action = function(selection)
                vim.cmd("edit " .. selection.path)
              end
            },
            -- Opens the selected entry in a new split
            ["<C-q>"] = { action = z_utils.create_basic_command("split") },
          },
        },
      },
    })

    require("telescope").load_extension("frecency")
    require("telescope").load_extension("zoxide")
  end,
}

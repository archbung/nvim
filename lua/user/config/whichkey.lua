local status_ok, which_key = pcall(require, "which-key")
if not status_ok then return end

local setup = {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enable = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = true,
      text_objexts = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  icons = {
    breadcrumb = ">>",
    group = "+",
    separator = "|",
  },
  popup_mappings = {
    scroll_up = "<c-u>",
    scroll_down = "<c-d>",
  },
  window = {
    border = "single",
    position = "bottom",
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25,},
    width = { min = 20, max = 50,},
    spacing = 3,
    align = "left",
  },
  ignore_missing = true,
  hidden = {
    "<silent>",
    "<cmd>",
    "<cr>",
    "call",
    "lua",
    "^:",
    "^ ",
  },
  show_help = true,
  triggers = "auto",
  triggers_blacklist = {
    i = { "j", "k", },
    v = { "j", "k", },
  },
}

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local mappings = {
  ["w"] = { "<cmd>w!<cr>", "Save", },
  ["q"] = { "<cmd>q!<cr>", "Quit", },
  ["h"] = { "<cmd>nohlsearch<cr>", "No highlight", },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer", },

  b = {
    name = "Buffers",
    b = {
      "<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>",
      "All buffers",
    }
  },

  f = {
    name = "Files",
    f = {
      "<cmd>Telescope find_files theme=get_dropdown<cr>",
      "Find files",
    },
    r = {
      "<cmd>Telescope frecency theme=get_dropdown<cr>",
      "Recent files",
    },
    g = {
      "<cmd>Telescope git_files theme=get_dropdown<cr>",
      "Git files",
    },
  },

  g = {
    name = "Git",
    g = {
      "<cmd>Neogit<cr>",
      "Open Neogit",
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.sp.buf.code_action()<cr>", "Code Action", },
    d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics", },
    w = { "<cmd>Telescope diagnostics<cr>", "Workspace diagnostics", },
    i = { "<cmd>LspInfo<cr>", "Info", },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info", },
    j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next Diagnostic", },
    k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Previous Diagnostic", },
    q = { "<cmd>lua vim.lsp.diagnostic.setloclist()<cr>", "Quickfix", },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  s = {
    name = "Search",
    p = {
      "<cmd>Telescope live_grep theme=get_dropdown<cr>",
      "Find in project",
    },
    -- TODO: Telescope current_buffer_fuzzy_find does not work yet
    -- b = {
    --   "<cmd>Telescope current_buffer_fuzzy_find theme=get_dropdown<cr>",
    --   "Find in buffer",
    -- }
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)

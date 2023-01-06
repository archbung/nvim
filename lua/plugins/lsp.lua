return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "RRethy/vim-illuminate",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local servers = {
      "sumneko_lua",
      "pyright",
    }

    local mason_settings = {
      ui = { border = "none", },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 8,
    }

    require("mason").setup(mason_settings)
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
    })

    local diagnostic_signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(diagnostic_signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = ""} )
    end

    local diagnostic_config = {
      virtual_text = false,
      signs = { active = signs, },
      update_in_insert = true,
      underline = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        source = "always",
        header = "",
        prefix = "",
      },
    }

    vim.diagnostic.config(diagnostic_config)

    local function lsp_keymaps(bufnr)
      local opts = { noremap = true, silent = true, }
      local keymap = vim.api.nvim_buf_set_keymap
      keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
      keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
      keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
      keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
      keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
      keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
      keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
      keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    end

    local function on_attach(client, bufnr)
      lsp_keymaps(bufnr)
      require("illuminate").on_attach(client)
    end

    local lspconfig = require("lspconfig")
    for _, server in pairs(servers) do
      local args = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      server = vim.split(server, "@")[1]
      lspconfig[server].setup(args)
    end

    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
      debug = false,
      sources = {
        formatting.stylua,
        formatting.fish_indent,
        diagnostics.flake8,
      },
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.jdon", ".git"),
    })
  end,
}

-- Completion and snippet support
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    { "hrsh7th/cmp-cmdline", enabled = cmdline, },
    { "dmitmel/cmp-cmdline-history", enabled = cmdline, },
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    { 
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local check_backspace = function()
      local col = vim.fn.col "." - 1
      return col == 0 or vim.fn.getline("."):sub(col,col):match "%s"
    end

    local kind_icons = {
      Text = "",
      Method = "m",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }

    luasnip.setup({
      history = true,
      enable_autosnippets = true,
    })

    cmp.setup({
      mapping = {
        ["<c-k>"] = cmp.mapping.select_prev_item(), 
        ["<c-j>"] = cmp.mapping.select_next_item(), 
        ["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c", }),
        ["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c", }),
        ["<c-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", }),
        ["<c-y>"] = cmp.config.disable,
        ["<c-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ["<cr>"]  = cmp.mapping.confirm { select = true, },
        ["<tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, { "i", "s", }),
        ["<s-tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s", }),
      },
      formatting = {
        fields = { "kind", "abbr", "menu", },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      sources = {
        { name = "nvim_lsp", },
        { name = "luasnip", },
        { name = "buffer", },
        { name = "path", },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
    })
  end,
}

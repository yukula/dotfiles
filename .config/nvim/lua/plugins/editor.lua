return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "neovim/nvim-lspconfig",
      "onsails/lspkind.nvim",
      { "zbirenbaum/copilot-cmp", config = true },

      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",

      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local lspkind = require "lspkind"

      require("cmp").setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "cmp-nvim-lsp-signature-help" },
        }, {
          { name = "path" },
          { name = "buffer",  keywoard_length = 3 },
          { name = "cmdline" }
        }),

        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

        }),

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },


        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            max_width = 50,
            symbol_map = {
              Copilot = "",
            },
          })
        },

      })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    command = "Telescope",
    config = function()
      local ts = require "telescope"
      local actions = require "telescope.actions"
      local actions_layout = require "telescope.actions.layout"

      ts.setup({
        defaults = {
          mappings = {
            n = {
              ["<M-p>"] = actions_layout.toggle_preview
            },
            i = {
              ["<M-p>"] = actions_layout.toggle_preview,
              ["<C-x>"] = actions.delete_buffer + actions.move_to_top
            },
          },
        },
      })
    end,
  }

}

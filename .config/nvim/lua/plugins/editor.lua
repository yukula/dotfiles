return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "neovim/nvim-lspconfig",
      "onsails/lspkind.nvim",
      { "zbirenbaum/copilot-cmp", config = true, cond = false },

      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",

      {"L3MON4D3/LuaSnip", tag = "v2.2.0", build = "make install_jsregexp"},
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("cmp").setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        sources = cmp.config.sources({
          -- { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "nvim_lua" },
        }, {
          { name = "path" },
          { name = "buffer", keywoard_length = 3 },
          { name = "cmdline" },
        }),

        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-space>"] = cmp.mapping.complete(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
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
          }),
        },
      })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    command = "Telescope",
    keys = {
      { "<leader><space>", "<cmd>Telescope resume<cr>" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
        end,
      },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },

      { "<leader>sg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>" },

      -- lsp
      { "gd", "<cmd>Telescope lsp_definitions<cr>" },
      { "gy", "<cmd>Telescope lsp_type_definitions<cr>" },
      { "gr", "<cmd>Telescope lsp_references<cr>" },
      { "ss", "<cmd>Telescope lsp_document_symbols<cr>" },
      { "sS", "<cmd>Telescope lsp_workspace_symbols<cr>" },
    },
    config = function()
      local ts = require("telescope")
      local actions = require("telescope.actions")
      local actions_layout = require("telescope.actions.layout")

      ts.setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            height = 0.9,
            width = 0.7,
            prompt_position = "top",
            mirror = true,
            scroll_speed = 3,
            preview_height = 0.45,
            preview_cutoff = 10,
          },
          mappings = {
            n = {
              ["<M-p>"] = actions_layout.toggle_preview,
            },
            i = {
              ["<ESC>"] = actions.close,
              ["<M-p>"] = actions_layout.toggle_preview,
              ["<C-x>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      { "<leader>fe", "<cmd>Telescope file_browser<cr>" },
    },
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "echasnovski/mini.pairs",
    event = "BufEnter",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    event = "BufEnter",
    config = true,
  },
  {
    "echasnovski/mini.comment",
    event = "BufEnter",
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>" },
    },
    config = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require("lualine").setup({
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filename" },
          lualine_c = {
            -- invoke `progress` here.
            require("lsp-progress").progress,
          },
        },
      })

      -- listen lsp-progress event and refresh lualine
      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
}

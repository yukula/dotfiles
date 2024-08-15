return {
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
      {
        "<leader>/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        { desc = "[/] Fuzzily search in current buffer" },
      },

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
          -- layout_strategy = "vertical",
          -- layout_config = {
          --   height = 0.9,
          --   width = 0.7,
          --   prompt_position = "top",
          --   mirror = true,
          --   scroll_speed = 3,
          --   preview_height = 0.45,
          --   preview_cutoff = 10,
          -- },
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
      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },
}

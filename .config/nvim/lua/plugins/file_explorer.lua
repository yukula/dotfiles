return {
  {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      keymaps = {
        ["?"] = "actions.show_help",
        ["<esc>"] = "actions.close",
      },
      float = {
        preview_split = "below",
      },
    },
    keys = {
      { "<leader>fe", "<cmd>Oil --float<cr>", desc = "Open current buffer directory" },
      {
        "<leader>fE",
        function()
          require("oil").open_float(vim.fn.getcwd())
        end,
        desc = "Open current working directory",
      },
    },
  },
}

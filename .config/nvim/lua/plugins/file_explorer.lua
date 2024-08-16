return {
  {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons", config = true },
    opts = {
      use_default_keymaps = false,
      keymaps = {
        ["<C-/>"] = "actions.show_help", -- doesn't work and I don't know why
        ["<cr>"] = "actions.select",
        ["q"] = "actions.close",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["<M-p>"] = "actions.preview",
        ["<C-d>"] = "actions.preview_scroll_down",
        ["<C-u>"] = "actions.preview_scroll_up",
        ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
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

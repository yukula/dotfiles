return {
  -- "metalelf0/jellybeans-nvim",
  -- lazy = false,
  -- priority = 1000,
  -- dependencies = { "rktjmp/lush.nvim" },
  -- config = function()
  --   vim.cmd([[colorscheme jellybeans-nvim]])
  -- end,

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme("catppuccin-mocha")
  --   end,
  -- },

  {
    "HoNamDuong/hybrid.nvim",
    priority = 1000,
    config = function(opts)
      require("hybrid").setup({
        terminal_colors = true,
        overrides = function(hl, c)
          local background = "#0a0c10"
          hl.TelescopeNormal = {
            fg = c.fg,
            bg = background,
          }
          hl.NonText = {
            fg = c.fg,
            bg = background,
          }
          hl.TelescopeBorder = {
            fg = c.fg_hard,
            bg = c.bg,
          }
          hl.TelescopeTitle = {
            fg = c.fg_hard,
            bg = c.bg,
            bold = true,
          }
        end,
      })
      -- vim.cmd.colorscheme("hybrid")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa-dragon")
    end,
  },
}

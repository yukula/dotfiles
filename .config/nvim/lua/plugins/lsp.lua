return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_lsp_caps = require("cmp_nvim_lsp").default_capabilities()
      cmp_lsp_caps.offsetEncoding = { "utf-16", "utf-8" }

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })

      lspconfig.lua_ls.setup({
        capabilities = cmp_lsp_caps,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      -- lspconfig.ccls.setup{}
    lspconfig.clangd.setup{
      cmd = {"clangd", "--completion-style=detailed", "--clang-tidy", "--header-insertion=never"},
      capabilities = cmp_lsp_caps
    }
    -- vim.lsp.set_log_level('trace')
    require('vim.lsp.log').set_format_func(vim.inspect)
    end,
  },
  {
    "linrongbin16/lsp-progress.nvim",
    config = true,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
        cpp = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
        json = { "prettier", stop_on_first = true, name = "dprint", timeout_ms = 500 },
        lua = { "stylua" },
        markdown = { "prettier" },
        rust = { name = "rust_analyzer", timeout_ms = 500, lsp_format = "prefer" },
        scss = { "prettier" },
        sh = { "shfmt" },
        ["_"] = { "trim_whitespace", "trim_newlines" },
      },
      format_on_save = function()
        -- Don't format when minifiles is open, since that triggers the "confirm without
        -- synchronization" message.
        if vim.g.minifiles_active then
          return nil
        end

        -- Stop if we disabled auto-formatting.
        if not vim.g.autoformat then
          return nil
        end

        return {}
      end,
    },
    init = function()
      -- Use conform for gq.
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      -- Start auto-formatting by default (and disable with my ToggleFormat command).
      vim.g.autoformat = true
    end,
  },
}

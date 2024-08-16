return {
  {
    "echasnovski/mini.statusline",
    lazy = false,
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({
        use_icons = vim.g.have_nerd_font,
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 40 })
            local diff = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = MiniStatusline.section_location({ trunc_width = 75 })
            local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
              "%<", -- Mark general truncate point
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=", -- End left alignment
              { hl = "MiniStatuslineDevinfo", strings = { lsp } },
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl, strings = { search, location } },
            })
          end,
        },
      })
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      local get_buf_lsp_clients = function(buf_id)
        return vim.lsp.get_clients({ bufnr = buf_id })
      end
      if vim.fn.has("nvim-0.10") == 0 then
        get_buf_lsp_clients = function(buf_id)
          return vim.lsp.buf_get_clients(buf_id)
        end
      end

      statusline.section_lsp = function(args)
        if MiniStatusline.is_truncated(args.trunc_width) then
          return ""
        end

        local icon = ""
        if MiniStatusline.config.use_icons then
          icon = " "
        end

        local lsp_clients = get_buf_lsp_clients(vim.api.nvim_get_current_buf())
        if #lsp_clients ~= 0 then
          return icon .. " " .. lsp_clients[1].name
        end
        return ""
      end
    end,
  },
}

return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      transparent = true,
      overrides = function(colors)
        local theme = colors.theme
        local palette = colors.palette

        ---@type table<string, vim.api.keyset.highlight>
        local statusline_groups = {}
        for mode, color in pairs({
          Normal = palette.oniViolet,
          Pending = palette.waveRed,
          Visual = palette.springGreen,
          Insert = palette.crystalBlue,
          Command = palette.peachRed,
          Other = palette.roninYellow,
        }) do
          statusline_groups["StatuslineMode" .. mode] = { fg = theme.ui.bg_p1, bg = color }
          statusline_groups["StatuslineModeSeparator" .. mode] = { fg = color, bg = theme.ui.bg_p1 }
        end
        statusline_groups = vim.tbl_extend("error", statusline_groups, {
          StatusLine = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p1 },
          StatuslineItalic = { fg = palette.oldWhite, bg = theme.ui.bg_p1, italic = true },
          StatuslineSpinner = { fg = palette.springGreen, bg = theme.ui.bg_p1, bold = true },
          StatuslineTitle = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p1, bold = true },
        })
        -- print(vim.inspect(statusline_groups))

        return vim.tbl_extend("error", statusline_groups, {
          NormalFloat = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
          FloatBorder = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
          FloatTitle = { bg = theme.ui.bg_p1, fg = theme.ui.fg },

          ["@markup.heading"] = { fg = theme.ui.special, bold = true },

          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "none", bg = theme.ui.bg_p1 },
          PmenuSbar = { bg = theme.ui.bg_p1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          -- Completions:
          BlinkCmpKindClass = { link = "@type" },
          BlinkCmpKindColor = { link = "DevIconCss" },
          BlinkCmpKindConstant = { link = "@constant" },
          BlinkCmpKindConstructor = { link = "@type" },
          BlinkCmpKindEnum = { link = "@variable.member" },
          BlinkCmpKindEnumMember = { link = "@variable.member" },
          BlinkCmpKindEvent = { link = "@constant" },
          BlinkCmpKindField = { link = "@variable.member" },
          BlinkCmpKindFile = { link = "Directory" },
          BlinkCmpKindFolder = { link = "Directory" },
          BlinkCmpKindFunction = { link = "@function" },
          BlinkCmpKindInterface = { link = "@type" },
          BlinkCmpKindKeyword = { link = "@keyword" },
          BlinkCmpKindMethod = { link = "@function.method" },
          BlinkCmpKindModule = { link = "@module" },
          BlinkCmpKindOperator = { link = "@operator" },
          BlinkCmpKindProperty = { link = "@property" },
          BlinkCmpKindReference = { link = "@parameter.reference" },
          BlinkCmpKindSnippet = { link = "@markup" },
          BlinkCmpKindStruct = { link = "@structure" },
          BlinkCmpKindText = { link = "@markup" },
          BlinkCmpKindTypeParameter = { link = "@variable.parameter" },
          BlinkCmpKindUnit = { link = "@variable.member" },
          BlinkCmpKindValue = { link = "@variable.member" },
          BlinkCmpKindVariable = { link = "@variable" },
          BlinkCmpLabelDeprecated = { link = "DiagnosticDeprecated" },
          -- BlinkCmpLabelDescription = { fg = colors.grey, italic = true },
          -- BlinkCmpLabelDetail = { fg = colors.grey, bg = colors.bg },
          -- BlinkCmpMenu = { bg = theme.ui.bg_p1 },
          -- BlinkCmpMenuBorder = { bg = 'none', fg = 'none' },
        })
      end,
    })

    vim.cmd.colorscheme("kanagawa-dragon")
  end,
}

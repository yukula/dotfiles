---@type LazyPlugin
return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.o.background = "dark" -- or "light"

        local kanagawa_themes = require("kanagawa.themes")
        kanagawa_themes.mytheme = require("theme")

        require("kanagawa").setup({
            theme = "mytheme",
            background = {
                dark = "mytheme",
                light = "mytheme",
            },
        })
        vim.cmd.colorscheme("kanagawa")
    end
}
-- return {

--     "rebelot/kanagawa.nvim",
--     lazy = false,
--     config = function()
--         require("kanagawa").setup({
--             theme = "wave",
--             colors = {
--                 theme = {
--                     all = {
--                         ui = {
--                             bg_gutter = "none",
--                         }
--                     }
--                 }
--             },
--             background = {
--                 dark = "wave",
--                 light = "lotus"
--             },
--
--             ---@param colors { palette: PaletteColors, theme: ThemeColors }
--             overrides = function(colors)
--                 ---@type table<string, vim.api.keyset.highlight>
--                 return {
--                     PreProc = { fg = colors.palette.katanaGray },
--                     String = { fg = colors.palette.lotusBlue3 },
--                     ["@lsp.type.namespace.cpp"] = { fg = colors.palette.waveRed }
--                 }
--             end
--         })
--         vim.cmd.colorscheme("kanagawa")
--     end
-- }

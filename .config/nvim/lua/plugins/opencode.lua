return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        -- Recommended for `ask()` and `select()`.
        -- Required for `snacks` provider.
        ---@module 'snacks'
        { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            provider = (function()
                if vim.env.ZELLIJ_SESSION_NAME or vim.env.ZELLIJ then
                    return require("opencode.zellij").new({
                        width = "45%",
                        height = "99%",
                        name = "opencode",
                    })
                end
            end)(),

        }

        -- Required for `opts.events.reload`.
        vim.o.autoread = true

        -- Recommended/example keymaps.
        vim.keymap.set({ "n", "x" }, "<leader>as", function() require("opencode").ask("@this: ", { submit = true }) end,
            { desc = "Ask opencode…" })
        vim.keymap.set({ "n", "x" }, "<leader>ax", function() require("opencode").select() end,
            { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "t" }, "<leader>aa", function() require("opencode").toggle() end,
            { desc = "Toggle opencode" })

        vim.keymap.set({ "n", "x" }, "<leader>ap", function() return require("opencode").operator("@this ") end,
            { desc = "Add range to opencode", expr = true })
        vim.keymap.set("n", "<leader>al", function() return require("opencode").operator("@this ") .. "_" end,
            { desc = "Add line to opencode", expr = true })
    end,
}

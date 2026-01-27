return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
        },
        default_format_opts = {
            lsp_format = "fallback",
            quiet = true, -- Suppress notifications
        },
        format_after_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return {
                lsp_format = "fallback",
                quiet = true,
            }
        end,
        notify_on_error = false,
        notify_no_formatters = false,
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        -- Create user commands to toggle format-on-save
        vim.api.nvim_create_user_command("FormatOnSaveOff", function()
            vim.g.disable_autoformat = true
            print("Format-on-save disabled")
        end, { desc = "Disable format-on-save" })

        vim.api.nvim_create_user_command("FormatOnSaveOn", function()
            vim.g.disable_autoformat = false
            print("Format-on-save enabled")
        end, { desc = "Enable format-on-save" })
    end,
}

---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
                disable = {
                    'missing-fields', -- Often false positives with Neovim APIs
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files and all plugins
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false, -- Don't ask about configuring luassert/busted
            },
            completion = {
                callSnippet = 'Replace', -- Better completion for function calls
            },
            format = {
                enable = true,
            },
            hint = {
                enable = true,          -- Enable inlay hints
                arrayIndex = 'Disable', -- Don't show hints for array indices
                setType = true,         -- Show type hints for variables
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

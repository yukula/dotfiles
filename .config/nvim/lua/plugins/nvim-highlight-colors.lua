---@type LazyPlugin
return {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    ft = { 'lua' },
    opts = {
        ---Render style
        ---@usage 'background'|'foreground'|'virtual'
        render = 'virtual', -- Use virtual text for better readability

        ---Set virtual symbol (requires render to be set to 'virtual')
        virtual_symbol = '■',
        virtual_symbol_prefix = '',
        virtual_symbol_suffix = ' ',

        ---Set virtual symbol position
        ---@usage 'inline'|'eol'|'eow'
        ---inline mimics VS Code style (recommended)
        virtual_symbol_position = 'inline',

        ---Enable all color formats
        enable_hex = true,
        enable_short_hex = true,
        enable_rgb = true,
        enable_hsl = true,
        enable_hsl_without_function = true, -- For CSS custom properties
        enable_var_usage = true,
        enable_named_colors = true,
        enable_tailwind = false, -- Set to true if you use Tailwind
        enable_ansi = true,      -- For ANSI escape codes

        ---Exclude very large files for performance
        exclude_filetypes = {},
        exclude_buftypes = { "terminal", "prompt" },
        exclude_buffer = function(bufnr)
            -- Exclude files larger than 1MB
            local max_filesize = 1024 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
            if ok and stats and stats.size > max_filesize then
                return true
            end
            return false
        end,
    },
}

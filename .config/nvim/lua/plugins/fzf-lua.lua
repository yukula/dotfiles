return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/trouble.nvim"
    },
    cmd = 'FzfLua',
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {
        fzf_bin = 'sk',

        -- Global window options - Fleet "island" floating panel
        winopts = {
            -- ========================================
            -- ISLAND POSITIONING (centered on canvas)
            -- ========================================
            height = 0.80,       -- 80% of editor height
            width = 0.85,        -- 85% of editor width
            row = 0.50,          -- centered vertically
            col = 0.50,          -- centered horizontally
            relative = "editor", -- relative to editor, not cursor

            -- ========================================
            -- ISLAND STYLING
            -- ========================================
            border = "rounded", -- rounded corners for modern island feel
            backdrop = 60,      -- dim editor behind (0=opaque, 100=transparent)

            -- ========================================
            -- PREVIEW CONFIGURATION (vertical layout - Fleet style)
            -- Preview appears BELOW results, separated with border
            -- ========================================
            preview = {
                -- VERTICAL LAYOUT (top:  results, bottom: preview)
                layout = "vertical",
                vertical = "down:70%",    -- preview takes bottom 70% of island
                horizontal = "right:60%", -- fallback if toggled to horizontal

                -- Preview separation & chrome
                border = "rounded",   -- separate border creates "subpanel" effect
                title = true,         -- show file path as status bar
                title_pos = "center", -- centered title (Fleet style)

                -- Scrollbar (minimal, modern)
                scrollbar = "float", -- thin floating scrollbar
                scrolloff = -2,      -- offset from right edge

                -- Preview behavior
                hidden = false, -- start visible
                wrap = false,   -- no line wrap for code
                delay = 20,     -- debounce (ms) for fast scrolling

                -- ========================================
                -- PREVIEW WINDOW OPTIONS (typography)
                -- ========================================
                winopts = {
                    number = true,          -- show line numbers in preview
                    relativenumber = false,
                    cursorline = true,      -- highlight current line
                    cursorlineopt = "both", -- highlight line number + line
                    cursorcolumn = false,
                    signcolumn = "no",      -- no sign column clutter
                    list = false,
                    foldenable = false,
                    foldmethod = "manual",
                },
            },

            -- ========================================
            -- MAIN WINDOW OPTIONS (results list)
            -- ========================================
            cursorline = true, -- highlight selected result
            cursorlineopt = "both",

            -- ========================================
            -- SEMANTIC HIGHLIGHT GROUPS (Fleet typography)
            -- ========================================
            hls = {
                -- Main window (results list surface)
                normal = 'Normal',
                border = 'FloatBorder',
                title = 'FloatTitle',
                help_normal = 'Normal',
                help_border = 'FloatBorder',

                -- Preview window (file preview surface)
                preview_normal = 'Normal',
                preview_border = 'FloatBorder',
                preview_title = 'FloatTitle',

                -- Selection & highlights (accent colors)
                cursor = 'IncSearch',
                cursorline = 'CursorLine',
                cursorlinenr = 'CursorLineNr',
                search = 'IncSearch',

                -- Scrollbar
                scrollfloat_e = 'PmenuSbar',
                scrollfloat_f = 'PmenuThumb',
                scrollborder_e = 'FloatBorder',
                scrollborder_f = 'FloatBorder',

                -- Text hierarchy
                dir_part = 'Comment',
                file_part = 'Normal',
            },

            on_create = function()
                -- Called once when fzf window opens
            end,
        },

        -- ========================================
        -- FZF OPTIONS (layout & behavior)
        -- ========================================
        fzf_opts = {
            ['--layout'] = 'reverse',
            ['--info'] = 'inline-right',
            ['--height'] = '100%',
            ['--border'] = 'none',
            ['--multi'] = '', -- Enable multi-select
        },


        -- ========================================
        -- PROVIDER-SPECIFIC SETTINGS
        -- ========================================

        -- LIVE GREP (Full-text search - Fleet's primary use case)
        grep = {
            prompt = '  ',
            input_prompt = 'Search❯ ',
            header_prefix = '  ',
            header_separator = ' │ ',
            rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096",
            rg_glob = false,
            glob_flag = "--iglob",
            glob_separator = "%s%-%-",
        },

        -- FILES (Goto popup - Fleet's file finder)
        files = {
            prompt = '  ',
            git_icons = true,
            file_icons = true,
            color_icons = true,
            fd_opts = "--color=never --type f --hidden --follow --exclude .git",
        },

        -- BUFFERS (open files)
        buffers = {
            prompt = '  ',
            file_icons = true,
            color_icons = true,
            sort_lastused = true,
        },

        -- ========================================
        -- KEYMAPS (Fleet-style bindings)
        -- ========================================
        keymap = {
            builtin = {
                ["<C-d>"] = "preview-page-down",
                ["<C-u>"] = "preview-page-up",
            },
            fzf = {
                ["ctrl-d"] = "preview-page-down",
                ["ctrl-u"] = "preview-page-up",
                ["ctrl-q"] = "select-all+accept",
                ["ctrl-a"] = "beginning-of-line",
                ["ctrl-e"] = "end-of-line",
                ["alt-a"] = "toggle-all",
            },
        },
        -- ========================================
        -- PREVIEWERS
        -- ========================================
        previewers = {
            builtin = {
                treesitter = {
                    enabled = true,
                    disabled = {},
                },
                ts_ctx = {
                    enabled = true,
                    maxlines = 5,
                },
                title_fnamemodify = function(s)
                    return vim.fn.fnamemodify(s, ":~: .")
                end,
            },
        },

    },
    ---@diagnostic enable: missing-fields

    config = function(_, opts)
        require("fzf-lua").setup(opts)

        local has_trouble, trouble_fzf = pcall(require, "trouble.sources.fzf")
        if has_trouble and trouble_fzf.actions then
            local config = require("fzf-lua.config")

            config.defaults.actions.files["ctrl-x"] = trouble_fzf.actions.open
        else
            vim.notify("Trouble integration not available for fzf-lua", vim.log.levels.WARN)
        end
    end,

    -- ========================================
    -- KEYBINDINGS (Fleet-inspired workflow)
    -- ========================================
    keys = {
        { '<leader><leader>', '<cmd>FzfLua resume<cr>',                desc = 'Resume last search' },
        { '<leader>,',        '<cmd>FzfLua buffers<cr>',               desc = 'Buffers' },
        { '<leader>ff',       '<cmd>FzfLua git_files<cr>',             desc = 'Find Files (Git)' },
        { '<leader>fF',       '<cmd>FzfLua files<cr>',                 desc = 'Find Files (cwd)' },
        { '<leader>fl',       '<cmd>FzfLua live_grep<cr>',             desc = "Text Search (live grep)" },
        { '<leader>f/',       '<cmd>FzfLua lgrep_curbuf<cr>',          desc = "Search in Buffer" },
        { '<leader>fw',       '<cmd>FzfLua grep_cword<cr>',            desc = "Search word under cursor", mode = { "n", "v" } },
        { '<leader>fW',       '<cmd>FzfLua grep_cWORD<cr>',            desc = "Search WORD under cursor", mode = { "n", "v" } },
        { '<leader>fv',       '<cmd>FzfLua grep_visual<cr>',           desc = "Search selection",         mode = { "n", "v" } },
        { '<leader>gb',       '<cmd>FzfLua git_blame<cr>',             desc = 'Git Blame' },
        { '<leader>gc',       '<cmd>FzfLua git_bcommits<cr>',          desc = 'Git Log (file)' },
        { '<leader>gC',       '<cmd>FzfLua git_commits<cr>',           desc = 'Git Log (repo)' },
        { '<leader>gs',       '<cmd>FzfLua git_status<cr>',            desc = 'Git Status' },
        { '<leader>gh',       '<cmd>FzfLua git_hunks<cr>',             desc = 'Git Hunks' },
        { '<leader>ll',       '<cmd>FzfLua lsp_finder<cr>',            desc = "LSP Finder" },
        { '<leader>ld',       '<cmd>FzfLua lsp_definitions<cr>',       desc = "Goto Definition" },
        { '<leader>lD',       '<cmd>FzfLua lsp_declarations<cr>',      desc = "Goto Declaration" },
        { '<leader>lr',       '<cmd>FzfLua lsp_references<cr>',        desc = "Find References" },
        { '<leader>lm',       '<cmd>FzfLua lsp_implementations<cr>',   desc = "Goto Implementation" },
        { '<leader>ly',       '<cmd>FzfLua lsp_typedefs<cr>',          desc = "Goto Type Definition" },
        { '<leader>ls',       '<cmd>FzfLua lsp_document_symbols<cr>',  desc = "Document Symbols" },
        { '<leader>lS',       '<cmd>FzfLua lsp_workspace_symbols<cr>', desc = "Workspace Symbols" },
        { '<leader>la',       '<cmd>FzfLua lsp_code_actions<cr>',      desc = "Code Actions" },
    }
}

-- lua/plugins/statusline.lua
return {
    {
        "nvim-mini/mini.statusline",
        lazy = false,
        dependencies = {
            { "nvim-mini/mini-git", version = false },
        },
        config = function()
            local MiniStatusline = require("mini.statusline")

            vim.opt.laststatus = 3
            require("mini.git").setup() -- enables tracking + minigit_summary_string [web:259]

            -- Rewrite mini.git summary string to show only branch (no "( M)" etc.) [web:259]
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniGitUpdated",
                callback = function(ev)
                    local summary = vim.b[ev.buf].minigit_summary
                    local head = summary and summary.head_name or ""
                    -- Pick your icon (this one is common in Nerd Fonts)
                    vim.b[ev.buf].minigit_summary_string = (head ~= "") and head or ""
                end,
            })

            local GLYPH = {
                left_sep = "",
                -- left_sep = "█",
                path_sep = "  ",
                lc_sep   = " ∶ ",

                err      = "",
                warn     = "",
                info     = "",
                hint     = "",

                lsp      = "",
                ft       = "",
            }

            local function mode_token()
                local m = vim.api.nvim_get_mode().mode
                if vim.snippet and vim.snippet.active and vim.snippet.active() then
                    return "SE", "WildMenu"
                end
                if m:match("^n") then return "N", "MiniStatuslineModeNormal" end
                if m:match("^v") or m:match("^V") or m:match("^\22") then return "V", "MiniStatuslineModeVisual" end
                if m:match("^i") then return "I", "MiniStatuslineModeInsert" end
                if m:match("^c") then return "C", "MiniStatuslineModeCommand" end
                if m:match("^t") then return "T", "MiniStatuslineModeOther" end
                return "?", "MiniStatuslineModeOther"
            end

            local function filename_rel_cwd()
                local p = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
                if p == "" then return "[No Name]" end
                return (p:gsub("/", GLYPH.path_sep))
            end

            local function cursor_pos(trunc_width)
                if MiniStatusline.is_truncated(trunc_width or 80) then return "" end
                local l = vim.fn.line(".")
                local c = vim.fn.virtcol(".")
                return string.format("%d%s%d", l, GLYPH.lc_sep, c)
            end

            local function diag_groups(trunc_width)
                if MiniStatusline.is_truncated(trunc_width or 80) then return {} end
                local cnt = vim.diagnostic.count(0)
                local sev = vim.diagnostic.severity
                local SHOW_ZEROS = false

                local function push(out, hl, icon, n)
                    n = n or 0
                    if SHOW_ZEROS or n > 0 then
                        out[#out + 1] = { hl = hl, strings = { string.format("%s %d", icon, n) } }
                    end
                end

                local out = {}
                push(out, "DiagnosticError", GLYPH.err, cnt[sev.ERROR])
                push(out, "DiagnosticWarn", GLYPH.warn, cnt[sev.WARN])
                push(out, "DiagnosticInfo", GLYPH.info, cnt[sev.INFO])
                push(out, "DiagnosticHint", GLYPH.hint, cnt[sev.HINT])
                return out
            end

            local function lsp_or_filetype(trunc_width)
                if MiniStatusline.is_truncated(trunc_width or 80) then return "" end

                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if clients and #clients > 0 then
                    local names = {}
                    for _, c in ipairs(clients) do names[#names + 1] = c.name end
                    return GLYPH.lsp .. " " .. table.concat(names, " ")
                end

                local ft = (vim.bo.filetype ~= "" and vim.bo.filetype) or ""
                if ft == "" then return "" end
                return GLYPH.ft .. " " .. ft
            end

            local active_content = function()
                local tok, tok_hl = mode_token()

                local git = MiniStatusline.section_git({ trunc_width = 60 })

                local groups = {
                    { hl = "WinSeparator",           strings = { GLYPH.left_sep } },
                    { hl = tok_hl,                   strings = { tok } },
                    { hl = "MiniStatuslineDevinfo",  strings = { git } },
                    { hl = "MiniStatuslineFilename", strings = { filename_rel_cwd() } },

                    "%=",

                    { hl = "MiniStatuslineFileinfo", strings = { cursor_pos(80) } },
                }

                vim.list_extend(groups, diag_groups(80))
                groups[#groups + 1] = { hl = "MiniStatuslineFileinfo", strings = { lsp_or_filetype(80) } }

                return MiniStatusline.combine_groups(groups) -- [web:61]
            end

            MiniStatusline.setup({
                content = { active = active_content, inactive = nil },
                use_icons = true,
            })
        end,
    },
}

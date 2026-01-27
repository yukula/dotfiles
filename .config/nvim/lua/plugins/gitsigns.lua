return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        -- signs              = { change = { text = "┋" } },
        -- signs_staged       = { change = { text = "┋" } },
        preview_config     = { border = 'rounded' },
        current_line_blame = false,
        gh                 = true,
        on_attach          = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, { desc = "Next hunk" })

            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, { desc = "Previous hunk" })
            map("n", '<leader>hl',
                function() gs.blame_line({ full = true }) end, { desc = "Line blame (float)" })
            map("n", "<leader>hd", gs.diffthis, { desc = "diff against the index" })
            map("n", "<leader>hD", function() gs.diffthis("~1") end,
                { desc = "diff against previous commit" })
        end
    }
}

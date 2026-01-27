local map = vim.keymap.set

-- Remap for dealing with word wrap and adding jumps to the jumplist.
map('n', 'j', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
map('n', 'k', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

-- Keeping the cursor centered.
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })
map('n', 'n', 'nzzzv', { desc = 'Next result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- Indent while remaining in visual mode.
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Move selected lines up/down in visual mode
map("x", "K", ":move '<-2<CR>gv=gv", {})
map("x", "J", ":move '>+1<CR>gv=gv", {})

-- Quickly go to the end of the line while in insert mode.
map({ 'i', 'c' }, '<C-l>', '<C-o>A', { desc = 'Go to the end of the line' })

-- Split with C-w d\r
map('n', '<C-w>d', '<cmd>split<cr>', { desc = 'Split to the down', remap = true })
map('n', '<C-w>r', '<cmd>vsplit<cr>', { desc = 'Split to the righ', remap = true })

-- Navigate buffers|tabs|quickfix|loclist
for k, v in pairs({
    t = { cmd = "tab", desc = "tab" },
    b = { cmd = "b", desc = "buffer" },
    q = { cmd = "c", desc = "quickfix" },
    l = { cmd = "l", desc = "location" },
}) do
    map("n", "[" .. k:lower(), "<cmd>" .. v.cmd .. "previous<CR>", { desc = "Previous " .. v.desc })
    map("n", "]" .. k:lower(), "<cmd>" .. v.cmd .. "next<CR>", { desc = "Next " .. v.desc })
    map("n", "[" .. k:upper(), "<cmd>" .. v.cmd .. "first<CR>", { desc = "First " .. v.desc })
    map("n", "]" .. k:upper(), "<cmd>" .. v.cmd .. "last<CR>", { desc = "Last " .. v.desc })
end

-- Switch between windows.
map('n', '<C-S-h>', function()
    -- local cur = vim.fn.winnr()
    -- local left = vim.fn.winnr('h')
    -- if cur ~= left then
    --     vim.api.nvim_set_current_win(vim.fn.win_getid(left))
    --     return
    -- end
    vim.cmd.bprev()
end, { desc = 'Prev file in current buffer', silent = true })
map('n', '<C-S-l>', function()
    -- local cur = vim.fn.winnr()
    -- local left = vim.fn.winnr('h')
    -- if cur ~= left then
    --     vim.api.nvim_set_current_win(vim.fn.win_getid(left))
    --     return
    -- end
    vim.cmd.bnext()
end, { desc = 'Next file in current buffer', silent = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to the left window', remap = true })
map('n', '<C-h>', '<C-w>h', { desc = 'Move to the right window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to the bottom window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to the top window', remap = true })


-- Tab navigation.
map('n', '<leader>tq', '<cmd>tabclose<cr>', { desc = 'Close tab page' })
map('n', '<leader>tr', '<cmd>tab split<cr>', { desc = 'New tab page' })
map('n', '<leader>to', '<cmd>tabonly<cr>', { desc = 'Close other tab pages' })

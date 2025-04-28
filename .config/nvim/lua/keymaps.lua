local keymap = vim.keymap

vim.opt.hlsearch = true
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- replace in visual mode without loosing prev copied data
keymap.set("x", "<leader>p", [["_dP]])

-- better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ";", ";<c-g>u")

keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

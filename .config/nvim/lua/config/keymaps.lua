vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- greatest remap ever ???
keymap.set("x", "<leader>p", [["_dP]])

-- better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ";", ";<c-g>u")



vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

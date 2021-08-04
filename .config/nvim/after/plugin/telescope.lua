require('telescope').setup {
--
}

-- helper functions
function Edit_neovim()
  require('telescope.builtin').find_files {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = 'vertical',
    layout_config = {
      width = .5,
      height = 0.4,
      preview_height = 0.5,
    },
  }
end

-- bindings
vim.api.nvim_set_keymap("n", "<space>en", "<cmd>lua Edit_neovim()<CR>", {noremap = true})
-- files
vim.api.nvim_set_keymap("n", "<space>fe", "<cmd>lua require('telescope.builtin').file_browser()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>ft", "<cmd>lua require('telescope.builtin').find_files()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>ff", "<cmd>lua require('telescope.builtin').git_files()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", {noremap = true})


-- git
vim.api.nvim_set_keymap("n", "<space>gs", "<cmd>lua require('telescope.builtin').git_status()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>gc", "<cmd>lua require('telescope.builtin').git_commits()<CR>", {noremap = true})

-- grep
vim.api.nvim_set_keymap("n", "<space>gw", "<cmd>lua require('telescope.builtin').grep_string()<CR>", {noremap = true})

-- lsp
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>sd", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>", {noremap = true})

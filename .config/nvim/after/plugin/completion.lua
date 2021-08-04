vim.o.completeopt = "menuone,noselect"

require('compe').setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
  },
}

-- bindings
vim.api.nvim_set_keymap("i", "<c-y>", 'compe#confirm("<c-y>")', {silent = true, noremap = true, expr = true})--{{{
vim.api.nvim_set_keymap("i", "<c-e>", 'compe#close("<c-e>")', {silent = true, noremap = true, expr = true})
vim.api.nvim_set_keymap("i", "<c-space>", 'compe#complete("")', {silent = true, noremap = true, expr = true})--}}}

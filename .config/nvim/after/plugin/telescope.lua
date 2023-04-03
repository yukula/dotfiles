require('telescope').setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
      mirror = true,
      preview_height = 0.7,
    },
  },
}

local builtin = require('telescope.builtin')

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
vim.keymap.set('n', '<space>en', '<cmd>lua Edit_neovim()<CR>')

-- files
vim.keymap.set('n', '<space>fd', builtin.fd, {})
vim.keymap.set('n', '<space>fg', builtin.git_files, {})
vim.keymap.set('n', '<space>fb', builtin.buffers, {})

-- grep
vim.keymap.set('n', '<space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<space>f/', builtin.current_buffer_fuzzy_find, {})

-- lsp
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<space>ds', builtin.diagnostics, {})

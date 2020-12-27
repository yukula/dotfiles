let loaded_matchparen = 1
let mapleader = ','

" Telescope
nnoremap <C-p> :lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({}))<CR>
nnoremap <leader>ph :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string(require('telescope.themes').get_dropdown({}))<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<CR>


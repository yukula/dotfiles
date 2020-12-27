let g:cache_dir = stdpath('cache') 
let g:plugin_dir = g:cache_dir.'/vim-plug'

if empty(g:cache_dir)
  echoerr "plugins.vim: stdpath('cache') returned empty string" 
endif

if empty(glob(g:cache_dir.'/autoload/plug.vim'))
  exec 'silent !mkdir -p '.g:cache_dir.'/autoload'
  exec 'silent !curl -fLo '.g:cache_dir.'/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  exec 'autocmd VimEnter * PlugInstall --sync | source stdpath(\'config\').'/init.vim'
endif
exec 'set runtimepath^='.g:cache_dir
exec 'set runtimepath^='.g:plugin_dir

call plug#begin(g:plugin_dir)

Plug 'tpope/vim-commentary'
Plug 'APZelos/blamer.nvim'

" telescope 
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" cpp
Plug 'octol/vim-cpp-enhanced-highlight'
call plug#end()

" TODO: fork it.  call <sid>hi('ColorColumn'  , s:white , s:gray_1      )
Plug 'lewis6991/github_dark.nvim'
call plug#end()

" ############################################################################

" COLOR THEME
colorscheme github_dark

" telescope
" https://github.com/nanotee/nvim-lua-guide
" TODO: Add C-j&C-k for navigation in all modes
lua << EOF
local actions = require('telescope.actions')
-- remap default actions in telescope preview
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<c-s>"] = actions.goto_file_selection_split,
        ["<c-\\>"] = actions.goto_file_selection_vsplit,
      },
      n = {
        ["<c-s>"] = actions.goto_file_selection_split,
        ["<c-\\>"] = actions.goto_file_selection_vsplit,
      },
    },
  }
}
EOF


" blamer
let g:blamer_enabled = 0
let g:blamer_delay = 300
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
highlight Blamer guifg=lightgrey



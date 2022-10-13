require('nvim-treesitter.configs').setup {
  ensure_installed = { 'cpp', 'cmake', 'lua', 'vim', 'bash', 'fish', 'comment', 'json'},
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = false, },
}

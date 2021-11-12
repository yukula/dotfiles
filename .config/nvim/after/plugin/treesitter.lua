require('nvim-treesitter.configs').setup {
  ensure_installed = { 'cpp', 'cmake', 'lua', 'vim', 'bash', 'fish', 'comment', 'json'},
  highlight = {
    enable = true,
    use_languagetree = false,
  },
  indent = { enable = true, },
}

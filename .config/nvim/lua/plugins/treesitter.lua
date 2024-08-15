return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "bash", "fish", "c", "diff", "lua", "luadoc", "markdown", "markdown_inline" },
    auto_install = true,

    indent = { enable = true },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" },
    },
  },
}

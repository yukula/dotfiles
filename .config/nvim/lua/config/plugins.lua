return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'marko-cerovac/material.nvim'
  use 'tjdevries/colorbuddy.nvim'

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'hrsh7th/nvim-compe'

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use 'tpope/vim-commentary'
end)

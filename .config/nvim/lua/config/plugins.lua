
local is_wsl = function()
  local sysinfo = vim.fn.system('uname -r')
  if string.find(sysinfo, "Microsoft") then
    return true
  end
    return false;
 end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'marko-cerovac/material.nvim'
  use 'tjdevries/colorbuddy.nvim'

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'

  use 'L3MON4D3/LuaSnip'

  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip' -- snip engine is required
  -- cmp sources
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  use 'onsails/lspkind-nvim'


  if not is_wsl then
    use 'kyazdani42/nvim-web-devicons'
  end
  use 'hoob3rt/lualine.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use 'tpope/vim-commentary'
end)

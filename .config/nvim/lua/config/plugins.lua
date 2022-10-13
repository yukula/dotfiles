
local is_wsl = function()
  local sysinfo = vim.fn.system('uname -r')
  if string.find(sysinfo, "Microsoft") then
    return true
  end
    return false;
 end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'projekt0n/github-nvim-theme'
  use 'VDuchauffour/neodark.nvim'
  use {
    'metalelf0/jellybeans-nvim',
    requires = { 'rktjmp/lush.nvim' }
  }

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  -- use 'jackguo380/vim-lsp-cxx-highlight'

  use 'L3MON4D3/LuaSnip'

  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip' -- snip engine is required
  -- cmp sources
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  use 'onsails/lspkind-nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = {':TSUpdate'},
  }
  use 'nvim-treesitter/playground'



  if not is_wsl then
    use 'kyazdani42/nvim-web-devicons'
  end

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
    'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly'
  }

  use 'hoob3rt/lualine.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use 'tpope/vim-commentary'
  use 'elkowar/yuck.vim'
end)

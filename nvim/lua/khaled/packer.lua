-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use {

    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
     }
    use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
      
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
       -- or                            , branch = '0.1.x',
       requires = { {'nvim-lua/plenary.nvim'} }
    }

    use 'brenoprata10/nvim-highlight-colors'
    
  end)

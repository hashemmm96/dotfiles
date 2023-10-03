return {
  -- Colors
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        -- styles: dark, darker, cool, deep, warm, warmer, light
        style = 'warmer',
      }
      require('onedark').load()
    end
  },

  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('lualine').setup()
    end
  },

  -- Autopair
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },

  'tpope/vim-fugitive',

  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  },
}

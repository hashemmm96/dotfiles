-- Change leader to a comma. Required by Lazy
vim.g.mapleader = ','

-- Autoinstall lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Install plugins
require('lazy').setup({
  -- File explorer
  'kyazdani42/nvim-tree.lua',

  -- Indent line
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
  },

  -- Autopair
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },

  -- Icons
  'kyazdani42/nvim-web-devicons',

  -- Tag viewer
  'preservim/tagbar',

  -- Treesitter interface
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  },

  -- Color schemes
  'navarasu/onedark.nvim',

  -- Languages
  'uarun/vim-protobuf',
  'fatih/vim-go',
  'rust-lang/rust.vim',
  'kergoth/vim-bitbake',
  'hashivim/vim-terraform',
  'plasticboy/vim-markdown',

  -- LSP
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  -- Autocomplete
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- Search
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  -- Statusline
  {
    'freddiehaddad/feline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    after = { 'navarasu/onedark.nvim' },
  },

  -- Git
  'tpope/vim-fugitive',
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Dashboard (start screen)
  {
    'goolord/alpha-nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
  },
}
)

require('core/keymaps')
require('core/options')
require('core/autocmds')
require('core/colors')
require('core/statusline')
require('plugins/indent-blankline')
require('plugins/nvim-cmp')
require('plugins/nvim-lspconfig')
require('plugins/nvim-telescope')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')

require('lang/go')
require('lang/meson')

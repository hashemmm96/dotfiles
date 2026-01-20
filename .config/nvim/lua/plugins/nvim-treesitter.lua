return {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  config = function()
    require('nvim-treesitter.configs').setup{
      -- A list of parser names, or "all"
      ensure_installed = {
        'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'json', 'lua', 'python',
        'rust', 'typescript', 'vim', 'yaml',
      },
      sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
      highlight = {
        enable = true,      -- `false` will disable the whole extension
      },
      indent = { enable = true },
    }
  end
}

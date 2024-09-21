return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
        indent = { char = '·' },
      exclude = {
        filetypes = {
          'lspinfo',
          'packer',
          'checkhealth',
          'help',
          'man',
          'dashboard',
          'git',
          'markdown',
          'text',
          'terminal',
          'NvimTree',
        },
        buftypes = {
          'terminal',
          'nofile',
          'quickfix',
          'prompt',
        },
      },
    },
}

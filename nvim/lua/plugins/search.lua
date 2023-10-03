return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },

  config = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    local actions = require('telescope.actions')

    require('telescope').setup {
      pickers = {
        live_grep = {
          mappings = {
            i = { ["<C-f>"] = actions.to_fuzzy_refine },
          },
        },
      },
    }

    require('telescope').load_extension('fzf')
  end
}

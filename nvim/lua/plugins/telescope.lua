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
    local config = require('telescope.config')

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    require('telescope').setup {
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        live_grep = {
          mappings = {
            i = { ["<C-f>"] = actions.to_fuzzy_refine },
          },
        },
        find_files = {
          find_command = { "fdfind", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git/*" },
        },
      },
    }

    require('telescope').load_extension('fzf')
  end
}

local function on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '<C-[>', api.tree.change_root_to_parent, opts('Up'))
end

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
        { '<C-n>',     '<cmd>NvimTreeToggle<CR>',   desc = 'open/close NvimTree' },
        { '<leader>f', '<cmd>NvimTreeRefresh<CR>',  desc = 'refresh window' },
        { '<leader>n', '<cmd>NvimTreeFindFile<CR>', desc = 'search file' },
    },

    opts = {
        on_attach = on_attach,
        actions = {
            change_dir = {
                global = true
            }
        }
    }
}

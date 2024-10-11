return {
    'windwp/nvim-autopairs',
    'lewis6991/gitsigns.nvim',
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
    },
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup({
                -- styles: dark, darker, cool, deep, warm, warmer, light
                style = 'warmer'
            })
            require('onedark').load()
        end
    },
    {
        'rust-lang/rust.vim',
        ft = 'rs',
    },
    {
        'hashivim/vim-terraform',
        ft = 'tf',
    },
    {
        'plasticboy/vim-markdown',
        ft = { 'md', 'markdown' },
    },

    {
        'lewis6991/satellite.nvim',
        opts = {
            width = 64,
            winblend = 0,
        },
    },
}

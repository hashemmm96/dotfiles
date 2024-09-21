return {
    'windwp/nvim-autopairs',
    'tpope/vim-fugitive',
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
}

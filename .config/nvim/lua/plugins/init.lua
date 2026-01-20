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
                style = 'warmer',

                -- This forces the background to be NONE, inheriting from Terminal
                transparent = true
            })
            require('onedark').load()
        end
    },
    {
        'lewis6991/satellite.nvim',
        opts = {
            width = 64,
            winblend = 0,
        },
    },
}

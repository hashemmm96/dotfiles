return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
        require('nvim-treesitter').setup {
            -- A list of parser names, or "all"
            ensure_installed = {
                'bash',
                'c',
                'cpp',
                'css',
                'dockerfile',
                'html',
                'javascript',
                'json',
                'lua',
                'markdown',
                'markdown_inline',
                'python',
                'rust',
                'toml',
                'typescript',
                'vim',
                'vimdoc',
                'yaml',
            },
            sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
            highlight = {
                enable = true,    -- `false` will disable the whole extension
            },
            indent = { enable = true },
        }
    end
}

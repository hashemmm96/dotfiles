return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    dependencies = { 'mason-org/mason.nvim' },
    build = ':TSUpdate',
    config = function()
        local parsers = {
            'bash', 'c', 'cpp', 'css', 'dockerfile', 'html', 'javascript',
            'json', 'lua', 'markdown', 'markdown_inline', 'python', 'rust',
            'svelte', 'toml', 'typescript', 'vim', 'vimdoc', 'yaml',
        }

        require('nvim-treesitter').install(parsers)

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                if not lang or not pcall(vim.treesitter.language.add, lang) then return end
                pcall(vim.treesitter.start, args.buf, lang)

                local win = vim.fn.bufwinid(args.buf)
                if win ~= -1 then
                    vim.api.nvim_set_option_value('foldmethod', 'expr', { win = win })
                    vim.api.nvim_set_option_value('foldexpr', 'v:lua.vim.treesitter.foldexpr()', { win = win })
                end
            end,
        })
    end,
}

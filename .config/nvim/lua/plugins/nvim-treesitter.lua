return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        local parsers = {
            'bash', 'c', 'cpp', 'css', 'dockerfile', 'html', 'javascript',
            'json', 'lua', 'markdown', 'markdown_inline', 'python', 'rust',
            'svelte', 'toml', 'typescript', 'vim', 'vimdoc', 'yaml',
        }

        local function has_c_compiler()
            for _, cc in ipairs({ 'cc', 'gcc', 'clang', 'cl', 'zig' }) do
                if vim.fn.executable(cc) == 1 then return true end
            end
            return false
        end

        local function install_parsers()
            require('nvim-treesitter').install(parsers)
        end

        if not has_c_compiler() then
            vim.notify(
                'nvim-treesitter: no C compiler found on PATH (cc/gcc/clang/cl/zig); skipping parser install. '
                    .. 'Install one to enable treesitter highlighting.',
                vim.log.levels.WARN
            )
        elseif vim.fn.executable('tree-sitter') == 1 then
            install_parsers()
        else
            vim.api.nvim_create_autocmd('User', {
                pattern = 'MasonPackageReady:tree-sitter-cli',
                once = true,
                callback = install_parsers,
            })
        end

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

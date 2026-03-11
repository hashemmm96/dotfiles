-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
    end
})

-- Set window title
autocmd('BufEnter', {
    pattern = '',
    command = [[set titlestring=\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}]]
})

-- Use LSP folding when an LSP attaches; fall back to treesitter when it detaches
augroup('LspFolding', { clear = true })
autocmd('LspAttach', {
    group = 'LspFolding',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.foldingRangeProvider then
            vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end
    end,
})
autocmd('LspDetach', {
    group = 'LspFolding',
    callback = function(args)
        local bufnr = args.buf
        if vim.tbl_isempty(vim.lsp.get_clients({ bufnr = bufnr })) then
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end
    end,
})

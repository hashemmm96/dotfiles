-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.hl.on_yank({ higroup = 'IncSearch', timeout = 1000 })
    end,
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
        if vim.tbl_isempty(vim.lsp.get_clients({ bufnr = args.buf })) then
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end
    end,
})

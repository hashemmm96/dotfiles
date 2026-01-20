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

-- Change fold method to 'indent' for python files
augroup('setFoldMethod', { clear = true })
autocmd('Filetype', {
    group = 'setFoldMethod',
    pattern = { 'python' },
    command = 'setlocal foldmethod=indent'
})

-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings:
--------------------

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Set window title to <filename> (<dir>)
autocmd('BufEnter', {
  pattern = '',
  command = [[set titlestring=\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}]]
})

-- Settings for filetypes:
--------------------------

-- Disable line length marker
augroup('setLineLength', { clear = true })
autocmd('Filetype', {
  group = 'setLineLength',
  pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
  command = 'setlocal cc=0'
})

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- Change fold method to 'indent' for python files
augroup('setFoldMethod', { clear = true })
autocmd('Filetype', {
  group = 'setFoldMethod',
  pattern = { 'python' },
  command = 'setlocal foldmethod=indent'
})

-- Use jsonc instead of json
augroup('jsonc', { clear = true })
autocmd('Filetype', {
  group = 'jsonc',
  pattern = { 'json' },
  command = 'setlocal filetype=jsonc'
})

-- Setup meson filetype autocmds
augroup('Meson', { clear = true })
autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'Meson',
  pattern = 'meson.build',
  command = 'set filetype=meson',
})

autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'Meson',
  pattern = 'meson_options.txt',
  command = 'set filetype=mesonopt',
})

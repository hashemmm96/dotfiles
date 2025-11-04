-- Change leader to a comma. Required by Lazy
vim.g.mapleader = ','

if vim.g.vscode then
    require('config/vscode')
else
    require('config/lazy')
    require('config/keymaps')
    require('config/options')
    require('config/commands')
    require('config/autocmds')
end

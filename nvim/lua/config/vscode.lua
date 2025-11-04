vim.opt.clipboard = 'unnamedplus'

-- Clear search highlighting with <leader> and c
vim.keymap.set('n', '<leader>c', ':nohl<CR>', { noremap = true, silent = true });

-- Leader ff: Search Files by Name (VS Code Quick Open)
-- Calls the VS Code command to open the Quick Open menu (Ctrl+P/Cmd+P)
vim.keymap.set('n', '<Leader>ff', function()
    vim.fn["VSCodeNotify"]('workbench.action.quickOpen')
end, { noremap = true, silent = true, desc = "VS Code: Quick Open (File Search)" })


-- Leader fg: Search File Contents (VS Code Find in Files)
-- Calls the VS Code command to open the global search panel (Ctrl+Shift+F/Cmd+Shift+F)
vim.keymap.set('n', '<Leader>fg', function()
    vim.fn["VSCodeNotify"]('workbench.action.findInFiles')
end, { noremap = true, silent = true, desc = "VS Code: Find in Files (Content Search)" })

-- Do not exit visual mode after indent
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })

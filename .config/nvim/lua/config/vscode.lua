vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.ignorecase = true         -- Ignore case letters when search
vim.opt.smartcase = true          -- Ignore lowercase for the whole pattern

-- Clear search highlighting
vim.keymap.set('n', '<leader>c', ':nohl<CR>', { noremap = true, silent = true })

-- Leader ff: Search Files by Name (VS Code Quick Open)
vim.keymap.set('n', '<Leader>ff', function()
    require('vscode').call('workbench.action.quickOpen')
end, { noremap = true, silent = true, desc = "VS Code: Quick Open" })

-- Leader fg: Search File Contents (VS Code Find in Files)
vim.keymap.set('n', '<Leader>fg', function()
    require('vscode').call('workbench.action.findInFiles')
end, { noremap = true, silent = true, desc = "VS Code: Find in Files" })

-- Previous problem
vim.keymap.set('n', '[d', function()
    require('vscode').call('editor.action.marker.prev')
end, { noremap = true, silent = true, desc = "VS Code: Go to previous problem" })

-- Next problem
vim.keymap.set('n', ']d', function()
    require('vscode').call('editor.action.marker.next')
end, { noremap = true, silent = true, desc = "VS Code: Go to next problem" })

-- Do not exit visual mode after indent
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })

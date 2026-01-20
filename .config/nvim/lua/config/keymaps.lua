-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
local opts = { noremap = true, silent = true }

-- Clear search highlighting with <leader> and c
vim.keymap.set('n', '<leader>c', ':nohl<CR>', opts)

-- Close all windows and exit from Neovim with <leader> and q
vim.keymap.set('n', '<leader>q', ':qa!<CR>', opts)

-- Do not exit visual mode after indent
vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('v', '<', '<gv', opts)

-- Terminal mappings
-- Exit terminal-mode using Esc (and C-[)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', opts)
-- Move windows using <C-w> (overrides delete word command)
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h', opts)
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j', opts)
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k', opts)
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l', opts)

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
local opts = { noremap = true, silent = true }

-- Clear search highlighting with <leader> and c
vim.keymap.set('n', '<leader>c', ':nohl<CR>', opts)

-- change vertical to horizontal split orientation
vim.keymap.set('n', '<leader>tk', '<C-w>t<C-w>K', opts)
-- change horizontal to vertical split orientation
vim.keymap.set('n', '<leader>th', '<C-w>t<C-w>H', opts)

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Close all windows and exit from Neovim with <leader> and q
vim.keymap.set('n', '<leader>q', ':qa!<CR>', opts)

-- Do not exit visual mode after indent
vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('v', '<', '<gv', opts)

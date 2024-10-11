-- Create github pull request from branch
vim.api.nvim_create_user_command('Ghpr', '!gh pr create --fill', {})

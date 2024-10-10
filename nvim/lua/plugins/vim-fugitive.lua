return {
    'tpope/vim-fugitive',

    config = function()
        vim.api.nvim_create_user_command('GitL1', 'Git -p log --oneline --graph --decorate', {})
        vim.api.nvim_create_user_command('GitLL', 'Git -p log --oneline --graph --decorate --all', {})
    end

}

return {
    'tpope/vim-fugitive',

    config = function()
        vim.api.nvim_create_user_command('GitLog', 'Git -p log --oneline --graph --decorate', {})
        vim.api.nvim_create_user_command('GitLogAll', 'Git -p log --oneline --graph --decorate --all', {})
    end
}

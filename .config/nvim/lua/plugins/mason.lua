return {
    'mason-org/mason.nvim',
    lazy = false,
    priority = 100,
    build = ':MasonUpdate',
    opts = {
        ensure_installed = { 'tree-sitter-cli' },
    },
    config = function(_, opts)
        require('mason').setup(opts)

        local path_sep = vim.fn.has('win32') == 1 and ';' or ':'
        local mason_bin = vim.fs.normalize(vim.fn.stdpath('data') .. '/mason/bin')
        if not vim.env.PATH:find(mason_bin, 1, true) then
            vim.env.PATH = mason_bin .. path_sep .. vim.env.PATH
        end

        local registry = require('mason-registry')
        registry.refresh(function()
            for _, name in ipairs(opts.ensure_installed or {}) do
                local pkg = registry.get_package(name)
                local function notify_ready()
                    vim.schedule(function()
                        vim.api.nvim_exec_autocmds('User', { pattern = 'MasonPackageReady:' .. name })
                    end)
                end
                if pkg:is_installed() then
                    notify_ready()
                else
                    pkg:install():once('closed', notify_ready)
                end
            end
        end)
    end,
}

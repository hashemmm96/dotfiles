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

        local registry = require('mason-registry')
        registry.refresh(function()
            for _, name in ipairs(opts.ensure_installed or {}) do
                local pkg = registry.get_package(name)
                if not pkg:is_installed() then
                    pkg:install()
                end
            end
        end)

        local mason_bin = vim.fn.stdpath('data') .. '/mason/bin'
        if not vim.env.PATH:find(mason_bin, 1, true) then
            vim.env.PATH = mason_bin .. ':' .. vim.env.PATH
        end
    end,
}

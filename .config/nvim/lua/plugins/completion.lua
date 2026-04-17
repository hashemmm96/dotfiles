return {
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            {
                'L3MON4D3/LuaSnip',
                version = 'v2.*',
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load()
                end,
            },
        },
        opts = {
            keymap = {
                preset = 'default',
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
            },
            snippets = { preset = 'luasnip' },
            completion = {
                trigger = { show_on_keyword = true },
                list = { selection = { preselect = false, auto_insert = false } },
                menu = { auto_show = true },
                documentation = { auto_show = true, auto_show_delay_ms = 250 },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            signature = { enabled = true },
        },
        opts_extend = { 'sources.default' },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-org/mason.nvim',
            'mason-org/mason-lspconfig.nvim',
            'saghen/blink.cmp',
        },
        config = function()
            local servers = {
                'bashls',        -- bash
                'clangd',        -- C / C++
                'cssls',         -- CSS
                'html',          -- HTML
                'jsonls',        -- JSON
                'lua_ls',        -- Lua
                'marksman',      -- Markdown
                'pyright',       -- Python (types)
                'ruff',          -- Python (lint/format)
                'rust_analyzer', -- Rust
                'svelte',        -- Svelte
                'ts_ls',         -- TypeScript / JavaScript
                'yamlls',        -- YAML
            }

            require('mason-lspconfig').setup({
                ensure_installed = servers,
                automatic_enable = false, -- we call vim.lsp.enable() ourselves below
            })

            -- mesonlsp isn't in the Mason registry; enable it if the system binary is present.
            if vim.fn.executable('mesonlsp') == 1 then
                table.insert(servers, 'mesonlsp')
            end

            local capabilities = require('blink.cmp').get_lsp_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            for _, name in ipairs(servers) do
                vim.lsp.config[name] = { capabilities = capabilities }
            end

            vim.lsp.config.lua_ls = {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = { library = { vim.env.VIMRUNTIME } },
                        telemetry = { enable = false },
                    },
                },
            }

            vim.lsp.config.yamlls = {
                capabilities = capabilities,
                settings = {
                    yaml = {
                        format = 'enable',
                        schemas = {
                            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
                        },
                    },
                },
            }

            vim.lsp.enable(servers)

            vim.diagnostic.config({
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = 'minimal',
                    border = 'rounded',
                    source = true,
                    header = '',
                    prefix = '',
                },
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    if client.server_capabilities.documentHighlightProvider then
                        local g = vim.api.nvim_create_augroup('UserLspHighlight_' .. bufnr, { clear = true })
                        vim.api.nvim_create_autocmd('CursorHold', {
                            group = g, buffer = bufnr,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd('CursorMoved', {
                            group = g, buffer = bufnr,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end

                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        group = vim.api.nvim_create_augroup('UserLspDiag_' .. bufnr, { clear = true }),
                        buffer = bufnr,
                        callback = function()
                            vim.diagnostic.open_float({ focus = false })
                        end,
                    })

                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = vim.api.nvim_create_augroup('UserLspFormat_' .. bufnr, { clear = true }),
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end

                    if vim.b[bufnr].user_lsp_keymaps_set then return end
                    vim.b[bufnr].user_lsp_keymaps_set = true

                    local opts = { buffer = bufnr, noremap = true, silent = true }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
                    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
                    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
                    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
                end,
            })
        end,
    },
}

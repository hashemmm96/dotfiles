return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'L3MON4D3/LuaSnip',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'rafamadriz/friendly-snippets',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        -- Add additional capabilities supported by nvim-cmp
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

        local cmp = require('cmp')

        -- Add snippet support
        local luasnip = require('luasnip')
        require('luasnip.loaders.from_vscode').lazy_load()


        local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Highlighting references.
            -- See: https://sbulav.github.io/til/til-neovim-highlight-references/
            -- for the highlight trigger time see: `vim.opt.updatetime`
            if client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_augroup("lsp_highlight", { clear = true })
                vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_highlight" }
                vim.api.nvim_create_autocmd("CursorHold", {
                    callback = vim.lsp.buf.document_highlight,
                    buffer = bufnr,
                    group = "lsp_highlight",
                    desc = "Document Highlight",
                })
                vim.api.nvim_create_autocmd("CursorMoved", {
                    callback = vim.lsp.buf.clear_references,
                    buffer = bufnr,
                    group = "lsp_highlight",
                    desc = "Clear All the References",
                })
            end
            if client.server_capabilities.diagnosticProvider then
                vim.api.nvim_create_augroup("lsp_diagnostic", { clear = true })
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    callback = function()
                        vim.diagnostic.open_float(nil, { focus = false })
                    end,
                    buffer = bufnr,
                    group = "lsp_diagnostic",
                    desc = "Show line diagnostics automatically in hover window",
                })
                vim.diagnostic.config({
                    update_in_insert = true,
                    float = {
                        focusable = false,
                        style = "minimal",
                        border = "rounded",
                        source = true,
                        header = "",
                        prefix = "",
                    },
                })
            end

            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_augroup("lsp_format", { clear = true })
                vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_format" }
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = "lsp_format",
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                })
            end

            -- LSP keymaps
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl',
                function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end,
                opts
            )
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>f',
                function()
                    vim.lsp.buf.format { async = true }
                end,
                opts
            )

            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
        end


        --[[
    Language servers setup
    For language servers list see:
    https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    --]]

        -- Use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches.
        -- Add your language server below:
        local servers = {
            'bashls',
            'clangd',
            'cssls',
            'gopls',
            'html',
            'jsonls',
            'lua_ls',
            'marksman',
            'mesonlsp',
            'pyright',
            'rust_analyzer',
            'ts_ls',
            'yamlls',
        }

        -- Call setup
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end

        -- Override setup for servers that need custom init
        lspconfig.lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = { vim.env.VIMRUNTIME },
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }

        lspconfig.yamlls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                yaml = {
                    format = 'enable',
                    schemas = {
                        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
                    },
                },
            },
        }

        -- Setup code completion
        cmp.setup {
            -- Load snippet support
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- Completion settings
            completion = {
                --completeopt = 'menu,menuone,noselect'
                keyword_length = 2
            },

            -- Key mapping
            mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },

                -- Tab mapping
                ['<Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end,
                ['<S-Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end
            },

            -- Load sources, see: https://github.com/topics/nvim-cmp
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'buffer' },
            },
        }
    end
}

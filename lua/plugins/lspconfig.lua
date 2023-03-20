local M = {
    "neovim/nvim-lspconfig"
}

function M.config()

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'sk', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'


        end,
    })

    local lsp_config = {
        on_attach = function(client, bufnr)
            on_attach(_,bufnr)
        end
    }

    -- require("mason-lspconfig").setup_handlers({
    --     function(server_name)
    --         require("lspconfig")[server_name].setup(lsp_config)
    --     end,
    --     lua_ls=function()
    --         require('lspconfig').lua_ls.setup(vim.tbl_extend('force', lsp_config, {
    --             settings = {
    --                 Lua = {
    --                     diagnostics = {
    --                         global = {'vim'}
    --                     }
    --                 }
    --             }
    --         }))
    --     end
    -- })


    ----------------------- Language Server ------------------------------------------
    -- Setup language servers.
    -- local lspconfig = require('lspconfig')

    ----------------------- Lua ------------------------------------------
    require'lspconfig'.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    ----------------------- HTML ------------------------------------------
    --Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    require'lspconfig'.html.setup {
        capabilities = capabilities,
    }

    ----------------------- CPP ------------------------------------------
    -- https://clangd.llvm.org/features.html
    capabilities.offsetEncoding = { "utf-16" } -- https://github.com/neovim/neovim/pull/16694
    require("lspconfig").clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
            "clangd",
            -- SEE: clangd --help-hidden for possible options
            -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
            -- to add more `checks`, create  a `.clang-tidy` file in the root directory
            -- SEE: https://clang.llvm.org/extra/clang-tidy
            "--clang-tidy",
            "--completion-style=bundled",
            "--cross-file-rename",
            "--fallback-style=LLVM",
            "--function-arg-placeholders=false",
            "--header-insertion=iwyu",
        },
        filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        single_file_support = true,
        init_options = {
            clangdFileStatus = true,
            usePlaceholders = false,
            completeUnimported = true,
            semanticHighlighting = true,
        },
        commands = {
            ClangdSwitchSourceHeader = {
                function()
                    switch_source_header_splitcmd(0, "edit")
                end,
                description = "Open source/header in current buffer",
            },
            ClangdSwitchSourceHeaderVSplit = {
                function()
                    switch_source_header_splitcmd(0, "vsplit")
                end,
                description = "Open source/header in a new vsplit",
            },
            ClangdSwitchSourceHeaderSplit = {
                function()
                    switch_source_header_splitcmd(0, "split")
                end,
                description = "Open source/header in a new split",
            },
        },
    })

    require("lspconfig").jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    require("lspconfig").cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    require("lspconfig").tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })





end


return M

local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "mfussenegger/nvim-jdtls",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        -- lua-dev
        -- IMPORTANT: make sure to setup lua-dev BEFORE lspconfig
        require("neodev").setup({
            -- add any options here, or leave empty to use the default settings
            library = {
                enabled = true, -- when not enabled, lua-dev will not change any settings to the LSP server
                runtime = true, -- runtime path
                types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = true, -- installed opt or start plugins in packpath
            },
            setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
            -- for your Neovim config directory, the config.library settings will be used as is
            -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
            -- for any other directory, config.library.enabled will be set to false
            override = function(root_dir, options) end,
        })
    end
}

function M.config()
    local lsp_signature = require("lsp_signature")
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }

    ---------  Lspsaga setting -------------
    -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    vim.keymap.set('n', 'sd', vim.lsp.buf.definition, opts)

    vim.keymap.set('n', 'sk', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)

    local on_attach = function(client, bufnr)
        vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
        lsp_signature.on_attach(client, bufnr)

        if client.name == "clangd" then
            vim.keymap.set(
            "n",
            "<A-o>",
            "<cmd>ClangdSwitchSourceHeader<CR>",
            { noremap = true, silent = true, buffer = true, desc = "switch source header" }
            )
        end
    end


    require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        -- cmd = { "lua-language-server", "--locale=zh-cn" },
        cmd = { "lua-language-server", "--locale=en" },
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                    autoRequire = false,
                },
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                    disable = {
                        "redefined-local",
                    },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                    -- https://github.com/neovim/nvim-lspconfig/issues/1700#issuecomment-1356282825
                    checkThirdParty = false,
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    })

    local function switch_source_header_splitcmd(bufnr, splitcmd)
        bufnr = require("lspconfig").util.validate_bufnr(bufnr)
        local clangd_client = require("lspconfig").util.get_active_client_by_name(bufnr, "clangd")
        local params = { uri = vim.uri_from_bufnr(bufnr) }
        if clangd_client then
            clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
                if err then
                    error(tostring(err))
                end
                if not result then
                    print("Corresponding file can’t be determined")
                    return
                end
                vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
            end, bufnr)
        else
            print(
            "textDocument/switchSourceHeader is not supported by the clangd server active on the current buffer"
            )
        end
    end

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
            "--clang-tidy=true",
            "--completion-style=bundled",
            "--cross-file-rename",
            "--fallback-style=LLVM",
            "--function-arg-placeholders=false",
            "--header-insertion=never",
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

    require("lspconfig").cmake.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    -- require("lspconfig").pylsp.setup({
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    -- })

    require("lspconfig").jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    require("lspconfig").html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    require("lspconfig").cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
    -- require("lspconfig").eslint.setup({
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    -- })

    require("lspconfig").tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    require("lspconfig").texlab.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    require("lspconfig").pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })


    -- Diagnostic symbols in the sign column (gutter)    ﯦ
    local signs = { Error = " ", Warn = " ", Hint = "", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config({
        virtual_text = {
            prefix = ''
        },
        -- 底部错误提示线
        underline = true,
        update_in_insert = true,
        float = {
            source = "always", -- Or "if_many"
        },
    })


    ----------------------- Language Server ------------------------------------------
    ----------------------- Lua ------------------------------------------
    -- require'lspconfig'.lua_ls.setup({
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    -- })

    ----------------------- HTML ------------------------------------------
    --Enable (broadcasting) snippet capability for completion
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- require'lspconfig'.html.setup {
    --     capabilities = capabilities,
    -- }

    ----------------------- CPP ------------------------------------------
    -- https://clangd.llvm.org/features.html
    -- capabilities.offsetEncoding = { "utf-16" } -- https://github.com/neovim/neovim/pull/16694
    -- require("lspconfig").clangd.setup({
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    --     cmd = {
    --         "clangd",
    --         -- SEE: clangd --help-hidden for possible options
    --         -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    --         -- to add more `checks`, create  a `.clang-tidy` file in the root directory
    --         -- SEE: https://clang.llvm.org/extra/clang-tidy
    --         "--clang-tidy",
    --         "--completion-style=bundled",
    --         "--cross-file-rename",
    --         "--fallback-style=LLVM",
    --         "--function-arg-placeholders=false",
    --         "--header-insertion=iwyu",
    --     },
    --     filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    --     single_file_support = true,
    --     init_options = {
    --         clangdFileStatus = true,
    --         usePlaceholders = false,
    --         completeUnimported = true,
    --         semanticHighlighting = true,
    --     },
    --     commands = {
    --         ClangdSwitchSourceHeader = {
    --             function()
    --                 switch_source_header_splitcmd(0, "edit")
    --             end,
    --             description = "Open source/header in current buffer",
    --         },
    --         ClangdSwitchSourceHeaderVSplit = {
    --             function()
    --                 switch_source_header_splitcmd(0, "vsplit")
    --             end,
    --             description = "Open source/header in a new vsplit",
    --         },
    --         ClangdSwitchSourceHeaderSplit = {
    --             function()
    --                 switch_source_header_splitcmd(0, "split")
    --             end,
    --             description = "Open source/header in a new split",
    --         },
    --     },
    -- })

    -- require("lspconfig").jsonls.setup({
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    -- })

    -- require("lspconfig").cssls.setup({
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    -- })

    -- asdas
    -- require("lspconfig").tsserver.setup({
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    -- })





end


return M

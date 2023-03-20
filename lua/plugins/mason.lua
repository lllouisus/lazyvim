local M = {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
}

function M.config()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            'clangd',
            'pyright',
            'html',
            'lua_ls',
            'marksman',
            'tsserver',
            'jsonls',
            'cssls',
        },
        automatic_installation = true,

    })


end


return M

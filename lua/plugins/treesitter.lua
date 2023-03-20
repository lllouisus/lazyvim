local M = {
    "nvim-treesitter/nvim-treesitter",
    build = "TSUpdate",
    event = "VimEnter",
    dependencies = {
        "nvim-treesitter/playground"
    }
}

function M.config()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            "css",
            "c",
            "cpp",
            "html",
            "lua",
            "typescript",
            "javascript",
            "python",
            "json",
        },
        sync_install = true,
        ignore_install = { },
        highlight = {
            enable = true,
            disable = {}
        },
    })

end

return M

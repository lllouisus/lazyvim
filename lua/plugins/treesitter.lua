return {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    -- version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event =  { "BufReadPost", "BufNewFile" },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                "c",
                "cpp",
                "python",
                "markdown",
                "markdown_inline",
                "tsx",
                "toml",
                "fish",
                "php",
                "json",
                "yaml",
                "swift",
                "css",
                "html",
                "lua",
                "help",
                "javascript",
                "typescript",
                "vim"
            },
            ignore_install = { "phpdoc" },
            highlight = {
                enable = true,
                disable = { "json" }
            },
        }
    end,
}







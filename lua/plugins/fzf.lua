return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        vim.keymap.set("n", "sf", ":lua require('fzf-lua').files({ cwd = '~/.config' })<CR>", {} )
        vim.keymap.set("n", "sl", ":lua require'fzf-lua'.files({ prompt=\"LS> \", cmd = \"ls\", cwd=\"~/<folder>\" })<CR>", {} )
        vim.keymap.set("n", "sh", ":FzfLua help_tags<CR>", {} )
        vim.keymap.set("n", "so", ":FzfLua oldfiles<CR>", {} )
        vim.keymap.set("n", "sb", ":FzfLua buffers<CR>", {} )
        vim.keymap.set("n", "sm", ":FzfLua builtin<CR>", {} )
        vim.keymap.set("n", "<Leader>l", ":FzfLua lsp_document_symbols<CR>", {} )
        -- vim.keymap.set("n", "sw", ":lua require('fzf-lua).live_grep()<CR>", {} )
        vim.keymap.set("n", "sw", ":FzfLua live_grep<CR>", {} )
    end
}


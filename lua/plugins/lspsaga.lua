local M = {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    dependencies = {
        {"nvim-tree/nvim-web-devicons"},
        --Please make sure you install markdown and markdown_inline parser
        {"nvim-treesitter/nvim-treesitter"}
    }
}

function M.config()
    require("lspsaga").setup({


    })

    local keymap = vim.keymap.set

    -- LSP finder - Find the symbol's definition
    -- If there is no definition, it will instead be hidden
    -- When you use an action in finder like "open vsplit",
    -- you can use <C-t> to jump back
    keymap("n", "sj", "<cmd>Lspsaga lsp_finder<CR>")

    -- Code action
    keymap({"n","v"}, "ga", "<cmd>Lspsaga code_action<CR>")

    -- Rename all occurrences of the hovered word for the entire file
    keymap("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>")

    -- Rename all occurrences of the hovered word for the selected files
    keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

    -- Peek definition
    -- You can edit the file containing the definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    -- keymap("n", "sd", "<cmd>Lspsaga peek_definition<CR>")

    -- Go to definition
    -- keymap("n","sd", "<cmd>Lspsaga goto_definition<CR>")

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', 'sj', '<Cmd>Lspsaga lsp_finder<CR>', opts)
    vim.keymap.set('n', 'ff', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    vim.keymap.set('n', 'FF', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
    vim.keymap.set('n', 'se', '<Cmd>Lspsaga peek_definition<CR>', opts)
    -- vim.keymap.set('n', 'sk', '<Cmd>Lspsaga hover_doc<CR>', opts)
    -- vim.keymap.set('n', 'sh', '<Cmd>Lspsaga preview_definition<CR>', opts)


    -- finder icons
    finder_icons = {
        def = '  ',
        ref = '諭 ',
        link = '  ',
    }

    finder = {
        --percentage
        max_height = 0.5,
        force_max_height = false,
        keys = {
            jump_to = 'p',
            edit = { 'o', '<CR>' },
            vsplit = 's',
            split = 'i',
            tabe = 't',
            tabnew = 'r',
            quit = { 'q', '<ESC>' },
            close_in_preview = '<ESC>'
        }
    }

    lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
    }

    definition = {
        edit = "<C-c>o",
        vsplit = "<C-c>v",
        split = "<C-c>i",
        tabe = "<C-c>t",
        quit = "q",
    }
    ui = {
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = "single",
        winblend = 0,
        expand = "",
        collapse = "",
        code_action = "💡",
        incoming = " ",
        outgoing = " ",
        hover = ' ',
        kind = {},
    }

end

return M

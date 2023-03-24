return { -- Adds git releated signs to the gutter, as well as utilities for managing changes
'lewis6991/gitsigns.nvim',
event = "BufRead",
opts = {
    -- See `:help gitsigns.txt`
    signs = {
        -- add = { text = '+' },
        -- change = { text = '~' },
        -- delete = { text = '_' },
        -- topdelete = { text = '‾' },
        -- changedelete = { text = '~' },
        add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },

    },
},
}



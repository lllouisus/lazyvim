return {
    "lfv89/vim-interestingwords",
    config = function ()
        vim.g.interestingWordsRandomiseColors = 1
        vim.g.interestingWordsGUIColors = { '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF' }

        -- vim.keymap.set( 'n', '<leader>k', ":call InterestingWords('n')<cr>", {silent = true, noremap = true} )
        -- vim.keymap.set( 'n', '<leader>K', ":call UncolorAllWords()<cr>", {silent = true, noremap = true} )

        -- vim.keymap.set( 'n', 'n', ":call WordNavigation('forward')<cr>", {silent = true, noremap = true} )
        -- vim.keymap.set( 'n', 'N', ":call WordNavigation('backward')<cr>", {silent = true, noremap = true} )
    end
}





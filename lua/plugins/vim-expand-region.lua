return {
    "terryma/vim-expand-region",
    config = function ()
        vim.keymap.set('v', 'v', '<Plug>(expand_region_expand)', { })
        vim.keymap.set('v', 'V', '<Plug>(expand_region_shrink)', { })
    end
}







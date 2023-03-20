local M = {
    "terryma/vim-expand-region",
}

function M.config()
    vim.keymap.set('v', 'v', '<Plug>(expand_region_expand)', { })
    vim.keymap.set('v', 'V', '<Plug>(expand_region_shrink)', { })
end

return M


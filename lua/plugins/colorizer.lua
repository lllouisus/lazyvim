local M = {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
}

function M.config()
    require 'colorizer'.setup {
        '*'; -- Highlight all files, but customize some others.
    }
end

return M

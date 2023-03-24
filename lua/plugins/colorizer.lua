return {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function ()
        require 'colorizer'.setup {
            '*'; -- Highlight all files, but customize some others.
        }
    end
}


local M = {
    "ur4ltz/surround.nvim",
    event = "BufRead"
}

function M.config()
    require("surround").setup({ mappings_style = "surround" })
end

return M

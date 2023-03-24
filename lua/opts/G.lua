local G = {}

G.g = vim.g
G.b = vim.b
G.o = vim.o
G.v = vim.v
G.fn = vim.fn
G.api = vim.api
G.opt = vim.opt

function G.map(maps)
    for _,map in pairs(maps) do
        G.api.nvim_set_keymap(map[1], map[2], map[3], map[4])
    end
end

return G

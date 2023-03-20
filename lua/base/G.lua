local G = {}

G.p = vim.opt
G.g = vim.g
G.w = vim.wo
G.fn = vim.fn
G.b = vim.bo
G.api = vim.api

function G.map(maps)
	for _,map in pairs(maps) do
		G.api.nvim_set_keymap(map[1], map[2], map[3], map[4])
	end
end

function G.cmd(cmd)
    G.api.nvim_command(cmd)
end

return G

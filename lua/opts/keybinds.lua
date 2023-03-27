local G = require"opts.G"

-- local G = require"opts.G"

 -- Nop Map
 G.map({
 {'n', 's', '<NOP>', {} },

 --General
 {'i', 'jk', '<Esc>', {} },
 {'n', 'Q', ':q<CR>', {} },
 {'n', 'T', ':qa!<CR>', {} },
 {'n', 'S', '&buftype == "acwrite" ? ":W<CR>" : ":w!<CR>"', { noremap = true, silent = true, expr = true} },
 {'n', ';', ':', {} },
 {'v', ';', ':', {} },

 {'i', '<C-e>', '<Enter>', {} },
 {'n', '<C-e>', '<Enter>', {} },
 {'i', '<C-d>', '<BackSpace>', {} },

 {'n', '+', '<C-a>', {} },
 {'n', '-', '<C-x>', {} },

 -- Command
 {'c', '<C-e>', '<Enter>', { noremap = true} },
 {'c', '<C-d>', '<BackSpace>', { noremap = true} },
 {'c', '<C-k>', '<C-p>', { noremap = true} },
 {'c', '<C-j>', '<C-n>', { noremap = true} },
 {'c', '<C-h>', '<Left>', { noremap = true} },
 {'c', '<C-l>', '<Right>', { noremap = true} },

 -- ctrl shift + move
 { 'i', '<C-k>', '<Up>', { noremap = true, silent = true} },
 { 'i', '<C-j>', '<Down>', { noremap = true, silent = true} },
 { 'i', '<C-h>', '<Left>', { noremap = true, silent = true} },
 { 'i', '<C-l>', '<Right>', { noremap = true, silent = true} },
 { 'n', '<C-k>', '<Up>', { noremap = true, silent = true} },
 { 'n', '<C-j>', '<Down>', { noremap = true, silent = true} },

 { 'n', '<C-k>', '6k', { noremap = true} },
 { 'n', '<C-j>', '6j', { noremap = true} },
 { 'v', '<C-k>', '6k', { noremap = true} },
 { 'v', '<C-j>', '6j', { noremap = true} },

 { 'n', 'H', '^', { noremap = true} },
 { 'n', 'L', '$', { noremap = true} },
 { 'v', 'H', '^', { noremap = true} },
 { 'v', 'L', '$', { noremap = true} },
 { 'v', 'q', '<ESC>', { noremap = true} },
 { 'n', 'va', 'gg<S-v>G', { noremap = true} },
 { 'n', '<Space><Enter>', ':nohlsearch<CR>', { noremap = true} },

 -- lazy & startuptime
 { 'n', '<Leader>fa', ':StartupTime<CR>', { noremap = true} },
 { 'n', '<Leader>fs', ':Lazy<CR>', { noremap = true} },

 { 'v', 'Y', '+y', { noremap = true} },
 { 'v', 'P', '+p', { noremap = true} },
 { 'n', 'P', '+p', { noremap = true} },
 { 'v', 'cu', '+d', { noremap = true} },
 { 'n', 'cuw', '+diw', { noremap = true} },
 { 'n', 'YY', '+YY', { noremap = true} },

 { 'n', 'x', '"_x', { noremap = true} },
 { 'v', 'x', '"_x', { noremap = true} },
 { 'n', 'dw', 'vb"_d', { noremap = true} },

 -- neotree
 { 'n', 'tt', ':NeoTreeFloat<CR>', {} },

 -- window move & resize
 -- { 'n', 'sv', ':vsplit<CR><C-w>w', { noremap = true} },
 -- { 'n', 'ss', ':split<CR><C-w>w', { noremap = true} },
 { 'n', 'sv', ':vsplit<CR>', { noremap = true} },
 { 'n', 'ss', ':split<CR>', { noremap = true} },
 { 'n', 'to', ':only<CR>', { noremap = true} },
 { 'n', '<C-Left>', ':vertical resize +2<CR>', { noremap = true} },
 { 'n', '<C-Right>', ':vertical resize -2<CR>', { noremap = true} },

 { 'n', 'th', '<C-w>h', { noremap = true} },
 { 'n', 'tl', '<C-w>l', { noremap = true} },
 { 'n', 'tj', '<C-w>j', { noremap = true} },
 { 'n', 'tk', '<C-w>k', { noremap = true} },

 -- buffers
 { 'n', 'sn', ':tabedit<CR>', { noremap = true, silent = true} },

 { 'n', '<Leader>d', ':bd!<CR>', { noremap = true, silent = true} },
 { 'n', '<A-Left>', ':bp<CR>', { noremap = true, silent = true} },
 { 'n', '<A-Right>', ':bp<CR>', { noremap = true, silent = true} },
 { 'i', '<A-Left>', ':bp<CR>', { noremap = true, silent = true} },
 { 'i', '<A-Right>', ':bp<CR>', { noremap = true, silent = true} },

 -- visual move
 { 'v', '<S-Tab>', '<gv', { noremap = true } },
 { 'v', '<Tab>', '>gv', { noremap = true } },

 -- translate
 { 'n', 'te', ':TranslateW<CR>', { noremap = true } },
 { 'v', 'te', ':TranslateW<CR>', { noremap = true } },

 -- C-s = :%s/
 { 'n', '<C-s>', ':<C-u>%s/\\v//gc<Left><Left><Left><Left>', { noremap = true } },
 { 'v', '<C-s>', ':%s/\\v//gc<Left><Left><Left><Left>', { noremap = true } },

 })

-- 重设tab长度

-- 光标在$ 0 ^依次跳转
-- function MagicMove()
    -- local first = 1
    -- local head = #G.fn.getline('.') - #G.fn.substitute(G.fn.getline('.'), '^\\s*', '', 'G') + 1
    -- local before = G.fn.col('.')
    -- G.fn.execute(before == first and first ~= head and 'norm! ^' or 'norm! $')
    -- local after = G.fn.col('.')
    -- if before == after then
        -- G.fn.execute('norm! 0')
    -- end
-- end

-- 驼峰转换
function MagicToggleHump(upperCase)
    G.fn.execute('normal! gv"tx')
    local w = G.fn.getreg('t')
    local toHump = w:find('_') ~= nil
    if toHump then
        w = w:gsub('_(%w)', function(c) return c:upper() end)
    else
        w = w:gsub('(%u)', function(c) return '_' .. c:lower() end)
    end
    if w:sub(1, 1) == '_' then w = w:sub(2) end
    if upperCase then w = w:sub(1,1):upper() .. w:sub(2) end
    G.fn.setreg('t', w)
    G.fn.execute('normal! "tP')
end




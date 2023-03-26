-- 取消换行注释
-- 用o换行不要延续注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    -- vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    vim.opt.formatoptions = vim.opt.formatoptions
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
  end,
})

-- vim.cmd([[au BufEnter * if &buftype == '' && &readonly == 1 | set buftype=acwrite | set noreadonly | endif]])

-- 重新打开缓冲区恢复光标位置
vim.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])
-- vim.api.nvim_create_autocmd("BufReadPost", {
--     pattern = "*",
--     callback = function()
--         if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
--             vim.fn.setpos(".", vim.fn.getpos("'\""))
--             vim.cmd([[silent! foldopen]])
--         end
--     end,
-- })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank {
      higroup = "Search",
      timeout = 200
    }
  end,
  pattern = "*",
})

-- 自动保存/加载view
-- vim.cmd([[
    -- au FileType * try | silent! loadview | catch | endtry
    -- au BufLeave,BufWinLeave * silent! mkview
-- ]])


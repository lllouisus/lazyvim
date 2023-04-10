vim.cmd.colorscheme "mine"

vim.cmd("autocmd!")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- fix for yankring and neovim clipboard error target string not available
vim.cmd([[
let g:clipboard = {
      \   'name': 'xsel_override',
      \   'copy': {
      \      '+': 'xsel --input --clipboard',
      \      '*': 'xsel --input --primary',
      \    },
      \   'paste': {
      \      '+': 'xsel --output --clipboard',
      \      '*': 'xsel --output --primary',
      \   },
      \   'cache_enabled': 1,
      \ }
]])


-- UTF-8
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

opt.number = true -- Print line number
opt.numberwidth = 2
opt.relativenumber = true -- Relative line numbers
opt.title = true
opt.autoindent = true
opt.smartindent = true -- Insert indents automatically
opt.tabstop = 2 -- Number of spaces tabs count for
opt.softtabstop = 2
opt.shiftwidth = 2 -- Size of an indent
opt.smarttab = true
opt.expandtab = true -- Use spaces instead of tabs
opt.backup = false
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 0
opt.scrolloff = 6 -- Lines of context
-- opt.sidescrolloff = 8 -- Columns of context
opt.shell = "zsh"
opt.backupskip = { '/tmp/*', '/private/tmp/*' }
opt.inccommand = "split" -- 替换的时候下方有实时行数以及替换
opt.ignorecase = true -- Ignore case
opt.breakindent = true
opt.wrap = false -- Disable line wrap
opt.backspace = { 'start', 'eol', 'indent' }
opt.path:append { '**' } -- Finding files - Search down into subfolders
opt.wildignore:append { '*/node_modules/*' }

-- Clipboard
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- opt.clipboard = 'unnamed,unnamedplus'

-- Search
opt.hlsearch = true
opt.showmatch = true
opt.incsearch = true

opt.smartcase = true -- Don't ignore case with capitals
opt.timeoutlen = 300


opt.completeopt = "menu,menuone,noselect"
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line

opt.mouse = "" -- Enable mouse mode

opt.vb = true
opt.hidden = true
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv('HOME') .. '/.config/nvim/cache/undodir'
opt.undolevels = 10000
opt.viminfo = "!,'10000,<50,s10,h"
opt.foldenable = true
opt.foldmethod = 'manual'
opt.viewdir = os.getenv('HOME') .. '/.config/nvim/cache/viewdir'
opt.foldtext = 'v:lua.MagicFoldText()'
opt.updatetime = 250 -- Save swap file and trigger CursorHold
opt.shortmess:append { W = true, I = true, c = true }

-- opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append { C = true }
end

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = '*',
    command = "set nopaste"
})


-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0


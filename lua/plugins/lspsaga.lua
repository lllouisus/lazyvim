return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    --Please make sure you install markdown and markdown_inline parser
    { "nvim-treesitter/nvim-treesitter" }
  },
  config = function()
    require("lspsaga").setup({
      ui = {
        -- This option only works in Neovim 0.9
        winblend = 10,
        border = "rounded",
        code_action = "💡",
        colors = {
          normal_bg = '#002b36'
        }
      },
    })

    local opts = { noremap = true, silent = true }
    -- vim.keymap.set('n', 'sj', '<Cmd>Lspsaga lsp_finder<CR>', opts)
    vim.keymap.set('n', 'ff', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    vim.keymap.set('n', 'FF', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
    vim.keymap.set('n', 'se', '<Cmd>Lspsaga peek_definition<CR>', opts)
    vim.keymap.set('n', 'si', '<Cmd>Lspsaga hover_doc<CR>', opts)
    -- vim.keymap.set('n', 'sh', '<Cmd>Lspsaga preview_definition<CR>', opts)

    vim.keymap.set('n', 'sn', '<Cmd>Lspsaga lsp_finder<CR>', opts)
    -- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
    -- vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- vim.keymap.set('n', '<Leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
  end,
}

return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "jay-babu/mason-null-ls.nvim",
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting

    local sources = {
      formatting.eslint,
      formatting.autopep8,
      formatting.stylua,
      -- formatting.spell
    }

    null_ls.setup({
      sources = sources
    })


    -- keymap
    vim.keymap.set('n', '<Leader>f', ':lua vim.lsp.buf.format()<CR>', {})
  end,
}

return {
    "ibhagwan/fzf-lua",
    event = {"BufReadPost", "BufNewFile", "CursorHold"},
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        vim.keymap.set("n", "sa", ":lua require('fzf-lua').files({ cwd = '~/.config' })<CR>", {} )
        vim.keymap.set("n", "sf", ":lua require'fzf-lua'.files({ prompt=\"LS> \", cmd = \"ls\", cwd=\"~/<folder>\" })<CR>", {} )
        vim.keymap.set("n", "sh", ":FzfLua help_tags<CR>", {} )
        vim.keymap.set("n", "sg", ":FzfLua git_files<CR>", {} )
        vim.keymap.set("n", "so", ":FzfLua oldfiles<CR>", {} )
        vim.keymap.set("n", "sb", ":FzfLua buffers<CR>", {} )
        vim.keymap.set("n", "sm", ":FzfLua builtin<CR>", {} )
        vim.keymap.set("n", "sl", ":FzfLua lsp_document_symbols<CR>", {} )
        -- vim.keymap.set("n", "sw", ":lua require('fzf-lua).live_grep()<CR>", {} )
        vim.keymap.set("n", "sw", ":FzfLua live_grep<CR>", {} )

        local actions = require'fzf-lua.actions'
        require 'fzf-lua'.setup({
          winopts = {
            on_create = function()
              vim.api.nvim_buf_set_keymap(0, 't', '<C-n>', '<DOWN>',
              {nowait = true, noremap = true})
              vim.api.nvim_buf_set_keymap(0, 't', '<C-o>', '<UP>',
              {nowait = true, noremap = true})
              vim.api.nvim_buf_set_keymap(0, 't', '<C-e>', '<Enter>',
              {nowait = true, noremap = true})
            end
          },

          actions = {
            files = {
              -- instead of the default action 'actions.file_edit_or_qf'
              -- it's important to define all other actions here as this
              -- table does not get merged with the global defaults
              ["default"]       = actions.file_edit,
              ["ctrl-s"]        = actions.file_split,
              ["ctrl-v"]        = actions.file_vsplit,
              ["ctrl-t"]        = actions.file_tabedit,
              ["alt-q"]         = actions.file_sel_to_qf,
            }
          }
        })
    end
}


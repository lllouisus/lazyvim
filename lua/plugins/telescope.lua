local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-lua/popup.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim" },
        { "nvim-telescope/telescope-live-grep-args.nvim" }
    },
    keys = {
        { "sf", ":lua require(\'telescope.builtin\').find_files({cwd = \'~/.config\',layout_strategy=\'center\',layout_config={width=0.4, height=0.6}})<CR>", "n", { noremap = true, silent = true } },
        { "sl", ":lua require(\'telescope.builtin\').find_files({layout_strategy=\'center\',layout_config={width=0.4, height=0.6}})<CR>", "n", { noremap = true, silent = true } },
        { "sb", ":Telescope buffers<CR>", "n", { noremap = true, silent = true } },
        { "sm", ":lua require(\'telescope.builtin\').builtin({layout_strategy=\'center\',layout_config={width=0.3, height=0.4}})<CR>", "n", { noremap = true, silent = true } },
        { "sh", ":Telescope help_tags<CR>", "n", { noremap = true, silent = true } },
        { "sw", ":lua require(\'telescope\').extensions.live_grep_args.live_grep_args()<CR>", "n", { noremap = true, silent = true } },
        { "so", ":lua require(\'telescope.builtin\').oldfiles({layout_strategy=\'center\',layout_config={width=0.4, height=0.6}})<CR>", "n", { noremap = true, silent = true } },
        { "<leader>l", ":Telescope lsp_document_symbols<CR>", "n", { noremap = true, silent = true } },
        { "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>", "n", { noremap = true, silent = true } },
    },
}

function M.config()
    local status, actions = pcall(require, "telescope.actions")
    if (not status) then
        return
    end

    local Gmap = vim.keymap

    -- disable preview binaries
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")
    local new_maker = function(filepath, bufnr, opts)
        filepath = vim.fn.expand(filepath)
        Job:new({
            command = "file",
            args = { "--mime-type", "-b", filepath },
            on_exit = function(j)
                local mime_type = vim.split(j:result()[1], "/")[1]
                if mime_type == "text" then
                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                else
                    -- maybe we want to write something to the buffer here
                    vim.schedule(function()
                        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                    end)
                end
            end
        }):sync()
    end

    require("telescope").setup({
        defaults = {
            vimgrep_arguments = {
                "rg",
                "-L",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            prompt_prefix = "   ", --   
            selection_caret = "> ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.60,
                height = 0.75,
                preview_cutoff = 120,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = { "node_modules" },
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = { "truncate" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            mappings = {
                n = {
                    ["q"] = actions.close,
                    ["l"] = actions.file_edit,
                },
                i = {
                    ["<C-l>"] = false,
                },
            },
        },
        pickers = {
            find_files = {
                hidden = true,
                theme = "dropdown",
                previewer = false,
                find_command = { "fd", "-H" , "-I"},  -- "-H" search hidden files, "-I" do not respect to gitignore
            }
        },
        ["ui-select"] = {
            require('telescope.themes').get_dropdown {

            }
        },
        live_grep_raw = {
            auto_quoting = false, -- enable/disable auto-quoting
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        }
    })
end

return M

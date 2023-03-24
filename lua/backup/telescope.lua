return {
  'nvim-telescope/telescope.nvim',
  event = "CursorHold",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-file-browser.nvim'
  },
  config = function ()
    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- See `:help telescope.builtin`
    -- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    -- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    -- vim.keymap.set('n', '<leader>/', function()

    --   -- You can pass additional configuration to telescope to change theme, layout, etc.
    --   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    --     winblend = 10,
    --     previewer = false,
    --   })
    -- end, { desc = '[/] Fuzzily search in current buffer' })

    -- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    -- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    -- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    -- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    -- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

    vim.keymap.set("n", "sf", ":lua require(\'telescope.builtin\').find_files({cwd = \'~/.config\',layout_strategy=\'center\',layout_config={width=0.4, height=0.6}})<CR>",  { noremap = true, silent = true } )
    vim.keymap.set("n", "sl", ":lua require(\'telescope.builtin\').find_files({layout_strategy=\'center\',layout_config={width=0.4, height=0.6}})<CR>",  { noremap = true, silent = true } )
    vim.keymap.set("n", "sb", ":Telescope buffers<CR>",  { noremap = true, silent = true } )
    vim.keymap.set("n", "sm", ":lua require(\'telescope.builtin\').builtin({layout_strategy=\'center\',layout_config={width=0.3, height=0.4}})<CR>",  { noremap = true, silent = true } )
    vim.keymap.set("n", "sh", ":Telescope help_tags<CR>",  { noremap = true, silent = true } )
    vim.keymap.set("n", "sw", ":lua require(\'telescope\').extensions.live_grep_args.live_grep_args()<CR>",  { noremap = true, silent = true } )
    vim.keymap.set("n", "so", ":lua require(\'telescope.builtin\').oldfiles({layout_strategy=\'center\',layout_config={width=0.4, height=0.6}})<CR>",  { noremap = true, silent = true } )
    vim.keymap.set("n", "<leader>l", ":Telescope lsp_document_symbols<CR>",  { noremap = true, silent = true } )
    vim.keymap.set("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>",  { noremap = true, silent = true } )

    local status, actions = pcall(require, "telescope.actions")
    if (not status) then
      return
    end


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

  end,

}


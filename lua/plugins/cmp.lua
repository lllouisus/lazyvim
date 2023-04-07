return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = { 
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'onsails/lspkind.nvim',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'jose-elias-alvarez/null-ls.nvim',
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      config = function ()
        require("luasnip").setup({
          region_check_events = "CursorHold,InsertLeave",
          delete_check_events = "TextChanged,InsertEnter",
        })
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
      end
    }
  },
  config = function()
    -- import nvim-cmp plugin safely
    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp_status then
      return
    end

    -- import luasnip plugin safely
    local luasnip_status, luasnip = pcall(require, "luasnip")
    if not luasnip_status then
      return
    end

    -- import lspkind plugin safely
    local lspkind_status, lspkind = pcall(require, "lspkind")
    if not lspkind_status then
      return
    end
    vim.opt.completeopt = "menu,menuone,noselect"

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<A-i>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),  -- previous suggestion
        ['<A-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),  -- next suggestion
        -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- Jump to the next placeholder in the snippet.
        ['<C-f>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, {'i', 's'}),
        -- Jump to the previous placeholder in the snippet.
        ['<C-b>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {'i', 's'}),
        -- ["<C-p>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-q>"] = cmp.mapping.abort(),  -- close completion window
        ['<C-e>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          local col = vim.fn.col('.') - 1

          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
          else
            cmp.complete()
          end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(select_opts)
          else
            fallback()
          end
        end, {'i', 's'}),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 1 }, -- lsp
        { name = "luasnip", keyword_length = 1 }, -- snippets
        { name = "buffer", keyword_length = 2 }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
      -- configure lspkind for vs-code like icons
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          mode = "symbol",
          ellipsis_char = "...",
          menu = ({
            buffer = "(Text)",
            nvim_lsp = "(LSP)",
            nvim_lua = "(Lua)",
            treesitter = "(TS)",
            emoji = "(Emoji)",
            path = "(Path)",
            calc = "(Calc)",
            cmp_tabnine = "(Tabnine)",
            luasnip = "(Snippet)",
            spell = "(Spell)",
          })
        }),
      },
    })

    -- Set configuration for specific filetype.
    -- cmp.setup.filetype('gitcommit', {
    --   sources = cmp.config.sources({
    --     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    --   }, {
    --     { name = 'buffer' },
    --   })
    -- })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end
}

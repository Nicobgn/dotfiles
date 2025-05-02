return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- solo cargar en archivos lua
    opts = {
      library = {
        -- Cargar los tipos de luvit cuando se encuentra la palabra `vim.uv`
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    opts = function(_, opts)
      local cmp = require('cmp')

      cmp.setup({
        -- enabled = function ()
        --   return require('util.cmp').is_enabled()
        -- end,
        preselect = cmp.PreselectMode.item,
        keyword_length = 2,
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        view = {
          entries = {
            name = "custom",
            selection_order = "near_cursor",
            follow_cursor = true
          }
        },
        mapping = {
          ["<C-CR>"] = cmp.mapping(
            cmp.mapping.confirm({
              select = true,
              behavior = cmp.ConfirmBehavior.Insert,
            }),
            { "i", "c" }
          ),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-5),
          ["<C-f>"] = cmp.mapping.scroll_docs(5),
          ["<C-q>"] = cmp.mapping.abort()
        },
        sources = cmp.config.sources({
          {
            name = "luasnip",
            group_index = 1,
            option = { use_show_condition = true },
            entry_filter = function()
              local context = require("cmp.config.context")
              return not context.in_treesitter_capture("string")
                and not context.in_syntax_group("String")
            end,
          },
          {
            name = "nvim_lsp",
            group_index = 2,
          },
          {
            name = "nvim_lua",
            group_index = 3,
          },
          {
            name = "path",
            keyword_length = 4,
            group_index = 4,
          },
          {
            name = "buffer",
            keyword_length = 3,
            group_index = 5,
            option = {
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
          {
            name = "lazydev",
            keyword_length = 2,
            group_index = 0,
          },
        }),
        ---@diagnostic disable-next-line: missing-fields
        -- formatting = {
        --   format = lspkind.cmp_format({
        --     mode = "symbol_text",
        --     ellipsis_char = "...",
        --     before = function(entry, item)
        --       cmp_tailwind.format(entry, item)
        --       return item
        --     end,
        --     menu = source_mapping,
        --   }),
        -- },
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Asignación de teclas para la navegación y confirmación
      -- Fuentes de completado
      -- opts.sources = opts.sources or {}
      -- table.insert(opts.sources, {
      --   name = "lazydev",
      --   group_index = 0,
      -- })
    end,
  },

  { -- Fuente opcional de completado para `require` y anotaciones de módulos
    "saghen/blink.cmp",
    dependencies = { 'rafamadriz/friendly-snippets', 'hrsh7th/nvim-cmp' },
    version = '1.*',
    build = "cargo build --release",
    opts = {
      keymap = { preset = 'default' },
      completion = { documentation = { auto_show = false } },
      sources = {
        -- Añadir `lazydev` a los proveedores de completado
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- Hacer que las sugerencias de `lazydev` tengan mayor prioridad
            score_offset = 100,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust" } -- preferir rust con advertencia
    },
  },
}


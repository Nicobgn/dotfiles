-- ~/.config/nvim/lua/plugins/autocomplete.lua

return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    opts = function (_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0,
      })
    end
    -- config = function(_, opts)
      -- local cmp = require('cmp')
      -- cmp.setup({
      --   snippet = {
      --     expand = function(args)
      --       require('luasnip').lsp_expand(args.body)
      --     end,
      --   },
      --   mapping = cmp.mapping.preset.insert({
      --     ['<C-Space>'] = cmp.mapping.complete(),
      --     ['<CR>'] = cmp.mapping.confirm({ select = true }),
      --     ['<C-e>'] = cmp.mapping.close(),
      --   }),
      --   sources = cmp.config.sources({
      --     { name = 'nvim_lsp' },
      --     { name = 'luasnip' },
      --     { name = 'buffer' },
      --   }),
      -- })
    -- end,
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    dependencies = { 'rafamadriz/friendly-snippets', 'hrsh7th/nvim-cmp' },
    version = '1.*',
    build = "cargo build --release",
    opts = {
      keymap = { preset = 'default' },
      completion = { documentation = { auto_show = false } },
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust" } -- prefer_rust_with_warning
    },
  }
}


return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    {
      'windwp/nvim-ts-autotag',
      config = function ()
        require('nvim-ts-autotag').setup({
          opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = true,
          },
        })
      end
    },
  },
  config = function()
    local ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
    if not ok then
      return
    end

    -- Some LSP hover previews can request "Markdown" (capitalized).
    pcall(vim.treesitter.language.register, 'markdown', 'Markdown')

    local parsers = {
      'lua', 'rust', 'python', 'go', 'gomod',
      'typescript', 'javascript', 'tsx', 'jsx',
      'html', 'css', 'scss',
      'json', 'yaml', 'sql', 'toml', 'properties',
      'nginx',
      'hyprlang',
      'bash', 'markdown', 'markdown_inline',
      'vim', 'vimdoc', 'query',
      'dockerfile',
    }

    ts_configs.setup({
      ensure_installed = parsers,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    })
  end
}


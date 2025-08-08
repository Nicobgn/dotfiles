return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    {
      'windwp/nvim-ts-autotag',
      config = function ()
        require('nvim-ts-autotag').setup({
          opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = true
          }
        })
      end
    },
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'lua', 'rust', 'python', 'go', 'gomod',
        'typescript', 'javascript',
        'html', 'css', 'scss',
        'json', 'sql', 'toml', 'properties',
        'nginx',
        'hyprlang',
        'dockerfile',
      },
      highlight = { enable = true },
      autotag = { enable = true },
    })
  end
}


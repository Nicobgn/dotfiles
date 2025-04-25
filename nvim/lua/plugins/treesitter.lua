-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 
          'rust', 'lua', 
          'typescript', 'javascript', 'tsx', 'html', 'css', 'scss', 
          'dockerfile', 'go', 'gomod', 'sql',
          
          'json', 'toml',
          'hyprlang', 'properties', 'nginx',
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}


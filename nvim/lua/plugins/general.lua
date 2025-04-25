-- ~/.config/nvim/lua/plugins.lua

return {
  'folke/lazy.nvim', -- Gestor de plugins Lazy.nvim

  -- Complementos recomendados para una experiencia completa
  'nvim-lua/plenary.nvim', -- Utilidades para otros plugins

  -- Árbol de archivos
  'nvim-tree/nvim-tree.lua',
  
  -- Resaltado de sintaxis
  'nvim-treesitter/nvim-treesitter',
  
  -- Barra de estado
  'nvim-lualine/lualine.nvim',
  
  -- Buscador interactivo
  'nvim-telescope/telescope.nvim',
  
  -- Integración con Git
  'lewis6991/gitsigns.nvim',
  
  -- Autocompletado
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'saadparwaiz1/cmp_luasnip',
  'L3MON4D3/LuaSnip',
  
  -- LSP
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim', -- Herramientas para gestionar los servidores LSP

  -- Tema
  'shaunsingh/nord.nvim',
  -- {
  --   config = function()
  --     local startify = require("alpha.themes.dashboard")
  --     -- available: devicons, mini, default is mini
  --     -- if provider not loaded and enabled is true, it will try to use another provider
  --     startify.file_icons.provider = "devicons"
  --     require("alpha").setup(
  --       require'alpha.themes.dashboard'.config,
  --       startify.config
  --     )
  --   end,
  -- },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {
      enabled = function(bufnr) return true end, -- control if auto-pairs should be enabled when attaching to a buffer
      disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
      disable_in_macro = true, -- disable when recording or executing a macro
      disable_in_visualblock = false, -- disable when insert after visual block mode
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true, -- add bracket pairs after quote
      enable_check_bracket_line = true, --- check bracket in same line
      enable_bracket_in_quote = true, --
      enable_abbr = false, -- trigger abbreviation
      break_undo = true, -- switch for basic rule break undo sequence
      check_ts = false,
      map_cr = true,
      map_bs = true, -- map the <BS> key
      map_c_h = false, -- Map the <C-h> key to delete a pair
      map_c_w = false, -- map <c-w> to delete a pair if possible
    }
  }
}


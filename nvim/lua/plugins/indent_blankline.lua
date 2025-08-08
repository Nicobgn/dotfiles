local highlight = {
    "PastelPink",
    "PastelPeach",
    "PastelLightBlue",
    "PastelLightOrange",
    "PastelLightGreen",
    "PastelLavender",
    "PastelTeal",
}


return {
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
    main = "ibl",
    opts = {},
    config = function(_, opts)
      local ibl = require('ibl')
      local hooks = require("ibl.hooks")


      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "PastelPink",      { fg = "#f4bcc4" })
        vim.api.nvim_set_hl(0, "PastelPeach",     { fg = "#f6c89f" })
        vim.api.nvim_set_hl(0, "PastelLightBlue", { fg = "#a8d0e6" })
        vim.api.nvim_set_hl(0, "PastelLightOrange",{ fg = "#ffcb9a" })
        vim.api.nvim_set_hl(0, "PastelLightGreen",{ fg = "#b8e2c8" })
        vim.api.nvim_set_hl(0, "PastelLavender",  { fg = "#d6c6e1" })
        vim.api.nvim_set_hl(0, "PastelTeal",      { fg = "#ade8f4" })
      end)
      -- Configura indent-blankline con los colores
      vim.g.rainbow_delimiters = { highlight = highlight }
      ibl.setup({ scope = { highlight = highlight } })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
  },
  -- {
  --   "HiPhish/rainbow-delimiters.nvim",
  --   config = function()
  --     -- Configura rainbow-delimiters de la manera correcta
  --     -- local rainbow_delimiters = require('rainbow-delimiters')
  --     --
  --     -- vim.g.rainbow_delimiters = {
  --     --   strategy = {
  --     --     [''] = rainbow_delimiters.strategy['global'],
  --     --     vim = rainbow_delimiters.strategy['local'],
  --     --   },
  --     --   query = {
  --     --     [''] = 'rainbow-delimiters',
  --     --     lua = 'rainbow-blocks',
  --     --   },
  --     --   highlight = highlight, -- Usamos los mismos colores
  --     -- }
  --   end
  -- }
}


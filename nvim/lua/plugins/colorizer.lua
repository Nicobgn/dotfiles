return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup({
        '*', -- habilita para todos los filetypes
        css = { css = true; css_fn = true; },
        html = { names = true; },
      }, {
        mode = 'background' -- Opcional: default 'foreground'
      })
    end
  }
}


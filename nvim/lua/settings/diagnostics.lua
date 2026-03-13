vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- iconito delante de cada error
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false, -- no actualizar mientras escribís
  severity_sort = true, -- ordenar por gravedad
})

-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, {
--       focusable = false, -- no roba el foco
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = "rounded", -- bordes lindos
--       source = "always", -- mostrar el origen del error
--       prefix = " ",
--       scope = "cursor",
--     })
--   end
-- })


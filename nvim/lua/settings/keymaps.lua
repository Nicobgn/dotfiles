-- ~/.config/nvim/lua/settings/keymaps.lua
vim.g.mapleader = " "

-- Mover entre ventanas
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Guardar archivo
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- Búsqueda incremental
vim.api.nvim_set_keymap('n', '<C-f>', '/<C-r><C-w><CR>', { noremap = true, silent = true })


-- NvimTree
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true})

-- NOTE: ERRORES

-- Mostrar el diagnóstico flotante en la posición del cursor
vim.keymap.set('n', '<Space>te', function()
  vim.diagnostic.open_float(nil, {
    focusable = true,
    border = "rounded",
    source = "always",
    prefix = " ",
    scope = "cursor",
  })
end, { desc = "Mostrar errores flotantes" })

-- Saltar al siguiente error
vim.keymap.set('n', '<Space>tn', function()
  vim.diagnostic.goto_next({
    severity = vim.diagnostic.severity.ERROR,
  })
end, { desc = "Ir al siguiente error" })

-- Saltar al error anterior
vim.keymap.set('n', '<Space>tp', function()
  vim.diagnostic.goto_prev({
    severity = vim.diagnostic.severity.ERROR,
  })
end, { desc = "Ir al error anterior" })

-- Ver todos los diagnósticos en línea (abrir la lista completa)
vim.keymap.set('n', '<Space>tl', function()
  vim.diagnostic.setqflist()
  vim.cmd('lopen')
end, { desc = "Ver todos los diagnósticos en la lista" })


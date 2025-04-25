-- ~/.config/nvim/lua/settings/options.lua

-- Habilitar números de línea relativos
vim.opt.relativenumber = true
vim.opt.number = true

-- Configuración de la indentación
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Habilitar resaltado de búsqueda
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Mostrar los resultados de búsqueda mientras escribimos
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configuración de autocompletado de archivos
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest'

-- Mostrar lineas de estado
vim.opt.laststatus = 2

-- Habilitar la interfaz de usuario 24 bits de color
vim.opt.termguicolors = true

-- Número de líneas de la ventana
vim.opt.scrolloff = 8

-- Habilitar la actualización automática de archivos cuando se cambian
vim.opt.autoread = true

-- Habilitar el ratón
-- vim.opt.mouse = 'a'

-- Configuración de la codificación
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Deshabilitar la creación de archivo swap
vim.opt.swapfile = false

-- Deshabilitar el backup de archivos
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.clipboard = "unnamedplus"

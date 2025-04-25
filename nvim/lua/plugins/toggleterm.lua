return {
  {
    'akinsho/toggleterm.nvim', 
    version = "*",
    opts = {
      close_on_exit = true,
      autochdir = true,
      hide_numbers = true,
      auto_scroll = true,
      -- shell = vim.o.shell,
      -- cmd = "zsh", -- Puedes cambiarlo por otra shell si lo deseas
      float_opts = {
        border = 'curved',
        title_pos = 'center',
        width = 200,
        height = 150,
      }
    },
    config = function ()
      local Terminal = require('toggleterm.terminal').Terminal

      -- Tabla para almacenar las terminales
      local terminals = {
        server = Terminal:new({
          direction = "horizontal",
          -- close_on_exit = false,
          on_open = function(term)
            vim.api.nvim_buf_set_name(term.bufnr, "Server")
          end
        }),
        
        vertical = Terminal:new({ 
          direction = "vertical" 
        }),
        
        float = Terminal:new({ 
          direction = "float" 
        }),
      }

      -- Bindings de teclas
      vim.api.nvim_set_keymap("n", "<A-1>", "<cmd>lua require'toggleterm_config'.terminals.server:toggle()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<A-2>", "<cmd>lua require'toggleterm_config'.terminals.vertical:toggle()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<A-3>", "<cmd>lua require'toggleterm_config'.terminals.float:toggle()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("t", "<A-1>", "<cmd>lua require'toggleterm_config'.terminals.server:toggle()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("t", "<A-1>", "<cmd>lua require'toggleterm_config'.terminals.vertical:toggle()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("t", "<A-1>", "<cmd>lua require'toggleterm_config'.terminals.float:toggle()<CR>", { noremap = true, silent = true })

      -- Exportar la tabla de terminales para que los mappings puedan acceder a ella
      package.loaded.toggleterm_config = { terminals = terminals }    
    end
  },
}


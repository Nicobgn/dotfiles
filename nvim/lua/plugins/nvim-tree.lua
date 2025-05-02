-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'ahmedkhalf/project.nvim' },
    config = function()
      require('nvim-tree').setup({
        -- sync_root_with_cwd = true,
        -- respect_buf_cwd = true,
        -- update_focused_file = {
          -- enable = true,
          -- update_root = true
        -- }
        -- auto_close = true,
        open_on_tab = false,
        update_cwd = true,
        view = {
          width = 25,
          side = 'left',
          -- auto_resize = true,
        },
      })

      -- vim.api.nvim_set_var('nvim_tree_open_on_setup', 1)
      -- vim.api.nvim_set_var('nvim_tree_split', 1)
    end,
  }
}


-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'ahmedkhalf/project.nvim' },
    config = function()
      require('nvim-tree').setup({
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        view = {
          width = 25,
          side = 'left',
        },
      })

      vim.api.nvim_set_var('nvim_tree_open_on_setup', 1)
      vim.api.nvim_set_var('nvim_tree_split', 1)
    end,
  }
}


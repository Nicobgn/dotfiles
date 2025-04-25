return {
  'williamboman/mason.nvim',
  dependencies = { 'williamboman/mason-lspconfig.nvim' },
  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')

    mason.setup({
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        }
      }
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "cssls",
        "tailwindcss",
        "emmet_ls",
        "bashls",
        "docker_compose_language_service",
        "dockerls",
        "gopls",
        "eslint",
        -- "rome",
        "jsonls",
        "sqls",
        "rust_analyzer",
        "lua_ls"
      }
    })
  end
}

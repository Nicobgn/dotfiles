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
      },
      ensure_installed = { -- SOLO paquetes (binaries)
        "typescript-language-server",
        "typescript",
        "rust-analyzer",
        "html",
        "css-lsp",
        -- otros binarios que quieras
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
        "jsonls",
        "sqls",
        "rust_analyzer",
        "lua_ls",
        -- NO pongas tsserver acá
      },
      automatic_installation = true, -- opcional
    })

    local lspconfig = require("lspconfig")

    -- tsserver config
    lspconfig.tsserver.setup({
      settings = {
        typescript = {
          completions = {
            completeFunctionCalls = true,
            importModuleSpecifier = 'relative',
          },
        },
        javascript = {
          completions = {
            completeFunctionCalls = true,
            importModuleSpecifier = 'relative',
          },
        },
      },
      on_attach = function(client, bufnr)
        -- extra configs si querés
      end
    })

    -- rust_analyzer config
    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "module",
            importPrefix = "by_self",
          },
          cargo = {
            allFeatures = true,
          },
          procMacro = {
            enable = true,
          },
        }
      }
    })
  end
}


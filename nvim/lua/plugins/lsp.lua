return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'rust_analyzer',
        'ts_ls',
        'eslint',
        'pyright',
        'lua_ls',
        'html',
        'jsonls'
      },
    })

    local lspconfig = require('lspconfig')
    local util = require('lspconfig.util')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local servers = {
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            rustfmt = {
              extraArgs = {}, -- si usás nightly: { "+nightly" }
            }
          }
        }
      },
      ts_ls = {
        root_dir = util.root_pattern("package.json")
      },
      eslint = {},
      pyright = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
          }
        }
      },
      html = {},
      jsonls = {},
    }

    for server, config in pairs(servers) do
      config.capabilities = capabilities

      config.on_attach = function(client, bufnr)
        -- Activa autoformato en archivos Rust
        if client.name == "rust_analyzer" and client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("RustFormatOnSave", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end

      lspconfig[server].setup(config)
    end
  end
}


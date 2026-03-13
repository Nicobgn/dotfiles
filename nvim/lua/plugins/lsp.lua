return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'b0o/SchemaStore.nvim',
  },
  config = function()
    require('mason').setup()
    local mason_lspconfig = require('mason-lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local has_schemastore, schemastore = pcall(require, 'schemastore')

    local function lsp_keymaps(bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<Leader>f', function()
        vim.lsp.buf.format({ async = false })
      end, opts)
    end

    local servers = {
      ts_ls = {
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local root = vim.fs.root(fname, { "package.json", "tsconfig.json", "jsconfig.json", ".git" })
          on_dir(root)
        end,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
      eslint = {},
      pyright = {},
      ruff = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            completion = {
              callSnippet = 'Replace',
            },
          }
        }
      },
      html = {},
      jsonls = {},
      yamlls = {
        settings = {
          yaml = {
            keyOrdering = false,
            schemaStore = {
              enable = false,
              url = '',
            },
            schemas = has_schemastore and schemastore.yaml.schemas() or {},
          },
        },
      },
      bashls = {},
      dockerls = {},
      docker_compose_language_service = {},
    }

    local ensure_installed = vim.tbl_keys(servers)
    table.insert(ensure_installed, 'rust_analyzer')

    mason_lspconfig.setup({
      ensure_installed = ensure_installed,
      automatic_enable = false,
    })

    for server, config in pairs(servers) do
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})

      local custom_on_attach = config.on_attach
      config.on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)

        if client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end

        if custom_on_attach then
          custom_on_attach(client, bufnr)
        end

        local format_on_save_clients = {
          eslint = true,
          ruff = true,
          lua_ls = true,
          jsonls = true,
          yamlls = true,
        }

        if format_on_save_clients[client.name] and client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                async = false,
                bufnr = bufnr,
                filter = function(fmt_client)
                  return fmt_client.id == client.id
                end,
              })
            end,
          })
        end
      end

      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end
}


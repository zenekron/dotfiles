local M = {}

vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        imports = {
          prefix = "self",
          granularity = {
            enforce = true,
          },
        },
      },
    },
  },
}

M.setup = function()
  local lspconfig = require("lspconfig")
  local mason = require("mason-core.package")
  local schemastore = require("schemastore")


  --
  -- Keysbinds
  --

  local kopts = { noremap = true, silent = true }

  -- diagnostics
  vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)
  vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, kopts)
  vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, kopts)
  vim.keymap.set("n", "]g", vim.diagnostic.goto_next, kopts)

  -- docs/info
  vim.keymap.set("n", "K", vim.lsp.buf.hover, kopts)
  vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, kopts)

  -- goto
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, kopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, kopts)
  -- vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, kopts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, kopts)
  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, kopts)

  -- actions
  vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, kopts)
  vim.keymap.set("x", "<leader>ac", vim.lsp.buf.code_action, kopts)
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, kopts)
  vim.keymap.set("x", "<leader>f", vim.lsp.buf.format, kopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, kopts)

  -- workspace
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, kopts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, kopts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, kopts)

  -- symbols
  vim.keymap.set("n", "<leader>o", vim.lsp.buf.document_symbol, kopts)
  vim.keymap.set("n", "<leader>s", vim.lsp.buf.workspace_symbol, kopts)


  -- HACK: https://github.com/neovim/neovim/issues/30985
  for _, method in ipairs { "textDocument/diagnostic", "workspace/diagnostic" } do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
      if err ~= nil and err.code == -32802 then return end
      return default_diagnostic_handler(err, result, context, config)
    end
  end


  --
  -- nvim-cmp
  --

  local has_nvim_cmp = pcall(require, "cmp")
  if has_nvim_cmp then
    local winopts = require("cmp.config.window").bordered()
    local capabilities = vim.tbl_deep_extend("force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    lspconfig.util.default_config = vim.tbl_extend(
      "force",
      lspconfig.util.default_config,
      {
        capabilities = capabilities,
        handlers = {
          ["textDocument/hover"]         = vim.lsp.with(vim.lsp.handlers["textDocument/hover"], winopts),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["textDocument/signatureHelp"], winopts),
          hover                          = vim.lsp.with(vim.lsp.handlers.hover, winopts),
          signature_help                 = vim.lsp.with(vim.lsp.handlers.signature_help, winopts),
        },
      }
    )
  end


  --
  -- servers
  --

  local clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    settings = {
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
    },
  }

  local docker_compose_language_service = {
    root_dir = lspconfig.util.root_pattern(
      "compose.yaml",
      -- defaults
      "docker-compose.yaml"
    ),
  }

  local jsonls = {
    init_options = {
      provideFormatter = false,
    },
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
        validate = { enable = true },
      },
    },
  }

  local lua_ls = {
    root_dir = lspconfig.util.root_pattern(
      "lazy-lock.json",
      -- defaults
      ".git",
      ".luacheckrc",
      ".luarc.json",
      ".luarc.jsonc",
      ".stylua.toml",
      "selene.toml",
      "selene.yml",
      "stylua.toml"
    ),
  }

  local powershell_es = {
    bundle_path = require("mason-registry").get_package("powershell-editor-services"):get_install_path(),
    settings = {
      powershell = {
        codeFormatting = { Preset = "OTBS" },
      },
    },
  }

  local ts_ls = {
    on_attach = function(client)
      -- we either format using biome or formatter.nvim+prettier
      client.server_capabilities.documentFormattingProvider = false
    end
  }

  local server_options = {
    -- emmet_ls = {},
    ansiblels = {},
    bashls = {},
    biome = {},
    bufls = {},
    clangd = clangd,
    cssls = {},
    docker_compose_language_service = docker_compose_language_service,
    dockerls = {},
    elmls = {},
    emmet_language_server = {},
    gopls = {},
    graphql = {},
    html = {},
    jsonls = jsonls,
    lua_ls = lua_ls,
    nixd = {},
    openscad_lsp = {},
    powershell_es = powershell_es,
    pyright = {},
    svelte = {},
    terraformls = {},
    tflint = {},
    ts_ls = ts_ls,
  }

  for name, options in pairs(server_options) do
    lspconfig[name].setup(options)
  end
end

return M

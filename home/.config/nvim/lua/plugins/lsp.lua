--- @type LazyPluginSpec[]
return {
  -- Portable package manager for Neovim that runs everywhere Neovim runs.
  -- https://github.com/williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -- Quickstart configs for Nvim LSP
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",

      -- nvim-cmp source for neovim's built-in language server client.
      -- https://github.com/hrsh7th/cmp-nvim-lsp
      { "hrsh7th/cmp-nvim-lsp" },

      -- JSON schemas for Neovim
      -- https://github.com/b0o/SchemaStore.nvim
      "b0o/schemastore.nvim",

      -- Lua LSP configuration for neovim lua development.
      -- https://github.com/folke/neodev.nvim
      { "folke/neodev.nvim",                              config = true },

      -- Clangd's off-spec features for neovim's LSP client
      -- https://sr.ht/~p00f/clangd_extensions.nvim
      { "https://git.sr.ht/~p00f/clangd_extensions.nvim", config = true },

      -- Supercharge your Rust experience in Neovim!
      -- https://github.com/mrcjkb/rustaceanvim
      {
        "mrcjkb/rustaceanvim",
        version = "^4",
        lazy = false,
      },
    },
    config = require("plugins.configs.lspconfig").setup
  },

  -- An asynchronous linter plugin for Neovim (>= 0.6.0) complementary to the built-in Language Server Protocol support.
  -- https://github.com/mfussenegger/nvim-lint
  {
    "mfussenegger/nvim-lint",
    config = require("plugins.configs.lint").setup,
  },

  -- A format runner for Neovim.
  -- https://github.com/mhartington/formatter.nvim
  {
    "mhartington/formatter.nvim",
    config = require("plugins.configs.formatter").setup,
  },

  -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    dependencies = {
      -- Adds file type icons to Vim
      -- https://github.com/nvim-tree/nvim-web-devicons
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>tt",  "<cmd>TroubleToggle<cr>" },
      { "<leader>td", "<cmd>Trouble diagnostics<cr>" },
      { "gd",         "<cmd>Trouble lsp_definitions<cr>" },
      { "gy",         "<cmd>Trouble lsp_type_definitions<cr>" },
      { "gr",         "<cmd>Trouble lsp_references<cr>" },
      { "gi",         "<cmd>Trouble lsp_implementations<cr>" },
    },
    config = true
  },
}

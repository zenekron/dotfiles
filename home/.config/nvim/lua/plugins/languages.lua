--- @type LazyPluginSpec[]
return {
  -- Nvim Treesitter configurations and abstraction layer
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = function()
      local o = {
        ensure_installed = {
          "cmake",
          "java",
          "json",
          "lua",
          "python",
          "rust",
          "scss",
          "svelte",
          "terraform",
          "typescript",
        },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }

      -- https://github.com/andymass/vim-matchup#tree-sitter-integration
      local has_vim_matchup = pcall(require, "vim-matchup")
      if has_vim_matchup then
        o.matchup = {
          enable = true,
        }
      end

      return o
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
  },

  {
    "lifepillar/pgsql.vim",
    ft = { "pgsql" },
  },
}

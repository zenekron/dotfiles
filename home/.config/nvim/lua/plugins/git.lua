--- @type LazyPluginSpec[]
return {
  --  Git integration for buffers.
  --  https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },

  -- A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
  -- https://github.com/airblade/vim-gitgutter
  {
    "airblade/vim-gitgutter",
    enabled = false, -- TODO: testing out gitsigns.nvim
  },

  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  -- https://github.com/sindrets/diffview.nvim
  {
    "sindrets/diffview.nvim",
    dependencies = {
      -- All the lua functions I don't want to write twice.
      -- https://github.com/nvim-lua/plenary.nvim
      "nvim-lua/plenary.nvim",

      -- Adds file type icons to Vim
      -- https://github.com/nvim-tree/nvim-web-devicons
      "nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "DiffviewFileHistory",
      "DiffviewOpen",
    },
  },

  -- A Git wrapper so awesome, it should be illegal
  -- https://github.com/tpope/vim-fugitive
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", ":Git<cr>")
      vim.keymap.set("n", "<leader>gc", ":Git commit<cr>")
      vim.keymap.set("n", "<leader>gh", ":diffget //2<cr>")
      vim.keymap.set("n", "<leader>gl", ":diffget //3<cr>")
    end
  },
}

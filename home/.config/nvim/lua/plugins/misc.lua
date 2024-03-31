--- @type LazyPluginSpec[]
return {
  -- EditorConfig plugin for Vim
  -- https://github.com/editorconfig/editorconfig-vim
  {
    "editorconfig/editorconfig-vim",
  },

  -- Highlight, list and search todo comments in your projects
  -- https://github.com/folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    config = true,
  },

  -- A Vim alignment plugin
  -- https://github.com/junegunn/vim-easy-align
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", { "n", "x" } },
    },
  },

  -- Neovim's answer to the mouse
  -- https://github.com/ggandor/leap.nvim
  {
    "ggandor/leap.nvim",
    dependencies = {
      -- enable repeating supported plugin maps with "."
      -- https://github.com/tpope/vim-repeat
      "tpope/vim-repeat",
    },
    config = function()
      vim.keymap.set({ "n", "o" }, "s", "<Plug>(leap-forward-to)", { silent = true })
      vim.keymap.set({ "n", "o" }, "S", "<Plug>(leap-backward-to)", { silent = true })
      vim.keymap.set({ "n", "o" }, "gs", "<Plug>(leap-from-window)", { silent = true })
    end,
  },

  -- Multiple cursors plugin for vim/neovim
  -- https://github.com/mg979/vim-visual-multi
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },

  -- Work with several variants of a word at once
  -- https://github.com/tpope/vim-abolish
  {
    "tpope/vim-abolish",
  },

  -- Smart and powerful comment plugin for neovim. Supports treesitter, dot
  -- repeat, left-right/up-down motions, hooks, and more
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = { "n", "o" } },
      { "gbc", mode = { "n", "o" } },
      { "gc",  mode = { "x" } },
      { "gb",  mode = { "x" } },
    },
    opts = {
      mappings = {
        extra = false,
      },
    },
  },

  -- comment stuff out
  -- https://github.com/tpope/vim-commentary
  {
    "tpope/vim-commentary",
    enabled = false, -- testing out numToStr/Comment.nvim
    config = function()
      local function set_filetype_commentstring(filetype, commentstring)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = filetype,
          callback = function(event)
            vim.bo[event.buf].commentstring = commentstring
          end,
        })
      end

      set_filetype_commentstring("cpp", "// %s")
      set_filetype_commentstring("nix", "# %s")
      set_filetype_commentstring("sql", "-- %s")
      set_filetype_commentstring("svelte", "<!-- %s -->")
      set_filetype_commentstring("terraform", "# %s")
    end,
  },

  -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
  -- https://github.com/tpope/vim-surround
  {
    "tpope/vim-surround",
  },

  -- even better %, navigate and highlight matching words, modern matchit and matchparen.
  -- https://github.com/andymass/vim-matchup
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
}

--- @type LazyPluginSpec[]
return {
  -- An arctic, north-bluish clean and elegant Vim theme.
  -- https://github.com/arcticicestudio/nord-vim
  {
    "arcticicestudio/nord-vim",
    enabled = false,
    priority = 1000,
  },

  -- One dark and light colorscheme for neovim >= 0.5.0
  -- https://github.com/navarasu/onedark.nvim
  {
    "navarasu/onedark.nvim",
    enabled = false,
    priority = 1000,
    opts = {
      style = "dark",
    },
  },

  -- A dark Vim/Neovim color scheme inspired by Atom's One Dark syntax theme.
  -- https://github.com/joshdick/onedark.vim
  {
    "joshdick/onedark.vim",
    enabled = false,
    priority = 1000,
  },

  -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
  -- https://github.com/rebelot/kanagawa.nvim
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    priority = 1000,
  },

  -- High Contrast & Vivid Color Scheme based on Monokai Pro
  -- https://github.com/sainnhe/sonokai
  {
    "sainnhe/sonokai",
    enabled = false,
    priority = 1000,
  },

  -- Soothing pastel theme for (Neo)vim
  -- https://github.com/catppuccin/nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function(self, opts)
      require("catppuccin").setup({
        flavour = "frappe",
        noice = true,
      })

      vim.cmd.colorscheme("catppuccin-frappe")
    end,
  },
}

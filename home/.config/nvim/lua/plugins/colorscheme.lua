---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Soothing pastel theme for (Neo)vim
	-- https://github.com/catppuccin/nvim
	{
		"catppuccin/nvim",
		name = "catppuccin",

		priority = 1000,

		init = function()
			if vim.startswith(vim.g.colorscheme, "catppuccin") then
				vim.cmd.colorscheme(vim.g.colorscheme)
			end
		end,
		opts = {},

		version = false,
	},

	-- A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
	-- https://github.com/folke/tokyonight.nvim
	{
		"folke/tokyonight.nvim",

		priority = 1000,

		init = function()
			if vim.startswith(vim.g.colorscheme, "tokyonight") then
				vim.cmd.colorscheme(vim.g.colorscheme)
			end
		end,
		opts = {},

		version = false,
	},
}

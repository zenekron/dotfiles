---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
	-- https://github.com/nvim-lualine/lualine.nvim
	{
		"https://github.com/nvim-lualine/lualine.nvim",

		dependencies = {
			-- Provides Nerd Font icons (glyphs) for use by neovim plugins
			-- https://github.com/nvim-tree/nvim-web-devicons
			{ "nvim-tree/nvim-web-devicons", optional = true },
		},
		cond = function()
			return vim.g.statusline == "lualine"
		end,

		opts = {
			options = {
				icons_enabled = vim.g.nerd_font,
			},
		},

		version = false,
	},
}

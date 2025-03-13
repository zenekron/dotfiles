---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Git integration for buffers
	-- https://github.com/lewis6991/gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim",

		opts = {},

		version = "*",
	},

	-- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
	-- https://github.com/sindrets/diffview.nvim
	{
		"sindrets/diffview.nvim",

		dependencies = {
			-- Provides Nerd Font icons (glyphs) for use by neovim plugins
			-- https://github.com/nvim-tree/nvim-web-devicons
			{ "nvim-tree/nvim-web-devicons", optional = true },
		},

		opts = {},

		cmd = {
			"DiffviewFileHistory",
			"DiffviewOpen",
		},

		version = false,
	},
}

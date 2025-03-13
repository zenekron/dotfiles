---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- A snazzy bufferline for Neovim
	-- https://github.com/akinsho/bufferline.nvim
	{
		"akinsho/bufferline.nvim",

		dependencies = {
			-- Provides Nerd Font icons (glyphs) for use by neovim plugins
			-- https://github.com/nvim-tree/nvim-web-devicons
			{ "nvim-tree/nvim-web-devicons", optional = true },
		},
		cond = function()
			return vim.g.bufferline == "bufferline"
		end,

		-- :h bufferline-configuration
		opts = {
			options = {
				mode = "tabs",
				numbers = "ordinal",
				truncate_names = false,
				tab_size = 4,
				diagnostics = "nvim_lsp",
				separator_style = "slant",

				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = true,
					},
				},
			},
		},

		version = "*",
	},
}

---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Nvim Treesitter configurations and abstraction layer
	-- https://github.com/nvim-treesitter/nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",

		---@module "nvim-treesitter"
		---@type TSConfig
		---@diagnostic disable-next-line missing-fields
		opts = {
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

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},
		},
		main = "nvim-treesitter.configs",
		build = ":TSUpdate",

		version = "*",
	},
}

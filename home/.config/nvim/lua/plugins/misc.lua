---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Library of 40+ independent Lua modules improving overall Neovim (version 0.8 and higher) experience with minimal effort
	-- https://github.com/echasnovski/mini.nvim
	{
		"echasnovski/mini.nvim",

		opts = {
			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
			["mini.align"] = {
				mappings = {
					start = "gA",
					start_with_preview = "ga",
				},
			},

			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
			["mini.surround"] = {
				mappings = {
					add = "S",
					delete = "ds",
					replace = "cs",

					find = "", -- Find surrounding (to the right)
					find_left = "", -- Find surrounding (to the left)
					highlight = "", -- Highlight surrounding
					update_n_lines = "", -- Update `n_lines`

					suffix_last = "", -- Suffix to search with "prev" method
					suffix_next = "", -- Suffix to search with "next" method}
				},
			},
		},
		config = function(_, opts)
			for mod_name, mod_opts in pairs(opts) do
				require(mod_name).setup(mod_opts)
			end
		end,

		version = "*",
	},

	-- A collection of QoL plugins for Neovim
	-- https://github.com/folke/snacks.nvim
	{
		"folke/snacks.nvim",

		priority = 1000,

		opts = function()
			---@module "snacks"
			---@type snacks.Config
			local config = {}

			if vim.g.input == "snacks" then
				config.input = {}
			end

			if vim.g.notify == "snacks" then
				config.notifier = {}
			end

			return config
		end,

		lazy = false,

		version = "*",
	},

	-- Multiple cursors plugin for vim/neovim
	-- https://github.com/mg979/vim-visual-multi
	{
		"mg979/vim-visual-multi",

		version = false,
	},

	-- abolish.vim: Work with several variants of a word at once
	-- https://github.com/tpope/vim-abolish
	{
		"tpope/vim-abolish",

		version = "*",
	},
}

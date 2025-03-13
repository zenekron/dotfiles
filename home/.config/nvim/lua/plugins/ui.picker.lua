---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Find, Filter, Preview, Pick. All lua, all the time
	-- https://github.com/nvim-telescope/telescope.nvim
	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			-- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice
			-- https://github.com/nvim-lua/plenary.nvim
			"nvim-lua/plenary.nvim",

			-- FZF sorter for telescope written in c
			-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
			{
				"nvim-telescope/telescope-fzf-native.nvim",

				cond = function()
					return vim.fn.executable("fzf") == 1
				end,

				build = "make",

				version = false,
			},

			-- Provides Nerd Font icons (glyphs) for use by neovim plugins
			-- https://github.com/nvim-tree/nvim-web-devicons
			{ "nvim-tree/nvim-web-devicons", optional = true },

			-- https://github.com/nvim-telescope/telescope-ui-select.nvim
			{
				"nvim-telescope/telescope-ui-select.nvim",

				cond = function()
					return vim.g.select == "telescope"
				end,
			},
		},
		cond = function()
			return vim.g.picker == "telescope"
		end,

		-- :h telescope.setup()
		opts = {
			defaults = {
				mappings = {
					i = {
						-- navigate results using CTRL-J/CTRL-K
						["<c-j>"] = "move_selection_next",
						["<c-k>"] = "move_selection_previous",
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				live_grep = {
					additional_args = { "--hidden" },
				},
			},
			extensions = {
				["ui-select"] = { require("telescope.themes").get_dropdown({}) },
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			-- load extensions
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")
		end,

		cmd = "Telescope",
		keys = {
			{
				"<leader>fo",
				function()
					require("telescope.builtin").find_files()
				end,
				"n",
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				"n",
				desc = "Find files (grep)",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				"n",
				desc = "Find buffers",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").resume()
				end,
				"n",
				desc = "Picker | Resume",
			},
		},

		version = "*",
	},
}

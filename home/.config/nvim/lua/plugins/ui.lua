---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Extensible UI for Neovim notifications and LSP progress messages
	-- https://github.com/j-hui/fidget.nvim
	{
		"j-hui/fidget.nvim",

		opts = {
			notification = {
				override_vim_notify = vim.g.notify == "fidget",
			},
		},

		version = "*",
	},

	-- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing
	-- https://github.com/folke/trouble.nvim
	{
		"folke/trouble.nvim",

		dependencies = {
			-- Provides Nerd Font icons (glyphs) for use by neovim plugins
			-- https://github.com/nvim-tree/nvim-web-devicons
			{ "nvim-tree/nvim-web-devicons", optional = true },
		},

		---@module "trouble"
		---@type trouble.Config
		opts = {},

		cmd = "Trouble",
		keys = {
			{
				"<leader>tt",
				function()
					local trouble = require("trouble")
					trouble.toggle()
				end,
			},

			-- diagnostics
			{
				"<leader>d",
				function()
					local trouble = require("trouble")
					trouble.close()
					trouble.open({ mode = "diagnostics" })
				end,
				"n",
			},

			-- goto
			{
				"gd",
				function()
					local trouble = require("trouble")
					trouble.close()
					trouble.open({ mode = "lsp_definitions" })
				end,
				"n",
			},
			{
				"gD",
				function()
					local trouble = require("trouble")
					trouble.close()
					trouble.open({ mode = "lsp_declarations" })
				end,
				"n",
			},
			{
				"gy",
				function()
					local trouble = require("trouble")
					trouble.close()
					trouble.open({ mode = "lsp_type_definitions" })
				end,
				"n",
			},
			{
				"gr",
				function()
					local trouble = require("trouble")
					trouble.close()
					trouble.open({ mode = "lsp_references", new = false })
				end,
				"n",
			},
			{
				"gi",
				function()
					local trouble = require("trouble")
					trouble.close()
					trouble.open({ mode = "lsp_implementations" })
				end,
				"n",
			},
		},

		version = "*",
	},

	-- Provides Nerd Font icons (glyphs) for use by neovim plugins
	-- https://github.com/nvim-tree/nvim-web-devicons
	{
		"nvim-tree/nvim-web-devicons",

		cond = vim.g.nerd_font,

		version = false,
	},

	-- Highlight, list and search todo comments in your projects
	-- https://github.com/folke/todo-comments.nvim
	{
		"folke/todo-comments.nvim",

		dependencies = {
			-- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice
			-- https://github.com/nvim-lua/plenary.nvim
			"nvim-lua/plenary.nvim",
		},

		opts = {},

		version = "*",
	},

	-- The fastest Neovim colorizer
	-- https://github.com/catgoose/nvim-colorizer.lua
	{
		"catgoose/nvim-colorizer.lua",

		opts = {},

		event = "BufReadPre",

		version = false,
	},

	-- Create key bindings that stick. WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type
	-- https://github.com/folke/which-key.nvim
	{
		"folke/which-key.nvim",

		-- Loading
		dependencies = {
			-- Provides Nerd Font icons (glyphs) for use by neovim plugins
			-- https://github.com/nvim-tree/nvim-web-devicons
			{ "nvim-tree/nvim-web-devicons", optional = true },
		},

		opts = {
			preset = "modern",
			icons = {
				mappings = vim.g.nerd_font,
			},
		},

		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
			},
		},

		version = "*",
	},
}

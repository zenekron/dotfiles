---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Use your Neovim like using Cursor AI IDE!
	-- https://github.com/yetone/avante.nvim
	{
		"yetone/avante.nvim",

		dependencies = {
			-- Nvim Treesitter configurations and abstraction layer
			-- https://github.com/nvim-treesitter/nvim-treesitter
			"nvim-treesitter/nvim-treesitter",

			-- Neovim plugin to improve the default vim.ui interfaces
			-- https://github.com/stevearc/dressing.nvim
			{
				"stevearc/dressing.nvim",

				-- NOTE: disable vim.input and vim.select as we only use this as a dependency
				opts = {
					input = { enabled = false },
					select = { enabled = false },
				},
			},

			-- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice
			-- https://github.com/nvim-lua/plenary.nvim
			"nvim-lua/plenary.nvim",

			-- UI Component Library for Neovim
			-- https://github.com/MunifTanjim/nui.nvim
			"MunifTanjim/nui.nvim",

			-- Provides Nerd Font icons (glyphs) for use by neovim plugins
			-- https://github.com/nvim-tree/nvim-web-devicons
			{ "nvim-tree/nvim-web-devicons", optional = true },

			-- A completion plugin for neovim coded in Lua.
			-- https://github.com/hrsh7th/nvim-cmp
			{
				"hrsh7th/nvim-cmp",

				cond = function()
					return vim.g.complete == "cmp"
				end,
			},

			-- Find, Filter, Preview, Pick. All lua, all the time
			-- https://github.com/nvim-telescope/telescope.nvim
			{
				"nvim-telescope/telescope.nvim",

				cond = function()
					return vim.g.picker == "telescope"
				end,
			},
		},
		cond = function()
			local ollama_url = os.getenv("OLLAMA_URL")
			if not ollama_url then
				return false
			end

			return os.execute("curl --connect-timeout 0.2 --silent --output /dev/null '" .. ollama_url .. "'") == 0
		end,

		---@module "avante"
		---@type avante.Config
		opts = {
			provider = "ollama",
			auto_suggestions_provider = "ollama",
			cursor_applying_provider = "ollama", -- cursor planning mode

			mappings = {
				suggestion = {
					accept = "<A-L>",
					next = "<A-]>",
					prev = "<A-[>",
				},
			},

			behaviour = {
				auto_suggestions = true,
				enable_cursor_planning_mode = true, -- cursor planning mode
			},

			file_selector = {
				---@return FileSelectorProvider
				provider = function()
					if vim.g.picker == "telescope" then
						return "telescope"
					end

					return "native"
				end,
			},

			---@type AvanteProvider
			ollama = {
				api_key_name = "",
				endpoint = "http://astaroth.local:11434",
				stream = true, -- "ollama" impl requires "stream = true"

				model = "qwen2.5-coder:14b",
				options = {
					num_ctx = 32768,
					temperature = 0,
				},

				-- model = "codellama:13b"
				-- model = "codellama:7b"
				-- model = "deepseek-coder-v2:16b"
				-- model = "qwen2.5-coder:7b"
				-- model = "wizardlm2:7b"
			},
		},
		build = "make",

		event = "VeryLazy",

		version = false,
	},
}

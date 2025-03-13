---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- A file explorer tree for neovim written in lua
	-- https://github.com/nvim-tree/nvim-tree.lua
	{
		"nvim-tree/nvim-tree.lua",

		dependencies = {
			-- Provides Nerd Font icons (glyphs) for use by neovim plugins
			-- https://github.com/nvim-tree/nvim-web-devicons
			{ "nvim-tree/nvim-web-devicons", optional = true },
		},
		cond = function()
			return vim.g.file_tree == "nvim-tree"
		end,

		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		opts = function()
			local on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- apply default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- close/open directories using h/l
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close directory"))
				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
			end

			-- :h nvim-tree-opts
			return {
				on_attach = on_attach,

				view = {
					width = {},
				},

				update_focused_file = {
					enable = true,
				},

				tab = {
					sync = {
						open = true,
						close = true,
					},
				},
			}
		end,

		cmd = {
			"NvimTreeOpen",
			"NvimTreeClose",
			"NvimTreeToggle",
			"NvimTreeFocus",
			"NvimTreeRefresh",
			"NvimTreeFindFile",
			"NvimTreeFindFileToggle",
			"NvimTreeClipboard",
			"NvimTreeResize",
			"NvimTreeCollapse",
			"NvimTreeCollapseKeepBuffers",
			"NvimTreeHiTest",
		},
		keys = {
			{ "<leader>fe", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
		},

		version = "*",
	},
}

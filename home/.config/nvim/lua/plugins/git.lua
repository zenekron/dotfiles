---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Git integration for buffers
	-- https://github.com/lewis6991/gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim",

		opts = {},

		lazy = false,
		keys = {
			{
				"<leader>hb",
				function()
					require("gitsigns").blame_line()
				end,
				desc = "git: [b]lame line",
			},
			{
				"<leader>hB",
				"<cmd>Gitsigns blame<cr>",
				desc = "git: toggle [B]lame",
			},

			{
				"<leader>hp",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "git: [p]review hunk",
			},
			{
				"<leader>hP",
				function()
					require("gitsigns").preview_hunk_inline()
				end,
				desc = "git: [P]review hunk inline",
			},

			{
				"<leader>hd",
				function()
					require("gitsigns").diffthis()
				end,
				desc = "git: [d]iff against index",
			},
			{
				"<leader>hD",
				function()
					require("gitsigns").diffthis("@")
				end,
				desc = "git: [D]iff against last commit",
			},

			-- navigation
			{
				"]c",
				function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						require("gitsigns").nav_hunk("next")
					end
				end,
				desc = "git: jump to next [c]hange",
			},
			{
				"[c",
				function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						require("gitsigns").nav_hunk("prev")
					end
				end,
				desc = "git: jump to previous [c]hange",
			},

			-- hunk actions
			{
				"<leader>hs",
				function()
					require("gitsigns").stage_hunk()
				end,
				desc = "git: [s]tage hunk",
			},
			{
				"<leader>hs",
				function()
					require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				desc = "git: [s]tage hunk",
			},
			{
				"<leader>hr",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "git: [r]eset hunk",
			},
			{
				"<leader>hr",
				function()
					require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				desc = "git: [r]eset hunk",
			},

			-- buffer actions
			{
				"<leader>hS",
				function()
					require("gitsigns").stage_buffer()
				end,
				desc = "git: [S]tage buffer",
			},
			{
				"<leader>hR",
				function()
					require("gitsigns").stage_buffer()
				end,
				desc = "git: [R]eset buffer",
			},
		},

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

local util = require("util")

local gitsigns = util.requirei("gitsigns")
local kgitsigns = util.requirek("gitsigns")

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
			{ "<leader>hb", kgitsigns.blame_line(), desc = "git: [b]lame line" },
			{ "<leader>hB", "<cmd>Gitsigns blame<cr>", desc = "git: toggle [B]lame" },

			{ "<leader>hp", kgitsigns.preview_hunk(), desc = "git: [p]review hunk" },
			{ "<leader>hP", kgitsigns.preview_hunk_inline(), desc = "git: [P]review hunk inline" },

			{ "<leader>hd", kgitsigns.diffthis(), desc = "git: [d]iff against index" },
			{ "<leader>hD", kgitsigns.diffthis("@"), desc = "git: [D]iff against last commit" },

			-- navigation
			{
				"]c",
				function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
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
						gitsigns.nav_hunk("prev")
					end
				end,
				desc = "git: jump to previous [c]hange",
			},

			-- hunk actions
			{ "<leader>hs", kgitsigns.stage_hunk(), desc = "git: [s]tage hunk" },
			{ "<leader>hr", kgitsigns.reset_hunk(), desc = "git: [r]eset hunk" },

			{
				"<leader>hs",
				function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				desc = "git: [s]tage hunk",
			},
			{
				"<leader>hr",
				function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				desc = "git: [r]eset hunk",
			},

			-- buffer actions
			{ "<leader>hS", kgitsigns.stage_buffer(), desc = "git: [S]tage buffer" },
			{ "<leader>hR", kgitsigns.reset_buffer(), desc = "git: [R]eset buffer" },
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

---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Lightweight yet powerful formatter plugin for Neovim
	-- https://github.com/stevearc/conform.nvim
	{
		"stevearc/conform.nvim",

		cond = function()
			return vim.g.format == "conform"
		end,

		init = function()
			vim.opt.formatexpr = 'v:lua.require("conform").formatexpr()'
		end,
		opts = function()
			local prettier = { "prettierd", "prettier", stop_after_first = true }

			---@module "conform"
			---@type conform.setupOpts
			return {
				formatters_by_ft = {
					c = { "clang-format" },
					cpp = { "clang-format" },
					css = prettier,
					go = { "gofmt" },
					html = prettier,
					java = prettier,
					javascript = prettier,
					javascriptreact = prettier,
					json = prettier,
					jsonc = prettier,
					lua = { "stylua" },
					markdown = prettier,
					nix = { "alejandra" },
					python = { "black" },
					scss = prettier,
					typescript = prettier,
					typescriptreact = prettier,
					xml = prettier,
					yaml = prettier,
				},

				format_on_save = {},

				default_format_opts = {
					lsp_format = "fallback",
				},
			}
		end,

		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>ff",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format",
			},
		},

		version = "*",
	},
}

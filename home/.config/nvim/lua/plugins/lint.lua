---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support
	-- https://github.com/mfussenegger/nvim-lint
	{
		"mfussenegger/nvim-lint",

		cond = function()
			return vim.g.lint == "lint"
		end,

		opts = function()
			---@type string[]
			local typescript = {}
			if vim.fn.executable("oxlint") == 1 then
				table.insert(typescript, "oxlint")
			end
			if vim.fn.executable("eslint") == 1 then
				table.insert(typescript, "eslint")
			end

			---@type table<string, string[]>
			return {
				javascript = typescript,
				javascriptreact = typescript,
				typescript = typescript,
				typescriptreact = typescript,
			}
		end,
		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = opts

			vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = function()
					lint.try_lint()
				end,
			})
		end,

		ft = function(self)
			return vim.tbl_keys(self.opts(self, {}) or {})
		end,

		version = false,
	},
}

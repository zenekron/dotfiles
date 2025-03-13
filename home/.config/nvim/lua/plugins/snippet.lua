---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Snippet Engine for Neovim written in Lua
	-- https://github.com/L3MON4D3/LuaSnip
	{
		"L3MON4D3/LuaSnip",

		dependencies = {
			-- Set of preconfigured snippets for different languages
			-- https://github.com/rafamadriz/friendly-snippets
			"rafamadriz/friendly-snippets",
		},
		cond = function()
			return vim.g.snippet == "luasnip"
		end,

		config = function()
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_lua").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load()

			-- :LuaSnipEdit - opens the snippet file for live editing
			vim.api.nvim_create_user_command("LuaSnipEdit", function()
				require("luasnip.loaders").edit_snippet_files()
			end, {})

			-- Stop any active luasnip sessions when leaving insert mode. This prevents
			-- your cursor from being grabbed while trying to insert a <tab> character
			-- because of a previous luasnip session that was not completed.
			vim.api.nvim_create_autocmd("InsertLeave", {
				group = vim.api.nvim_create_augroup("luasnip-cleanup", { clear = true }),
				callback = function()
					if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
						luasnip.unlink_current()
					end
				end,
			})
		end,
		build = "make install_jsregexp",

		cmd = {
			-- custom
			"LuaSnipEdit",
			-- builtins
			"LuaSnipListAvailable",
			"LuaSnipUnlinkCurrent",
		},

		version = "*",
	},
}

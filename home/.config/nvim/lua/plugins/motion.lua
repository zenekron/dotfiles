---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Neovim's answer to the mouse
	-- https://github.com/ggandor/leap.nvim
	{
		"ggandor/leap.nvim",

		dependencies = {
			-- repeat.vim: enable repeating supported plugin maps with "."
			-- https://github.com/tpope/vim-repeat
			"tpope/vim-repeat",
		},

		config = function()
			require("leap").create_default_mappings()
		end,

		version = false,
	},
}

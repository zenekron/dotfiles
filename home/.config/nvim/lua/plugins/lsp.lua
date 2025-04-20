---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- Quickstart configs for Nvim LSP
	-- https://github.com/neovim/nvim-lspconfig
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			-- JSON schemas for Neovim
			-- https://github.com/b0o/SchemaStore.nvim
			"b0o/schemastore.nvim",

			-- nvim-cmp source for neovim builtin LSP client
			-- https://github.com/hrsh7th/cmp-nvim-lsp
			{ "hrsh7th/cmp-nvim-lsp", optional = true },
		},

		opts = function()
			local schemastore = require("schemastore")

			local jsonls = {
				settings = {
					json = {
						schemas = schemastore.json.schemas(),
						validate = { enable = true },
					},
				},
			}

			local yamlls = {
				settings = {
					schemaStore = {
						enable = false,
						url = "",
					},
					schemas = schemastore.yaml.schemas(),
				},
			}

			local powershell_es = {}
			if vim.fn.executable("powershell-editor-services") == 1 then
				powershell_es.cmd = { "powershell-editor-services", "-Stdio" }
			elseif vim.fn.filereadable("/opt/powershell-editor-services") then
				powershell_es.bundle_path = "/opt/powershell-editor-services"
			end

			return {
				ansiblels = {},
				bashls = {},
				biome = {},
				buf_ls = {},
				clangd = {},
				cssls = {},
				dartls = {},
				emmet_language_server = {},
				gopls = {},
				html = {},
				jsonls = jsonls,
				lua_ls = {},
				neocmake = {},
				nil_ls = {},
				nixd = {},
				powershell_es = powershell_es,
				pyright = {},
				svelte = {},
				ts_ls = {},
				yamlls = yamlls,
			}
		end,
		config = function(_, opts)
			local lspconfig = require("lspconfig")

			-- determine capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			if vim.g.complete == "cmp" then
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			end

			-- configure servers
			for name, options in pairs(opts) do
				local cmd = options.cmd or lspconfig[name].config_def.default_config.cmd
				if not cmd or #cmd == 0 or vim.fn.executable(cmd[1]) == 1 then
					lspconfig[name].setup(vim.tbl_deep_extend("force", options, { capabilities }))
				end
			end
		end,

		version = "*",
	},

	-- Clangd's off-spec features for neovim's LSP client
	-- https://sr.ht/~p00f/clangd_extensions.nvim/
	{
		"https://git.sr.ht/~p00f/clangd_extensions.nvim",

		cond = function()
			return vim.fn.executable("clangd") == 1
		end,

		opts = {},
	},

	-- Faster LuaLS setup for Neovim
	-- https://github.com/folke/lazydev.nvim
	{
		"folke/lazydev.nvim",

		opts = {},

		ft = "lua",

		version = "*",
	},

	-- Supercharge your Rust experience in Neovim! A heavily modified fork of rust-tools.nvim
	-- https://github.com/mrcjkb/rustaceanvim
	{
		"mrcjkb/rustaceanvim",

		cond = function()
			return vim.fn.executable("rust-analyzer") == 1
		end,

		init = function()
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							imports = {
								prefix = "self",
								granularity = {
									enforce = true,
								},
							},
						},
					},
				},
			}
		end,

		version = "*",
	},
}

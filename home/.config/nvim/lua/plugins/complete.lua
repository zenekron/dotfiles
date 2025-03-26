---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- A completion plugin for neovim coded in Lua.
	-- https://github.com/hrsh7th/nvim-cmp
	{
		"hrsh7th/nvim-cmp",

		dependencies = {
			-- nvim-cmp source for neovim builtin LSP client
			-- https://github.com/hrsh7th/cmp-nvim-lsp
			"hrsh7th/cmp-nvim-lsp",

			-- cmp-nvim-lsp-signature-help
			-- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
			"hrsh7th/cmp-nvim-lsp-signature-help",

			-- nvim-cmp source for path
			-- https://github.com/hrsh7th/cmp-path
			"hrsh7th/cmp-path",

			-- nvim-cmp source for buffer words
			-- https://github.com/hrsh7th/cmp-buffer
			"hrsh7th/cmp-buffer",

			-- luasnip completion source for nvim-cmp
			-- https://github.com/saadparwaiz1/cmp_luasnip
			{
				"saadparwaiz1/cmp_luasnip",

				cond = function()
					return vim.g.snippet == "luasnip"
				end,
			},
		},
		cond = function()
			return vim.g.complete == "cmp"
		end,

		---@return cmp.ConfigSchema
		opts = function()
			local cmp = require("cmp")

			---@type cmp.SnippetConfig
			local snippet = {
				expand = function() end,
			}

			local mapping_next = "<tab>"
			local mapping_prev = "<s-tab>"
			local mapping_confirm = "<cr>"
			---@type table<string, cmp.Mapping>
			local mapping = {
				["<c-space>"] = cmp.mapping.complete(),
				[mapping_next] = cmp.mapping.select_next_item(),
				[mapping_prev] = cmp.mapping.select_prev_item(),
				["<c-e>"] = cmp.mapping.abort(),
				[mapping_confirm] = cmp.mapping.confirm({ select = true }),

				["<c-f>"] = cmp.mapping.scroll_docs(4),
				["<c-d>"] = cmp.mapping.scroll_docs(-4),
			}

			---@type cmp.SourceConfig[]
			local sources = {
				{ name = "nvim_lsp", group_index = 1 },
				-- <snippet>
				{ name = "nvim_lsp_signature_help", group_index = 1 },
				{ name = "path", group_index = 1 },
				{ name = "buffer", group_index = 2 },
			}
			local sources_snippet_index = 2

			local has_lazydev = pcall(require, "lazydev")
			if has_lazydev then
				table.insert(sources, 1, {
					name = "lazydev",
					group_index = 0, -- set group index to 0 to skip loading
				})
				sources_snippet_index = sources_snippet_index + 1
			end

			if vim.g.snippet == "luasnip" then
				local luasnip = require("luasnip")

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				}

				mapping = vim.tbl_extend("force", mapping, {
					[mapping_confirm] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({ select = true })
							end
						else
							fallback()
						end
					end),

					[mapping_next] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					[mapping_prev] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				})

				table.insert(sources, sources_snippet_index, { name = "luasnip" })
			else
				vim.notify("nvim-cmp: no snippet engine configured", vim.log.levels.ERROR, {})
			end

			---@type cmp.ConfigSchema
			return {
				snippet = snippet,
				mapping = mapping,
				sources = cmp.config.sources(sources),

				formatting = {
					fields = { "abbr", "kind" },
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			}
		end,

		event = "InsertEnter",

		version = false,
	},

	-- Performant, batteries-included completion plugin for Neovim
	-- https://github.com/saghen/blink.cmp
	{
		"saghen/blink.cmp",

		dependencies = {
			-- Set of preconfigured snippets for different languages
			-- https://github.com/rafamadriz/friendly-snippets
			{ "rafamadriz/friendly-snippets", optional = true },
		},
		cond = function()
			return vim.g.complete == "blink"
		end,

		opts = function()
			---@type blink.cmp.Config
			local o = {
				appearance = {
					nerd_font_variant = "mono",
				},

				completion = {
					documentation = {
						auto_show = true,
					},
				},

				fuzzy = {
					implementation = "prefer_rust_with_warning",
				},

				signature = {
					enabled = true,
				},

				sources = {
					default = {
						"lsp",
						"snippets",
						"path",
						"buffer",
					},
				},

				keymap = {
					preset = "none",

					["<c-space>"] = { "show", "fallback" },
					["<tab>"] = { "select_next", "snippet_forward", "fallback" },
					["<s-tab>"] = { "select_prev", "snippet_backward", "fallback" },
					["<c-e>"] = { "hide", "fallback" },
					["<cr>"] = { "accept", "fallback" },

					["<c-f>"] = { "scroll_documentation_down", "fallback" },
					["<c-d>"] = { "scroll_documentation_up", "fallback" },
				},
			}

			if vim.g.snippet == nil then
				-- do nothing
			elseif vim.g.snippet == "luasnip" then
				o.snippets = vim.tbl_deep_extend("force", o.snippets or {}, { preset = "luasnip" })
			else
				vim.notify("blink: unsupported snippet engine '" .. vim.g.snippet .. "'", vim.log.levels.ERROR, {})
			end

			local has_lazydev = pcall(require, "lazydev")
			if has_lazydev then
				table.insert(o.sources.default, "lazydev")
				o.sources.providers = vim.tbl_extend("force", o.sources.providers or {}, {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				})
			end

			return o
		end,
		opts_extend = { "sources.default" },

		event = "InsertEnter",

		version = "*",
	},
}

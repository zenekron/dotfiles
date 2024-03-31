--- @type LazyPluginSpec[]
return {
  -- A completion engine plugin for neovim written in Lua.
  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- nvim-cmp source for buffer words.
      -- https://github.com/hrsh7th/cmp-buffer
      "hrsh7th/cmp-buffer",

      -- nvim-cmp source for neovim's built-in language server client.
      -- https://github.com/hrsh7th/cmp-nvim-lsp
      "hrsh7th/cmp-nvim-lsp",

      -- nvim-cmp source for displaying function signatures with the current parameter emphasized
      -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
      "hrsh7th/cmp-nvim-lsp-signature-help",

      -- nvim-cmp source for filesystem paths.
      -- https://github.com/hrsh7th/cmp-path
      "hrsh7th/cmp-path",

      -- luasnip completion source for nvim-cmp
      -- https://github.com/saadparwaiz1/cmp_luasnip
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          -- Snippet Engine for Neovim written in Lua.
          -- https://github.com/L3MON4D3/LuaSnip
          {
            "L3MON4D3/LuaSnip",
            dependencies = {
              -- Snippets collection for a set of different programming languages for faster development.
              -- https://github.com/rafamadriz/friendly-snippets
              "rafamadriz/friendly-snippets",
            },
            build = "make install_jsregexp", -- install jsregexp (optional)
            config = function()
              require("luasnip.loaders.from_lua").load()
              require("luasnip.loaders.from_snipmate").lazy_load()
              require("luasnip.loaders.from_vscode").lazy_load()

              -- :LuaSnipEdit - opens the snippet file for live editing
              vim.api.nvim_create_user_command("LuaSnipEdit", function()
                require("luasnip.loaders").edit_snippet_files({})
              end, {})

              vim.api.nvim_create_autocmd("InsertLeave", {
                callback = function()
                  local luasnip = require("luasnip")
                  if
                      luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
                      and not luasnip.session.jump_active
                  then
                    luasnip.unlink_current()
                  end
                end,
              })
            end
          },


        },
      },
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      return {
        snippet = {
          expand = function(args)
            return luasnip.lsp_expand(args.body)
          end
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
              -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
              -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      }
    end,
  },
}

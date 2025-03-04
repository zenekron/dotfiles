--- @type LazyPluginSpec[]
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "ollama",
    auto_suggestions_provider = "ollama",
    behaviour = {
      auto_suggestions = true,
    },
    mappings = {
      suggestion = {
        accept = "<A-L>",
        next = "<A-]>",
        prev = "<A-[>",
      },
    },
    vendors = {
      ---@type AvanteProvider
      ollama = {
        endpoint = "http://192.168.1.114:11434",
        parse_curl_args = require("plugins.configs.avante.ollama").parse_curl_args,
        parse_stream_data = require("plugins.configs.avante.ollama").parse_stream_data,

        model = "qwen2.5-coder:14b",
        options = {
          num_ctx = 4096,
        },

        -- codebooga
        -- model = "deepseek-r1:14b",
        -- model = "deepseek-coder-v2",
        -- model = "phind-codellama", -- 34b 19GiB
        -- model = "dolphin-mixtral", -- 8x7b, 26GiB, 32768 context length, 4096 embedding length -- too slow
        -- model = "codestral", -- 22b, 13GiB, 32768 context length, 6144 embedding length -- fast but generates incomplete output
        -- model = "codellama:7b", -- 7b, 3.8GiB, 16384 context length, 4096 embedding length
        -- model = "phind-codellama",
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua",      -- for providers='copilot'
    -- {
    --   -- support for image pasting
    --   "HakonHarnes/img-clip.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     -- recommended settings
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = true,
    --       },
    --       -- required for Windows users
    --       use_absolute_path = true,
    --     },
    --   },
    -- },
    -- {
    --   -- Make sure to set this up properly if you have lazy=true
    --   'MeanderingProgrammer/render-markdown.nvim',
    --   opts = {
    --     file_types = { "markdown", "Avante" },
    --   },
    --   ft = { "markdown", "Avante" },
    -- },
  },
}

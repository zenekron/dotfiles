local function pick_executable()
  return vim.fn.input({
    prompt = "Path to executable: ",
    default = vim.fn.getcwd() .. "/",
    completion = "file",
  })
end

--- @type LazyPluginSpec[]
return {
  -- Debug Adapter Protocol client implementation for Neovim
  -- https://github.com/mfussenegger/nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" },
    keys = {
      { "<leader>bc", "<cmd>DapContinue<cr>",         { "n", "x" } },
      { "<leader>bn", "<cmd>DapStepOver<cr>",         { "n", "x" } },
      { "<leader>bi", "<cmd>DapStepInto<cr>",         { "n", "x" } },
      { "<leader>bo", "<cmd>DapStepOut<cr>",          { "n", "x" } },
      { "<leader>bt", "<cmd>DapToggleBreakpoint<cr>", { "n", "x" } },
      { "<leader>bq", "<cmd>DapTerminate<cr>",        { "n", "x" } },
    },
    config = function()
      local dap = require("dap")

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
      }


      local codelldb = {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = pick_executable,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      }

      dap.configurations.cpp = { codelldb }
      dap.configurations.rust = { codelldb }
    end,
  },

  {
    -- A UI for nvim-dap
    -- https://github.com/rcarriga/nvim-dap-ui
    "rcarriga/nvim-dap-ui",
    dependencies = {
      -- Debug Adapter Protocol client implementation for Neovim
      -- https://github.com/mfussenegger/nvim-dap
      "mfussenegger/nvim-dap",

      -- A library for asynchronous IO in Neovim
      -- https://github.com/nvim-neotest/nvim-nio
      "nvim-neotest/nvim-nio",
    },
    lazy = true,
    config = function(_)
      local dap = require("dap")
      local dapui = require("dapui")

      require("dapui").setup({})

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    end,
  },
}

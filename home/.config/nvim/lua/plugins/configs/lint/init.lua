local M = {}

M.setup = function()
  local lint = require("lint")

  lint.linters["terraform-validate"] = require("plugins.configs.lint.terraform_validate")

  for _, v in pairs({ "--dialect", "postgres" }) do
    table.insert(lint.linters["sqlfluff"].args, v)
  end

  lint.linters_by_ft = {
    c = { "cppcheck", },
    cmake = { "cmakelint", },
    cpp = { "cppcheck", },
    javascript = { "eslint", },
    javascriptreact = { "eslint", },
    pgsql = { "sqlfluff", },
    sh = { "shellcheck", },
    terraform = { "terraform-validate", "tfsec", },
    typescript = { "eslint", },
    typescriptreact = { "eslint", },
    vue = { "eslint", },
  }

  vim.api.nvim_create_autocmd({"BufRead", "BufWritePost" }, {
    pattern = "*",
    callback = function()
      lint.try_lint()
    end
  })
end

return M

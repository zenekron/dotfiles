local M = {}

M.setup = function()
  local lint = require("lint")

  lint.linters["terraform-validate"] = require("plugins.configs.lint.terraform_validate")

  for _, v in pairs({ "--dialect", "postgres" }) do
    table.insert(lint.linters["sqlfluff"].args, v)
  end

  local cmake = {}
  if vim.fn.executable("cmake-lint") == 1 then
    table.insert(cmake, "cmakelint")
  end

  local cpp = {}
  if vim.fn.executable("cppcheck") == 1 then
    table.insert(cmake, "cppcheck")
  end

  local typescript = {}
  if vim.fn.executable("oxlint") == 1 then
    table.insert(typescript, "oxlint")
  end
  if vim.fn.executable("eslint") == 1 then
    table.insert(typescript, "eslint")
  end

  lint.linters_by_ft = {
    c = cpp,
    cmake = cmake,
    cpp = cpp,
    javascript = typescript,
    javascriptreact = typescript,
    pgsql = { "sqlfluff", },
    sh = { "shellcheck", },
    terraform = { "terraform-validate", "tfsec", },
    typescript = typescript,
    typescriptreact = typescript,
    vue = typescript,
  }

  vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
    pattern = "*",
    callback = function()
      lint.try_lint()
    end
  })
end

return M

local M = {}

M.setup = function()
  local formatter = require("formatter")
  local util = require("formatter.util")

  local prettier = function()
    return {
      exe = "prettier",
      args = {
        "--stdin-filepath",
        util.escape_path(util.get_current_buffer_file_path()),
      },
      stdin = true,
      try_node_modules = true,
      -- INFO: resolves issues when trying to load prettier plugins that are installed in a monorepo package.
      cwd = util.get_current_buffer_file_dir()
    }
  end

  formatter.setup({
    filetype = {
      -- TODO: sqlfluff
      c = { require("formatter.filetypes.c").clangformat },
      cpp = { require("formatter.filetypes.cpp").clangformat },
      css = { prettier },
      html = { prettier },
      java = { prettier },
      javascript = { prettier },
      javascriptreact = { prettier },
      json = { prettier },
      jsonc = { prettier },
      markdown = { prettier },
      nix = { require("formatter.filetypes.nix").nixpkgs_fmt },
      python = { require("formatter.filetypes.python").black },
      scss = { prettier },
      typescript = { prettier },
      typescriptreact = { prettier },
      xml = { prettier },
      yaml = { prettier },
    }
  })
end

return M

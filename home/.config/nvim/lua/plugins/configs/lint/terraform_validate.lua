local Path = require("plenary.path")

--- @type table<string, integer>
local SEVERITY_MAP = {
  error = vim.diagnostic.severity.ERROR,
  warning = vim.diagnostic.severity.WARN,
}

--- @type lint.Linter
return {
  name = "terraform-validate",
  cmd = "terraform",
  args = { "validate", "-json" },
  stdin = false,
  append_fname = false,

  parser = function(output, bufnr, linter_cwd)
    local ok, json = pcall(vim.json.decode, output)
    if not ok or json == nil then
      --- @type Diagnostic[]
      return { {
        buffer = bufnr,
        lnum = 0,
        col = 0,
        severity = vim.diagnostic.severity.ERROR,
        message = "Could not execute `terraform validate`: unexpected output",
        _tags = {},
      } }
    end

    --- @type Diagnostic[]
    local diagnostics = {}
    local filename = Path:new(vim.api.nvim_buf_get_name(bufnr)):absolute()
    local format_version = json.format_version

    if format_version == "1.0" then
      if json.valid == true then return diagnostics end

      for _, el in pairs(json.diagnostics) do
        if Path:new(linter_cwd, el.range.filename):absolute() == filename then
          --- @type Diagnostic
          local dia = {
            buffer = bufnr,
            lnum = el.range.start.line - 1,
            col = el.range.start.column - 1,
            end_lnum = el.range["end"].line - 1,
            end_col = el.range["end"].column - 1,
            severity = SEVERITY_MAP[el.severity] or vim.diagnostic.severity.INFO,
            message = el.summary .. ": " .. el.detail,
            source = "terraform-validate",
            _tags = {}
          }

          table.insert(diagnostics, dia)
        end
      end

      return diagnostics
    end

    --- @type Diagnostic[]
    return { {
      buffer = bufnr,
      lnum = 0,
      col = 0,
      severity = vim.diagnostic.severity.ERROR,
      message = "Unsupported `terraform validate` format version `" .. format_version .. "`",
      _tags = {},
    } }
  end
}

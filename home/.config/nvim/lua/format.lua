local OPTION = "autoformat"
local M = {}

M.toggle_format = function()
  vim.g[OPTION] = not (vim.g[OPTION] ~= false)
  vim.notify("autoformat=" .. vim.inspect(vim.g[OPTION]), vim.log.levels.INFO)
end

M.toggle_format_buf = function()
  vim.b[OPTION] = not (vim.b[OPTION] ~= false)
  vim.notify("autoformat=" .. vim.inspect(vim.b[OPTION]), vim.log.levels.INFO)
end

M.format = function()
  local util = require(".util")

  -- skip formatting if disabled
  if vim.g[OPTION] == false or vim.b[OPTION] == false then
    return
  end

  -- collect information about the current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local bufft = vim.bo[bufnr].filetype
  local lsp_clients = vim.lsp.get_clients({ bufnr = bufnr })
  local formatters = require("formatter.util").get_available_formatters_for_ft(bufft)

  -- format
  local force_lsp = util.lsp_has_client(lsp_clients, "biome")

  -- format using formatter.nvim
  if #formatters > 0 and not force_lsp then
    -- print("autoformat: formatter.nvim")
    vim.api.nvim_exec2("FormatWriteLock", {})
    return
  end

  -- format using lsp
  if #lsp_clients > 0 then
    -- print("autoformat: lsp")
    vim.lsp.buf.format()
    return
  end

  -- cannot format
  -- print("autoformat: no")
end

vim.api.nvim_create_user_command("ToggleFormat", M.toggle_format, {})
vim.api.nvim_create_user_command("ToggleFormatBuf", M.toggle_format_buf, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*" },
  callback = M.format,
})

return M

local M = {}

--- @param clients vim.lsp.Client[]
--- @param client_name string
--- @return boolean
M.lsp_has_client = function(clients, client_name)
  for _, client in pairs(clients) do
    if client.name == client_name then
      return true
    end
  end

  return false
end

return M

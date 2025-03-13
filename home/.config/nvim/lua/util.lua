local M = {}

---@param str string
---@param prefix string
---@return boolean
function M.starts_with(str, prefix)
	return str:sub(1, #prefix) == prefix
end

return M

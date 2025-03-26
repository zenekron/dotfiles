local M = {}

--- Lazy require that resolves when the module is indexed.
---
---@param module string
function M.requirei(module)
	return setmetatable({}, {
		__index = function(_, key)
			return require(module)[key]
		end,
	})
end

---@param module string
---@param path unknown[]
local function __requirek(module, path)
	return setmetatable({}, {
		__index = function(_, key)
			local new_path = vim.list_extend({}, path)
			table.insert(new_path, key)

			return __requirek(module, new_path)
		end,

		__call = function(_, ...)
			local args = { ... }
			return function()
				local fn = require(module)
				for _, p in pairs(path) do
					fn = fn[p]
				end

				fn(unpack(args))
			end
		end,
	})
end

--- Lazy require that resolves when a function is called.
--- Invoking a function creates a no-args wrapper which is especially useful for lazy keybinds.
---
--- ```lua
--- local module = requirek("module")
--- local fn = module.func({ foo = "bar" })
--- fn() -- requires `module` and invokes `module.func` with arguments { foo = "bar" }
--- ```
---
---@param module string
function M.requirek(module)
	return __requirek(module, {})
end

return M

-- https://github.com/ollama/ollama/blob/main/docs/api.md#generate-a-completion
-- https://github.com/yetone/avante.nvim/issues/1149
-- TODO: tool support

local M = {}

---@class OllamaChatRequest
---@field model string
---@field messages OllamaChatMessage[]
---@field format? string
---@field options? table<string, any>
---@field stream? boolean
---@field keep_alive? any

---@class OllamaChatMessage
---@field role OllamaChatMessageRole
---@field content string
---@field images? string[]

---@alias OllamaChatMessageRole "system" | "user" | "assistant" | "tool"

---@class OllamaChatResponse
---@field model? string
---@field created_at? string
---@field message? OllamaChatMessage
---@field done_reason? string
---@field done? boolean
---@field total_duration? number
---@field load_duration? number
---@field prompt_eval_count? number
---@field prompt_eval_duration? number
---@field eval_count? number
---@field eval_duration? number



---@type table<"user" | "assistant", OllamaChatMessageRole>
local avante_role_to_ollama = {
  assistant = "assistant",
  user = "user",
}



---@type AvanteCurlArgsParser
M.parse_curl_args = function(provider, prompt_opts)
  ---@type OllamaChatRequest
  local request = {
    model = provider.model,
    messages = {
      { role = "system", content = prompt_opts.system_prompt },
    },

    options = provider.options or {},
    stream = true,
  }

  ---@type string[]
  local images = {}
  for _, image_path in ipairs(prompt_opts.image_paths or {}) do
    local base64_content = vim.fn.system(string.format("base64 -w 0 %s", image_path)):gsub("\n", "")
    table.insert(images, "data:image/png;base64," .. base64_content)
  end

  for _, message in ipairs(prompt_opts.messages or {}) do
    if avante_role_to_ollama[message.role] == nil then
      vim.notify("Unsupported Avante role: " .. message.role, vim.log.levels.ERROR)
      goto continue
    end

    table.insert(
      request.messages,
      ---@type OllamaChatMessage
      {
        role = avante_role_to_ollama[message.role],
        content = message.content or "",
        -- should this field only be present when #images > 0?
        images = images,
      }
    )

    ::continue::
  end

  ---@type AvanteCurlOutput
  return {
    url = provider.endpoint .. "/api/chat",
    headers = {
      ["Accept"] = "application/json",
      ["Content-Type"] = "application/json",
    },
    body = request,
  }
end

---@type AvanteStreamParser
M.parse_stream_data = function(line, handler_opts)
  ---@type OllamaChatResponse
  local data = vim.fn.json_decode(line)
  if not data then
    return
  end

  if data.message and data.message.content and data.message.content ~= "" then
    handler_opts.on_chunk(data.message.content)
  end

  if data.done then
    handler_opts.on_stop({ reason = data.done_reason or "stop" })
  end
end



return M

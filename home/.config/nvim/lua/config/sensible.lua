-- A place for all the stuff I really wish I didn't have to configure myself.

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Highlight references of the word under the cursor
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("highlight-word-lsp-attach", { clear = true }),
	desc = "Highlight references of the word under the cursor",
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		if not client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, { bufnr = event.buf }) then
			return
		end

		local group = vim.api.nvim_create_augroup("highlight-word-lsp", { clear = false })

		-- highlight on hold
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = group,
			buffer = event.buf,
			callback = vim.lsp.buf.document_highlight,
		})

		-- clear highlight on move
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = group,
			buffer = event.buf,
			callback = vim.lsp.buf.clear_references,
		})
	end,
})
vim.api.nvim_create_autocmd("LspDetach", {
	group = vim.api.nvim_create_augroup("highlight-word-lsp-detach", { clear = true }),
	callback = function(event)
		vim.lsp.buf.clear_references()
		vim.api.nvim_clear_autocmds({ group = "highlight-word-lsp", buffer = event.buf })
	end,
})

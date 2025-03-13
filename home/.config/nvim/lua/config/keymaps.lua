local map = vim.keymap.set

-- switch back and forth between buffers
map("n", "<leader><leader>", "<c-^>", { desc = "Go to the last buffer" })

--
-- Splits & Tabs
--

-- navigate splits
map("n", "<c-h>", "<c-w><c-h>", { desc = "Move focus to the left split" })
map("n", "<c-l>", "<c-w><c-l>", { desc = "Move focus to the right split" })
map("n", "<c-j>", "<c-w><c-j>", { desc = "Move focus to the lower split" })
map("n", "<c-k>", "<c-w><c-k>", { desc = "Move focus to the upper split" })

-- resize splits
map("n", "<m-j>", "<cmd>resize -2<cr>", { desc = "Decrease horizontal split size" })
map("n", "<m-k>", "<cmd>resize +2<cr>", { desc = "Increase horizontal split size" })
map("n", "<m-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease vertical split size" })
map("n", "<m-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase vertical split size" })

-- navigate tabs
map("n", "<leader><tab>", "<cmd>tabnext<cr>", { desc = "Move focus to the next tab" })
map("n", "<leader><s-tab>", "<cmd>tabNext<cr>", { desc = "Move focus to the previous tab" })
map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "Close the focused tab" })
map("n", "<leader>1", "1gt", { desc = "Move focus to the tab 1" })
map("n", "<leader>2", "2gt", { desc = "Move focus to the tab 2" })
map("n", "<leader>3", "3gt", { desc = "Move focus to the tab 3" })
map("n", "<leader>4", "4gt", { desc = "Move focus to the tab 4" })
map("n", "<leader>5", "5gt", { desc = "Move focus to the tab 5" })
map("n", "<leader>6", "6gt", { desc = "Move focus to the tab 6" })
map("n", "<leader>7", "7gt", { desc = "Move focus to the tab 7" })
map("n", "<leader>8", "8gt", { desc = "Move focus to the tab 8" })
map("n", "<leader>9", "9gt", { desc = "Move focus to the tab 9" })

--
-- Search
--

-- center search results
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- clear search highlights when pressing esc
map("n", "<esc>", "<cmd>nohlsearch<cr>")

--
-- LSP
--

-- diagnostics
map("n", "<leader>d", vim.diagnostic.setloclist)
map("n", "<leader>D", vim.diagnostic.open_float)
map("n", "[g", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]g", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- docs/info
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>K", vim.lsp.buf.signature_help)

-- goto
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })

-- actions
map({ "n", "x" }, "<leader>ac", vim.lsp.buf.code_action, { desc = "Code action" })
map({ "n", "x" }, "<leader>ff", vim.lsp.buf.format, { desc = "Format" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- workspace
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add folder to workspace" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove folder from workspace" })
map("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })

-- symbols
map("n", "<leader>o", vim.lsp.buf.document_symbol)
map("n", "<leader>s", vim.lsp.buf.workspace_symbol)

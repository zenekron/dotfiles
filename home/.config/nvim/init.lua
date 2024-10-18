vim.g.mapleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



--
-- Plugins
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "plugins" } }, {
  change_detection = {
    notify = false,
  },
})



--
-- Options
--

-- enable mouse
vim.o.mouse = "a"

-- use the system clipboard
vim.o.clipboard = "unnamedplus"

-- case insensitive search unless capitals in search string
vim.o.ignorecase = true
vim.o.smartcase = true

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- enable signcolumn
vim.o.signcolumn = "yes"

-- decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- keep N lines around the cursor
vim.o.scrolloff = 8

-- prevent word-wrap
vim.wo.wrap = false

-- open new splits to right/bottom
vim.o.splitbelow = true
vim.o.splitright = true

-- disable swap and backup files
vim.bo.swapfile = false
vim.go.backup = false
vim.go.writebackup = false

-- look and style
vim.o.colorcolumn = "80"
vim.o.listchars = "tab:»\\ ,trail:·"
vim.o.background = "dark"
vim.o.termguicolors = true



--
-- Keys
--

local format = require(".format")
vim.keymap.set("n", "<leader>fa", format.toggle_format, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fb", format.toggle_format_buf, { noremap = true, silent = true })



--
-- Keys
--

-- switch back and forth between buffers
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- center search results
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })

-- use <c-e> in terminal buffers to go back to normal mode
vim.keymap.set("t", "<C-E>", "<C-\\><C-N>")

-- pane navigation
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true, silent = true })

-- pane resizing
vim.keymap.set("n", "<M-j>", "<cmd>resize -2<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-k>", "<cmd>resize +2<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-h>", "<cmd>vertical resize -2<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-l>", "<cmd>vertical resize +2<cr>", { noremap = true, silent = true })

-- tab navigation
vim.keymap.set("n", "<leader><Tab>", "<cmd>tabnext<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><S-Tab>", "<cmd>tabNext<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>1", "1gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>2", "2gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>3", "3gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>4", "4gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>5", "5gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>6", "6gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>7", "7gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>8", "8gt", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>9", "9gt", { noremap = true, silent = true })

-- filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tf",
  callback = function(event)
    vim.bo[event.buf].filetype = "terraform"
  end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".envrc",
  callback = function(event)
    vim.bo[event.buf].filetype = "bash"
  end
})

-- highlighted yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = { "*" },
  callback = vim.highlight.on_yank
})

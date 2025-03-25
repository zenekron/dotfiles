-- https://github.com/nvim-lua/kickstart.nvim/tree/38f4744e254af1b2ce5384d66d7c7da3b5f67106

-- use `<space>` as the `<leader>` key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---@type string
vim.g.colorscheme = "catppuccin-frappe"
---@type boolean
vim.g.nerd_font = true

---@type nil | "blink" | "cmp"
vim.g.complete = "blink"
---@type nil | "luasnip"
vim.g.snippet = "luasnip"
---@type nil | "conform"
vim.g.format = "conform"
---@type nil | "lint"
vim.g.lint = "lint"

---@type nil | "bufferline"
vim.g.bufferline = "bufferline"
---@type nil | "nvim-tree"
vim.g.file_tree = "nvim-tree"
---@type nil | "snacks"
vim.g.input = "snacks"
---@type nil | "fidget"
vim.g.notify = "fidget"
---@type nil | "telescope"
vim.g.picker = "telescope"
---@type nil | "telescope"
vim.g.select = "telescope"
---@type nil | "lualine"
vim.g.statusline = "lualine"

--
-- Options
--

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- enable mouse (especially useful for resizing splits)
vim.opt.mouse = "a"

--! -- Don't show the mode, since it's already in the status line
if vim.g.statusline ~= nil then
	vim.opt.showmode = false
end

-- use the system clipboard (delayed to improve startup-time)
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Disable word wrap by default
vim.opt.wrap = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- case insensitive searching unless one or more capital letters in the search string
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- always show sign column
vim.opt.signcolumn = "yes"

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- open splits to the right/bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- display whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- show which line your cursor is on
vim.opt.cursorline = true

-- keep N lines around the cursor
vim.opt.scrolloff = 8

-- Always show the popup menu and do not insert text until an option is selected.
vim.opt.completeopt = "menu,menuone,noinsert"

--
-- Plugins
--

require("config.sensible")

require("config.keymaps")

require("config.lazy")

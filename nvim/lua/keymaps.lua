-- leader key
vim.g.mapleader = " "
-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Terminal
vim.keymap.set("n", "<leader>to", "<cmd>:sp|te<CR>:resize 11<CR>", opts)

-----------------
-- Visual mode --
-----------------

--- Telescope
vim.keymap.set("n", "<leader>sf", ":Telescope file_browser<CR>", opts)
vim.keymap.set("n", "<leader>st", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>lw", ":Telescope diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>sb", ":Telescope buffers<CR>", opts)

-- LSP
local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set("n", "<space>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
vim.keymap.set("n", "<space>f", function()
	vim.lsp.buf.format({ async = true })
end, bufopts)

-- diagnostics
vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

-- Formatters/linters
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	local conform = require("conform")
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (in visual mode)" })

-- NeoTree
vim.keymap.set("n", "<leader>d", ":Neotree toggle<CR>", opts)

-- Debug
vim.keymap.set("n", "<leader>gt", ":GoBreakToggle<CR>", bufopts)

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

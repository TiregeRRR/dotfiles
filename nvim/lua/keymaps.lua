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

-- Formatters/linters
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	local conform = require("conform")
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (in visual mode)" })

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

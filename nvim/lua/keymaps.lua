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

-- Window management
vim.keymap.set("n", "<leader>w", "", { desc = "Window", unpack(opts) })
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height", unpack(opts) })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height", unpack(opts) })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width", unpack(opts) })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width", unpack(opts) })

-- Terminal
vim.keymap.set("n", "<leader>t", "", { desc = "Terminal", unpack(opts) })
vim.keymap.set(
	"n",
	"<leader>to",
	"<cmd>:sp|te<CR>:resize 11<CR>",
	{ desc = "Open terminal in horizontal split", unpack(opts) }
)

--- Telescope
vim.keymap.set("n", "<leader>s", "", { desc = "Search", unpack(opts) })
vim.keymap.set("n", "<leader>sf", ":Telescope file_browser<CR>", { desc = "Browse files with Telescope", unpack(opts) })
vim.keymap.set("n", "<leader>st", ":Telescope live_grep<CR>", { desc = "Search text in project", unpack(opts) })
vim.keymap.set("n", "<leader>lw", ":Telescope diagnostics<CR>", { desc = "List workspace diagnostics", unpack(opts) })
vim.keymap.set("n", "<leader>sb", ":Telescope buffers<CR>", { desc = "Search open buffers", unpack(opts) })

-- LSP
vim.keymap.set("n", "<leader>l", "", { desc = "LSP", unpack(opts) })
local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", unpack(bufopts) })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", unpack(bufopts) })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information", unpack(bufopts) })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", unpack(bufopts) })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help", unpack(bufopts) })
vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder", unpack(bufopts) })
vim.keymap.set(
	"n",
	"<space>wr",
	vim.lsp.buf.remove_workspace_folder,
	{ desc = "Remove workspace folder", unpack(bufopts) }
)
vim.keymap.set("n", "<space>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders", unpack(bufopts) })
vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { desc = "Go to type definition", unpack(bufopts) })
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol", unpack(bufopts) })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", unpack(bufopts) })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references", unpack(bufopts) })
vim.keymap.set("n", "<space>f", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer", unpack(bufopts) })

-- diagnostics
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open float diagnostics window" })

-- Formatters/linters
vim.keymap.set("n", "<leader>m", "", { desc = "Format", unpack(opts) })
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	local conform = require("conform")
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (in visual mode)" })

-- File explorer
vim.keymap.set("n", "<leader>e", "", { desc = "Explorer", unpack(opts) })
vim.keymap.set("n", "<leader>d", ":lua MiniFiles.open()<CR>", { desc = "Toggle file explorer", unpack(opts) })

-- Git
local gitsigns = require("gitsigns")
vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk)
vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)

-- Open external
vim.keymap.set("n", "<leader>o", "", { desc = "Open external", unpack(opts) })
vim.keymap.set("n", "<leader>oc", "<cmd>:!cursor ./<CR>", { desc = "Open in VS Code", unpack(bufopts) })

-- Debug
vim.keymap.set("n", "<leader>g", "", { desc = "Debug", unpack(opts) })
vim.keymap.set("n", "<leader>gt", ":GoBreakToggle<CR>", { desc = "Toggle breakpoint", unpack(bufopts) })

-- Visual mode indentation
vim.keymap.set("v", "<", "<gv", { desc = "Decrease indent and reselect", unpack(opts) })
vim.keymap.set("v", ">", ">gv", { desc = "Increase indent and reselect", unpack(opts) })

-- Code Action
vim.keymap.set("n", "<leader>c", "", { desc = "Code Action", unpack(opts) })

--diffview
vim.keymap.set(
	"n",
	"gF",
	'require("diffview.config").actions.goto_file',
	{ desc = "Open file in diffview", unpack(opts) }
)

-- gitlab
vim.keymap.set(
	"n",
	"<leader>rc",
	':lua require("gitlab").choose_merge_request()<CR>',
	{ desc = "Choose merge request", unpack(bufopts) }
)

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

local function open_today_note()
	local date = os.date("%Y-%m-%d")
	local path = vim.fn.expand("~/notes/daily/" .. date .. ".md")
	vim.cmd("edit " .. path)
	if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
		vim.fn.setline(1, "# " .. date)
	end
end

vim.keymap.set("n", "<leader>tn", open_today_note, { desc = "Today note" })

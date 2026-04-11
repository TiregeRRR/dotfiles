if vim.g.vscode then
	return
end

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"pylsp",
		"lua_ls",
		"rust_analyzer",
	},
	automatic_enable = false,
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(args)
		vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
	end,
})

vim.lsp.config("pylsp", {
	filetypes = { "python" },
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.lsp.config("clangd", {
	filetypes = { "c", "cpp" },
})

for _, server in ipairs({
	"pylsp",
	"rust_analyzer",
	"lua_ls",
	"clangd",
	"golangci_lint_ls",
}) do
	vim.lsp.enable(server)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("go").setup({
	lsp_cfg = {
		capabilities = capabilities,
	},
})

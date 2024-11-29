local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		go = { "gofumpt", "goimports", "gci" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
	formatters = {
		gci = {
			args = {
				"write",
				"--skip-generated",
				"--section",
				"standard",
				"--section",
				"prefix(git.mobiledep.ru)",
				"--section",
				"default",
				"--section",
				"blank",
				"--section",
				"dot",
				"--section",
				"alias",
				"--custom-order",
				"$FILENAME",
			},
		},
	},
})

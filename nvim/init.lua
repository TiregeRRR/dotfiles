require("options")

require("plugins")
require("colorscheme")
require("lsp")
require("keymaps")

if vim.g.neovide then
	vim.o.guifont = "JetBrains Mono:h11"
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_scroll_animation_length = 0
end

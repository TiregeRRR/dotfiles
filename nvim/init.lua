require("options")

require("plugins")
require("colorscheme")
require("lsp")
require("keymaps")

local function current_gui_font()
	local ok, theme = pcall(require, "theme.generated")
	local family = "Pixel Code"
	local size = "11"

	if ok and theme.fonts then
		family = theme.fonts.mono or family
		size = theme.fonts.nvim_gui_size or size
	end

	return string.format("%s:h%s", family, size)
end

vim.o.guifont = current_gui_font()
if vim.g.neovide then
	vim.o.guifont = current_gui_font()
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_scroll_animation_length = 0
end

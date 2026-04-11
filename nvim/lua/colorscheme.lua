local M = {}

local theme_file = vim.fn.stdpath("config") .. "/lua/theme/generated.lua"
local last_theme_mtime = 0

local function theme_mtime()
	local stat = (vim.uv or vim.loop).fs_stat(theme_file)
	if not stat or not stat.mtime then
		return 0
	end

	if type(stat.mtime) == "table" and stat.mtime.sec then
		return stat.mtime.sec
	end

	return 0
end

local function load_theme()
	package.loaded["theme.generated"] = nil

	local ok, theme = pcall(require, "theme.generated")
	if not ok then
		return {
			name = "Tokyo Night",
			colorscheme = "tokyonight-night",
		}
	end

	return theme
end

function M.apply()
	local theme = load_theme()
	local is_ok, _ = pcall(vim.cmd, "colorscheme " .. theme.colorscheme)
	if not is_ok then
		vim.notify("colorscheme " .. theme.colorscheme .. " not found!")
		return
	end

	vim.g.desktop_theme_name = theme.name
	vim.g.desktop_theme_lualine = theme.lualine or {}

	pcall(function()
		require("config.lualine").apply()
	end)

	last_theme_mtime = theme_mtime()
end

M.apply()

vim.api.nvim_create_autocmd({ "FocusGained", "TermEnter" }, {
	group = vim.api.nvim_create_augroup("DesktopThemeReload", { clear = true }),
	callback = function()
		local current_mtime = theme_mtime()
		if current_mtime ~= 0 and current_mtime ~= last_theme_mtime then
			M.apply()
		end
	end,
})

return M

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
_Gopts = {
	position = "center",
	hl = "Type",
	wrap = "overflow",
}

local function load_random_header()
	math.randomseed(os.time())
	local header_folder = "/home/utsuro/.config/nvim/lua/config/startup_images"
	local files = vim.fn.globpath(header_folder, "*.lua", true, true)
	if #files == 0 then
		return nil
	end
	-- local random_file = files[math.random(#files)]
	local module_name = "config.startup_images." .. "blue_eyed"
	return require(module_name).header
end

local function change_header()
	local new_header = load_random_header()
	if new_header then
		dashboard.config.layout[2] = new_header
		vim.cmd("AlphaRedraw")
	else
		print("Header files are missing from the folder header_img.")
	end
end

-- Inicjalne załadowanie nagłówka
local header = load_random_header()
if header then
	dashboard.config.layout[2] = header
else
	print("Header files are missing from the folder header_img.")
end

dashboard.section.buttons.val = {

	dashboard.button("<C-d>", "󱓧  Open daily-notes", ":ObsidianToday<CR>"),
	dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy update<CR>"),
	dashboard.button("c", "  Settings", ":e $HOME/.config/nvim/init.lua<CR>"),
	dashboard.button("p", "  Projects", ":e $HOME/projects <CR>"),
	dashboard.button("d", "󱗼  Dotfiles", ":e $HOME/dotfiles <CR>"),
}

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	desc = "Add Alpha dashboard footer",
	once = true,
	callback = function()
		local stats = require("lazy").stats()
		local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
		dashboard.section.footer.val =
			{ " ", " ", " ", " Loaded " .. stats.count .. " plugins  in " .. ms .. " ms " }
		dashboard.section.header.opts.hl = "DashboardFooter"
		pcall(vim.cmd.AlphaRedraw)
	end,
})

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

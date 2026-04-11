local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- colorscheme
	{
		"killitar/obscure.nvim",
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"folke/tokyonight.nvim",
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		cond = function()
			return not vim.g.vscode
		end,
	},
	"AlexvZyl/nordic.nvim",
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},
	-- auto-completion
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		cond = function()
			return not vim.g.vscode
		end,
	},
	-- mason
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"neovim/nvim-lspconfig",
		cond = function()
			return not vim.g.vscode
		end,
	},
	-- icons
	{
		"onsails/lspkind.nvim",
		cond = function()
			return not vim.g.vscode
		end,
	},
	-- fzf
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("config.telescope")
		end,
	},
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
		cond = function()
			return not vim.g.vscode
		end,
	},
	-- formatter
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.conform")
		end,
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("config.nvim-surround")
		end,
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		config = function()
			require("config.nvim-treesitter-textobjects")
		end,
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"MunifTanjim/nui.nvim",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.lualine")
		end,
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("config.gonvim")
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = {
			"echasnovski/mini.icons",
			"nvim-lua/plenary.nvim",
		},
		event = "VimEnter",
		config = function()
			require("config.alpha")
		end,
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"sindrets/diffview.nvim",
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		priority = 999, -- Load before other plugins
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
		keys = {
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"b",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"w",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			-- ...
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
		},
		config = function()
			require("config.nvim-cmp")
		end,
		cond = function()
			return not vim.g.vscode
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.gitsigns")
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		event = "VeryLazy",
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "work",
					path = "~/neoconserva",
				},
			},
		},
	},
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			require("window-picker").setup()
		end,
	},
	{
		"harrisoncramer/gitlab.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
			"nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
		},
		build = function()
			require("gitlab.server").build(true)
		end, -- Builds the Go binary
		config = function()
			require("gitlab").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				scope = { enabled = false },
			})
		end,
	},
	{
		"nvim-mini/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup()
		end,
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			config = function()
				require("aerial").setup({
					-- optionally use on_attach to set keymaps when aerial has attached to a buffer
					on_attach = function(bufnr)
						-- Jump forwards/backwards with '{' and '}'
						vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
						vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
					end,
				})
			end,
		},
	},
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
})

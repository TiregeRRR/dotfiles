local config = require("nvim-treesitter.configs")

config.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "go", "rust" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })

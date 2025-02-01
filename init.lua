-- The file that Nvim reads at startup To keep things organised, split config into multiple files (in the ./lua folder)
-- This file is used to import all the files in the configuration
--
-- Set leader key
-- Important to run before plugins and keymaps
vim.g.mapleader = " "

-- NvimTree: disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("plugins") -- Plugin options (run before keymaps)
require("lsp") -- Language Server Protocol configs
require("options") -- Global options
require("keymaps") -- Keymap options
require("autocmds") -- Auto-commands

require("oil").setup()

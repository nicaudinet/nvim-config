-- The file that Nvim reads at startup
-- To keep things organised, split config into multiple files (in the ./lua folder)
-- This file is used to import all the files in the configuration

-- NvimTree: disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('plugins') -- Plugin options (run before keymaps)
require('options') -- Global options
require('keymaps') -- Keymap options

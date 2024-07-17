-- Configuration for global options

-- Use :h <option_name> for information about options

--  Mouse options
vim.opt.mouse = "a"

-- Tab options
tabsize = 4
vim.opt.tabstop = tabsize
vim.opt.softtabstop = tabsize
vim.opt.shiftwidth = tabsize
vim.opt.expandtab = true

-- UI options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Text width
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80

-- Scroll options
vim.opt.scrolloff = 8

-- Search options
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- NvimTree options
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups

-- Folding markdown
vim.g.markdown_folding = 1

-- Filetype detection
vim.opt.filetype = "on"

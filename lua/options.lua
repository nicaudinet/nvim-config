-- Configuration for global options

-- Use :h <option_name> for information about options

--  Mouse options
vim.opt.mouse = 'a'

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
vim.opt.colorcolumn = "80"

-- Search options
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- NvimTree options
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups

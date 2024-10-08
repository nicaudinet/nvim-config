-- Configuration for global options

-- Use :h <option_name> for information about options

--  Mouse options
vim.opt.mouse = "a"

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
vim.opt.scrolloff = 2

-- Search options
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- NvimTree options
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups

-- Filetype detection
vim.opt.filetype = "on"

-- Tab options
local tabsize = 4
vim.opt.tabstop = tabsize
vim.opt.softtabstop = tabsize
vim.opt.shiftwidth = tabsize
vim.opt.expandtab = true

-- Use treesitter for folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Start files unfolded
vim.opt.foldlevel = 10
vim.opt.foldlevelstart = 10

-- Only nest up to 4 folds deep
vim.opt.foldnestmax = 4

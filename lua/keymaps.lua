-- Configuration for the key mappings

-- define common options for file
local opts = {
  noremap = true, -- non-recursive
  silent = true, -- do not show message
}

-------------------
-- Open Settings --
-------------------

-- Open init file (leader-open-init)
vim.keymap.set("n", "<Leader>oi", ":e ~/.config/nvim/init.lua<CR>", opts)
-- Open keymap file (leader-open-keymaps)
vim.keymap.set("n", "<Leader>ok", ":e ~/.config/nvim/lua/keymaps.lua<CR>", opts)
-- Open plugin file (leader-open-plugins)
vim.keymap.set("n", "<Leader>op", ":e ~/.config/nvim/lua/plugins.lua<CR>", opts)
-- Open options file (leader-open-options)
vim.keymap.set("n", "<Leader>oo", ":e ~/.config/nvim/lua/options.lua<CR>", opts)
-- Open the LSP (leader-open-lsp)
vim.keymap.set("n", "<Leader>ol", ":e ~/.config/nvim/lua/lsp.lua<CR>", opts)
-- Open the lazy.nvim menu (leader-open-lazy.nvim)
vim.keymap.set("n", "<Leader>oL", ":Lazy<CR>", opts)
-- Open Mason (stands for leader-open-Mason)
vim.keymap.set("n", "<Leader>oM", ":Mason<CR>", opts)

-----------------
-- Add Keymaps --
-----------------

-- Add key mapping for normal mode
vim.keymap.set("n", "<Leader>kn", 'ivim.keymap.set("n", "", "", opts)<Esc>Fn2f"a')
-- Add key mapping for visual mode
vim.keymap.set("n", "<Leader>kv", "ivim.keymap.set('v', '', '', opts)<Esc>Fn2f'a")

-----------------
-- Normal Mode --
-----------------

-- Check health
vim.keymap.set("n", "<Leader>ch", ":checkhealth<CR>", opts)

-------------
-- Windows --
-------------

-- Set main window shortcut
vim.keymap.set("n", "<Leader>w", "<C-w>", opts)
-- Use <C-\><C-n> before <C-w> so that window commands also work from terminal
vim.keymap.set("t", "<Leader>w", "<C-\\><C-n><C-w>", opts)

---------------
-- Scrolling --
---------------

-- Scroll up
vim.keymap.set("n", "<C-k>", "<C-u>zz", opts)
-- Scroll down
vim.keymap.set("n", "<C-j>", "<C-d>zz", opts)

-------------
-- Buffers --
-------------

-- Create a new buffer
vim.keymap.set("n", "<Leader>bn", ":enew<CR>", opts)
-- Edit a file
vim.keymap.set("n", "<Leader>be", ":e ", opts)
-- Close a buffer
vim.keymap.set("n", "<Leader>bd", ":bd<CR>", opts)
-- Close all buffers except the current one
vim.keymap.set("n", "<Leader>bo", ":BufOnly<CR>", opts)
-- Next buffer
vim.keymap.set("n", "<Leader><Tab>", ":bnext<CR>", opts)
-- Previous buffer
vim.keymap.set("n", "<Leader><S-Tab>", ":bprev<CR>", opts)

---------------
-- Telescope --
---------------

local telescope = require("telescope.builtin")

-- Open find menu
vim.keymap.set("n", ";", telescope.find_files, opts)
-- Find files
vim.keymap.set("n", "<Leader>ff", telescope.find_files, opts)
-- Search through directory (ripgrep)
vim.keymap.set("n", "<Leader>fg", telescope.live_grep, opts)
-- Search through buffers
vim.keymap.set("n", "<Leader>fb", telescope.buffers, opts)
-- Search through registers
vim.keymap.set("n", "<Leader>fr", telescope.registers, opts)
-- Search through help tags
vim.keymap.set("n", "<Leader>fh", telescope.help_tags, opts)
-- Search through key maps
vim.keymap.set("n", "<Leader>fk", telescope.keymaps, opts)

----------------------
-- File navigation  --
----------------------

-- Open Oil.nvim in a floating window
vim.keymap.set("n", "-", ":Oil --float<CR>", opts)

-----------
-- LaTeX --
-----------

-- Single-shot compilation
vim.keymap.set("n", "<Leader>ll", ":w<CR>:VimtexCompileSS<CR>", opts)
-- Toggle continuous compilation
vim.keymap.set("n", "<Leader>ls", ":w<CR>:VimtexCompile<CR>", opts)

--------------------
-- vim.diagnostic --
--------------------

-- Go to next warning / error (leader-goto-next)
vim.keymap.set("n", "<Leader>gn", vim.diagnostic.goto_next, opts)
-- Go to next warning / error (leader-goto-previous)
vim.keymap.set("n", "<Leader>gp", vim.diagnostic.goto_prev, opts)

-----------------
-- Tree-sitter --
-----------------

-- Other commands defined in the Tree-sitter plugin options

-- Inspect the tree
vim.keymap.set("n", "<Leader>ti", ":InspectTree<CR>", opts)

-- Edit query
vim.keymap.set("n", "<Leader>tq", vim.treesitter.query.edit, opts)

--------------
-- Zen Mode --
--------------

zenmode = require("zen-mode")
vim.keymap.set("n", "<Leader>Z", zenmode.toggle, opts)

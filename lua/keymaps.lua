-- Configuration for the key mappings

-- define common options for file
local opts = {
  noremap = true, -- non-recursive
  silent = true, -- do not show message
}

----------------------
-- Editing Settings --
----------------------

-- Open keymap file (leader-open-keymaps)
vim.keymap.set("n", "<Leader>ok", ":e ~/.config/nvim/lua/keymaps.lua<CR>", opts)
-- Add key mapping for normal mode
vim.keymap.set("n", "<Leader>kn", "ivim.keymap.set('n', '', '', opts)<Esc>Fn2f'a")
-- Add key mapping for visual mode
vim.keymap.set("n", "<Leader>kv", "ivim.keymap.set('v', '', '', opts)<Esc>Fn2f'a")
-- Open plugin file (leader-open-plugins)
vim.keymap.set("n", "<Leader>op", ":e ~/.config/nvim/lua/plugins.lua<CR>", opts)
-- Open the lazy.nvim menu (leader-open-lazy.nvim)
vim.keymap.set("n", "<Leader>oL", ":Lazy<CR>", opts)
-- Open options file (leader-open-options)
vim.keymap.set("n", "<Leader>oo", ":e ~/.config/nvim/lua/options.lua<CR>", opts)
-- Open init file (leader-open-init)
vim.keymap.set("n", "<Leader>oi", ":e ~/.config/nvim/init.lua<CR>", opts)
-- Open LSP file (leader-open-lsp)
vim.keymap.set("n", "<Leader>ol", ":e ~/.config/nvim/lua/lsp.lua<CR>", opts)

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

-- Set mapping functions for neoscroller
-- Syntax: t[keys] = {function, {function arguments}}
local mappings = {}
mappings["<C-k>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } }
mappings["<C-j>"] = { "scroll", { "vim.wo.scroll", "true", "100" } }
mappings["<C-y>"] = { "scroll", { "-0.10", "false", "50" } }
mappings["<C-e>"] = { "scroll", { "0.10", "false", "50" } }
mappings["zt"] = { "zt", { "100" } }
mappings["zz"] = { "zz", { "100" } }
mappings["zb"] = { "zb", { "100" } }
require("neoscroll.config").set_mappings(mappings)

-------------
-- Buffers --
-------------

-- Create a new buffer
vim.keymap.set("n", "<Leader>bn", ":enew<CR>", opts)
-- Edit a file
vim.keymap.set("n", "<Leader>be", ":e ", opts)
-- Close a buffer
vim.keymap.set("n", "<Leader>bd", ":bd<CR>", opts)
-- Show open buffers
vim.keymap.set("n", "<Leader>bb", ":buffers<CR>", opts)
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

---------------
-- Nvim Tree --
---------------

vim.keymap.set("n", "<Leader>t", ":NvimTreeToggle<CR>", opts)

--------------
-- Terminal --
--------------

-- Open terminal to the right
vim.keymap.set("n", "<Leader>T", ":vsplit term://fish<CR>A", opts)

-----------------
-- Code Runner --
-----------------

-- Run current file
vim.keymap.set("n", "<Leader>rf", ":w<CR> :RunFile<CR>", opts)
-- Close runner window
vim.keymap.set("n", "<Leader>rc", ":RunClose<CR>", opts)

------------
-- Ollama --
------------

-- Ask prompt to default model
vim.keymap.set("n", "<Leader>ai", ":Ollama<CR>", opts)

---------
-- LaTeX --
---------

-- Single-shot compilation
vim.keymap.set("n", "<Leader>ll", ":w<CR>:VimtexCompileSS<CR>", opts)
-- Toggle continuous compilation
vim.keymap.set("n", "<Leader>ls", ":w<CR>:VimtexCompile<CR>", opts)

-----------
-- Mason --
-----------

-- Open Mason (stands for leader-plugin-mason)
vim.keymap.set("n", "<Leader>pm", ":Mason<CR>", opts)

----------------
-- Formatting --
----------------

function format_file()
  require("conform").format({
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    },
  })
end

vim.keymap.set("n", "<Leader>F", format_file, opts)

--------------------
-- vim.diagnostic --
--------------------

-- Go to next warning / error (leader-goto-next)
vim.keymap.set("n", "<Leader>gn", vim.diagnostic.goto_next, opts)
-- Go to next warning / error (leader-goto-previous)
vim.keymap.set("n", "<Leader>gp", vim.diagnostic.goto_prev, opts)

--------------
-- Comments --
--------------
-- Defined in the Comment plugin options

-----------------
-- Tree-sitter --
-----------------
-- Defined in the Tree-sitter plugin options

-----------------
-- Copilot --
-----------------

-- Accept copilot suggestion (leader-copilot)
vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
  replace_keycodes = false,
  expr = true,
})
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

-- Configuration for third-party plugins

-- Use lazy.nvim from https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_lock_path = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"

-- Bootstrap lazy.nvim from Github
if not vim.loop.fs_stat(lazypath) then
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

-- Plugins table
local plugins = {

  -- Plugin for operations on braces
  "tpope/vim-surround",

  -- LSP config (plugin confings in lsp.lua)
  "neovim/nvim-lspconfig",

  {
    --formatting plugin
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters = {
          black = {
            prepend_args = { "--line-length", "80" },
          },
        },
        formatters_by_ft = {
          python = { "black" },
          lua = { "stylua" },
          tex = { "tex-fmt" },
        },
        format_on_save = {
          timeout_ms = 2000,
          lsp_format = "fallback",
        },
      })
    end,
  },

  -- Nice plugin to view CSV files
  "mechatroner/rainbow_csv",

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup()
      vim.cmd("colorscheme gruvbox")
    end,
  },

  {
    -- Git decorations in the buffer
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    -- Treesitter for parsing files
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "haskell",
          "purescript",
          "python",
          "json",
          "yaml",
          "lua",
          "html",
          "css",
          "markdown",
          "markdown_inline",
          "gitignore",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    -- Lualine
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup()
    end,
  },

  {
    -- Edit the file system as if it was a normal file
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    -- Telescope for searching files
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- Config from https://mischavandenburg.com/zet/neovim-telescope-follow-symlinks/
      local telescope = require("telescope")
      local telescopeConfig = require("telescope.config")
      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      -- I don't want to search in the `.venv` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.venv/*")
      -- I want to follow symbolic links
      table.insert(vimgrep_arguments, "-L")
      -- Run the setup function
      telescope.setup({
        defaults = {
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!**/.git/*",
              "-L",
              "--glob",
              "!**/.venv/*",
            },
          },
        },
      })
    end,
  },

  {
    -- LaTeX plugin
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_mode = 0
    end,
  },

  -- Purescript syntax highlighting
  { "purescript-contrib/purescript-vim" },

  -- Close all buffers except the current one
  { "schickling/vim-bufonly" },
}

require("lazy").setup({
  spec = plugins,
  lockfile = lazy_lock_path,
  rocks = { enabled = false },
})

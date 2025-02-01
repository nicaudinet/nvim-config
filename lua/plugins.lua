-- Configuration for third-party plugins

-- Use lazy.nvim from https://github.com/folke/lazy.nvim

-- Bootstrap lazy.nvim from Github
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
    -- Connect Mason with LspConfig
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright", -- Python
          "r_language_server", -- R
        },
      })
    end,
  },

  -- Plugin for installing LSP servers and other tools
  { "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					}
        }
      })
    end,
  },

  -- Nice plugin to view CSV files
  "mechatroner/rainbow_csv",

  -- {
  --   -- Monokai pro theme
  --   "loctvl842/monokai-pro.nvim",
  --   priority = 1000, -- load before other plugins
  --   config = function()
  --     require("monokai-pro").setup()
  --     vim.cmd("colorscheme monokai-pro")
  --   end,
  -- },

  { "ellisonleao/gruvbox.nvim",
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
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
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
          "r",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-s>",
            node_incremental = "<C-s>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },

  {
    -- Treesitter text objects
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["a="] = "@assignment.outer",
              ["i="] = "@assignment.inner",
              ["l="] = "@assignment.lhs",
              ["r="] = "@assignment.rhs",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
            },
          },
        },
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
    'stevearc/oil.nvim',
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
    config = function()
      vim.g.vimtex_view_method = "skim"
      maplocalleader = " "
    end,
  },

  {
    -- Dressing - nice input and select using telescope
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- Purescript syntax highlighting
  { "purescript-contrib/purescript-vim" },

  -- Close all buffers except the current one
  { "schickling/vim-bufonly" },
}

-- Options table
local opts = {
  rocks = {
    enabled = false,
  },
}

require("lazy").setup(plugins, opts)

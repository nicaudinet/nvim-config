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

  -- Autosave
  -- 'Pocco81/auto-save.nvim',

  -- Nice plugin to view CSV files
  "mechatroner/rainbow_csv",

  {
    -- Monokai pro theme
    "loctvl842/monokai-pro.nvim",
    priority = 1000, -- load before other plugins
    config = function()
      require("monokai-pro").setup()
      vim.cmd("colorscheme monokai-pro")
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
    -- Tresitter for parsing files
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
          "gitignore",
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
    -- NvimTree file browser
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = true },
      })
    end,
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
    -- Ollama integration
    "nomnivore/ollama.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("ollama").setup({
        model = "paco",
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
    -- Code runner
    "CRAG666/code_runner.nvim",
    config = function()
      local window_size = vim.api.nvim_win_get_width(0)
      require("code_runner").setup({
        focus = false,
        term = {
          position = "vert",
          size = window_size / 2,
        },
      })
    end,
  },

  {
    -- Comments
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup({
        toggler = {
          line = "<Leader>cc",
          block = "<Leader>bc",
        },
        opleader = {
          line = "<Leader>c",
          block = "<Leaderb",
        },
        extra = {
          above = "<Leader>cO",
          below = "<Leader>co",
          eol = "<Leader>cA",
        },
      })
    end,
  },

  {
    -- Dressing - nice input and select using telescope
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  {
    -- Mason for LSP and formatter management
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    -- Bridge between Mason and neovim's lspconfig
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = {
          "pyright",
          "haskell-language-server",
          "lua-language-server",
          "purescript-language-server",
        },
      })
    end,
  },

  -- Neovim LSP (configured in lsp.lua)
  "neovim/nvim-lspconfig",

  {
    -- Conform for formatting
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "isort", "black" },
          lua = { "stylua" },
          javascript = { "prettier" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      })
    end,
  },

  {
    -- Github Copilot
    "github/copilot.vim",
  },

  -- Purescript syntac highlighting
  { "purescript-contrib/purescript-vim" },
}

-- Options table
local opts = {}

require("lazy").setup(plugins, opts)

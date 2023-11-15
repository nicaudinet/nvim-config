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
    'tpope/vim-surround',

    -- Autosave
    'Pocco81/auto-save.nvim',

    -- Nice plugin to view CSV files
    'mechatroner/rainbow_csv',

    {
        -- Monokai pro theme
        "loctvl842/monokai-pro.nvim",
        priority = 1000, -- load before other plugins
        config = function()
            require("monokai-pro").setup()
            vim.cmd('colorscheme monokai-pro')
        end,
    },

    {
        -- LazyGit for Git operations
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = { "nvim-lua/plenary.nvim", },
        config = function()
            -- transparency of floating window
            vim.g.lazygit_floating_window_winblend = 0
            -- scaling factor for floating window
            vim.g.lazygit_floating_window_scaling_factor = 0.9
            -- customize lazygit popup window border characters
            vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'}
            -- use plenary.nvim to manage floating window if available
            vim.g.lazygit_floating_window_use_plenary = 0
            -- fallback to 0 if neovim-remote is not installed
            vim.g.lazygit_use_neovim_remote = 1
            -- config file path is evaluated if this value is 1
            vim.g.lazygit_use_custom_config_file_path = 0
        end,
    },

    {
        -- Git decorations in the buffer
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },

    {
        -- Tresitter for parsing files
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    {
        -- Lualine
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup()
        end,
    },

    {
        -- NvimTree file browser
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('nvim-tree').setup({
                sort_by = "case_sensitive",
                view = { width = 30 },
                renderer = { group_empty = true },
                filters = { dotfiles = true },
            })
        end,
    },

    {
        -- Telescope for searching files
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
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
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "-L" },
                    },
                },
            })
        end,
    },

    {
        -- Ollama integration
        'nomnivore/ollama.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('ollama').setup({
                model = 'paco',
            })
        end,
    },

    {
        -- Code runner
        'CRAG666/code_runner.nvim',
        config = function()
            local window_size = vim.api.nvim_win_get_width(0)
            require('code_runner').setup({
                focus = false,
                term = {
                    position = "vert",
                    size = window_size / 2,
                },
            })
        end,
    },

}

-- Options table
local opts = {}

require("lazy").setup(plugins, opts)

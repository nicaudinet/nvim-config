Following advice from https://martinlwx.github.io/en/config-neovim-from-scratch/

**init.lua** - the entry point to the Neovim configuration. We will “import”
other \*.lua files in here (import order matters).

Inside the ./lua folder are three files:
    - options.lua
    - keymaps.lua and
    - plugins.lua.

**lua/options.lua** - where we set global options (e.g. tab spaces and such).
Commands in here have the form `vim.opt.[OPTION]`.

**lua/keymaps.lua** - where (most) keyboard mappings are set.

**lua/plugins.lua** - where the options for external plugins are set using
Lazy.nvim.

**after/ftplugin/lua.lua** - contains the formatoption which needs to run after
the ftplugin finishes.

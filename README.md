Following advice from https://martinlwx.github.io/en/config-neovim-from-scratch/

- init.lua is the entry point. We will “import” other \*.lua files in init.lua
- Inside the ./lua folder:
    - colorscheme.lua for the theme
    - keymaps.lua for key mappings
    - lsp.lua for the LSP support
    - options.lua for some global options
    - plugins.lua for importing configuration for third-party plugins
    - The ./config folder contains the configuration for the third-party plugins.

local lspconfig = require("lspconfig")

-----------------------------
-- Enable Language Servers --
-----------------------------

-- Enable the Python LSP
lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        inlayHints = {
          functionParameterTypes = false,
        },
      },
    },
  },
})

---------------------
-- LSP keybindings --
---------------------

-- common keybinding options
local opts = {
  noremap = true, -- non-recursive
  silent = true, -- do not show message
}

-- Set common key bindings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)

    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Rename a variable (leader-lsp-Rename)
    if client.supports_method("textDocument/rename") then
      vim.keymap.set("n", "<Leader>lR", vim.lsp.buf.rename, opts)
    end

    -- Go to definition (leader-lsp-definition)
    if client.supports_method("textDocument/definition") then
      vim.keymap.set("n", "<Leader>ld", vim.lsp.buf.definition, opts)
    end

    -- Go to the type definition (leader-lsp-type)
    if client.supports_method("textDocument/typeDefinition") then
      vim.keymap.set("n", "<Leader>lt", vim.lsp.buf.type_definition, opts)
    end

    -- Format the current buffer with the LSP (leader-lsp-format)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, opts)
    end

    -- Code action (leader-lsp-a)
    if client.supports_method("textDocument/codeAction") then
      vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, opts)
    end


    ---------------
    -- Telescope --
    ---------------

    local telescope = require("telescope.builtin")

    -- Show references for word under cursor (leader-lsp-references)
    if client.supports_method("textDocument/references") then
      vim.keymap.set("n", "<Leader>lr", telescope.lsp_references, opts)
    end

    -- Show all diagnostics (ledaer-lsp-Diagnostics)
    if client.supports_method("textDocument/publishDiagnostics") then
      vim.keymap.set("n", "<Leader>lD", telescope.diagnostics, opts)
    end


  end,
})

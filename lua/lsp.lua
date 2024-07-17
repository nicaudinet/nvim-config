local lspconfig = require("lspconfig")
-- Python
lspconfig.pyright.setup({})
})

-- Recommended settings from https://github.com/neovim/nvim-lspconfig

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    local opts = { buffer = ev.buf, noremap = true, silent = true }

    -----------------
    -- vim.lsp.buf --
    -----------------
    -- See list of code actions (leader-code-action)
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
    -- Go to definition (leader-goto-definition)
    vim.keymap.set("n", "<Leader>gd", function()
      vim.lsp.buf.definition()
      vim.wait(100, vim.api.nvim_feedkeys("zt", "n", true))
    end, opts)
    -- Go to type definition of symbol under cursor (leader-goto-type)
    vim.keymap.set("n", "<Leader>gt", vim.lsp.buf.type_definition, opts)
    -- Go to references (leader-goto-references)
    vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, opts)
    -- Rename symbol (leader-Rename)
    -- NOTE: Gives error for HLS
    vim.keymap.set("n", "<Leader>R", vim.lsp.buf.rename, opts)
    -- Display information in a floating window (leader-hover)
    vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, opts)

    ----------------------
    -- vim.lsp.codelens --
    ----------------------
    -- Return all lenses in the buffer
    vim.keymap.set("n", "<Leader>cl", function()
      local output = vim.lsp.codelens.get().tostring()
      local bufnr = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.split(output, "\n"))
      vim.api.nvim_open_win(bufnr, true, {
        relative = "editor",
        width = 40,
        height = 10,
        row = 1,
        col = 1,
        border = "single",
        style = "minimal",
      })
    end, opts)

    -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wl", function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set("n", "<space>f", function()
    --   vim.lsp.buf.format({ async = true })
    -- end, opts)
  end,
})

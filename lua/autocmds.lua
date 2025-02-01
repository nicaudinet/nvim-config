-- From https://stackoverflow.com/questions/77147995/setting-up-formatters-in-neovim-with-mason-lsp-zero

-- Create group to assign commands
-- "clear = true" must be set to prevent loading an auto-command repeatedly
-- every time a file is resourced
local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

-- Format Haskell files with Fourmolu on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  desc = "Auto-format Haskell files with Fourmolu",
  pattern = { "*.hs" },
  group = autocmd_group,
  callback = function()

    -- Set fourmolu config options
    local options = {}
    options["indentation"] = 2
    options["function-arrows"] = "leading"
    options["comma-style"] = "leading"
    options["import-export-style"] = "leading"
    options["single-constraint-parens"] = "never"
    options["single-deriving-parens"] = "never"
    local optionStr = ""
    for k, v in pairs(options) do
      optionStr = optionStr .. " --" .. k .. " " .. v
    end

    -- Run fourmolu
    local fileName = vim.api.nvim_buf_get_name(0)
    vim.cmd(":silent !fourmolu -i " .. optionStr .. " " .. fileName)

  end,
})

-- Format PureScript files with purescript-tidy on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  desc = "Auto-format PureScript files with purescript-tidy",
  pattern = { "*.purs" },
  group = autocmd_group,
  callback = function()

    -- Set fourmolu config options
    local options = {}
    options["indent"] = 2
    options["config-ignore"] = ""
    options["import-sort-ide"] = ""
    options["import-wrap-source"] = ""

    -- Combine options into a string
    local optStr = ""
    for k, v in pairs(options) do
      optStr = optStr .. " --" .. k .. " " .. v
    end

    -- Run fourmolu
    local fileName = vim.api.nvim_buf_get_name(0)
    vim.cmd(":silent !purs-tidy format-in-place " .. optStr .. " " .. fileName)

  end,
})

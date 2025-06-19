-- lua/config/lsp-config.lua
-- SIMPLEST SOLUTION: Just make the Django "errors" look like VSCode warnings

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        -- Keep basic type checking but make it less strict
        typeCheckingMode = "basic", -- Less strict than "standard"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,

        -- Turn Django "errors" into "information" (like VSCode does)
        diagnosticSeverityOverrides = {
          reportArgumentType = "information", -- Your BooleanField issue
          reportIncompatibleVariableOverride = "information", -- Your Meta class issue
          reportReturnType = "information", -- Your property return issue
          reportGeneralTypeIssues = "information", -- General Django patterns
          reportOptionalMemberAccess = "information", -- Django optional access
          reportUnknownMemberType = "information", -- Django dynamic attributes
          reportUnknownArgumentType = "information", -- Django dynamic args
          reportUntypedFunctionDecorator = "information", -- Django decorators like @login_required
          reportUntypedBaseClass = "information", -- Django model inheritance
          reportMissingTypeStubs = "information", -- Missing Django stubs
        },
      },
    },
  },
})

-- Keep your existing TypeScript config
lspconfig.vtsls.setup({
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "none",
      },
    },
  },
})

-- Configure diagnostics to display like VSCode
vim.diagnostic.config({
  virtual_text = {
    -- Only show errors and warnings as virtual text, not info
    severity = { min = vim.diagnostic.severity.WARN },
    source = "if_many",
    format = function(diagnostic)
      return string.format("%s", diagnostic.message)
    end,
  },
  signs = {
    -- Show all levels in the sign column but with different icons
    severity = { min = vim.diagnostic.severity.HINT },
  },
  underline = {
    -- Only underline warnings and errors, not info
    severity = { min = vim.diagnostic.severity.WARN },
  },
  float = {
    source = "always",
    border = "rounded",
  },
  severity_sort = true,
  update_in_insert = false, -- Don't show while typing (like VSCode)
})

-- Custom diagnostic signs (like VSCode)
local signs = {
  { name = "DiagnosticSignError", text = "❌" },
  { name = "DiagnosticSignWarn", text = "⚠️" },
  { name = "DiagnosticSignHint", text = "💡" },
  { name = "DiagnosticSignInfo", text = "ℹ️" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- -- lua/config/lsp-config.lua
-- local lspconfig = require("lspconfig")
--
-- -- Configure pylsp (Python LSP) instead of or alongside other Python LSPs
-- lspconfig.pylsp.setup({
--   settings = {
--     pylsp = {
--       plugins = {
--         -- Disable some strict checking
--         pycodestyle = { enabled = false },
--         mccabe = { enabled = false },
--         pyflakes = { enabled = false },
--         -- Use autopep8 for formatting instead of strict linting
--         autopep8 = { enabled = true },
--         -- Enable rope for refactoring
--         rope_completion = { enabled = true },
--       },
--     },
--   },
-- })
--
-- -- Configure Pyright with Django-friendly settings
-- lspconfig.pyright.setup({
--   settings = {
--     python = {
--       analysis = {
--         -- Make Pyright less strict for Django
--         typeCheckingMode = "basic", -- Change from "strict" to "basic"
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--         autoImportCompletions = true,
--         diagnosticMode = "workspace",
--         -- Disable specific strict checks that cause issues with Django
--         diagnosticSeverityOverrides = {
--           reportArgumentType = "none", -- Disable the argument type errors you're seeing
--           reportIncompatibleVariableOverride = "none", -- Disable Meta class override warnings
--           reportReturnType = "none", -- Disable return type mismatches for Django fields
--           reportGeneralTypeIssues = "none", -- More lenient on general type issues
--           reportOptionalMemberAccess = "information", -- Less strict on optional access
--           reportOptionalOperand = "information",
--           reportOptionalSubscript = "information",
--           reportPrivateImportUsage = "information",
--         },
--       },
--     },
--   },
-- })
--
-- -- If you want to use both, you can configure them for different purposes
-- lspconfig.vtsls.setup({
--   settings = {
--     typescript = {
--       inlayHints = {
--         includeInlayParameterNameHints = "none",
--       },
--     },
--   },
-- })

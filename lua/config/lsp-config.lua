-- lua/config/lsp-config.lua
-- CONFIGURACIÓN ULTRA MINIMALISTA - SOLO ERRORES CRÍTICOS

local lspconfig = require("lspconfig")

-- ===== PYRIGHT ULTRA MINIMALISTA =====
lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        -- DESACTIVAR TODO EL TYPE CHECKING
        typeCheckingMode = "off",
        autoSearchPaths = false,
        useLibraryCodeForTypes = false,
        autoImportCompletions = false,

        -- SILENCIAR TODO - ABSOLUTAMENTE TODO
        diagnosticSeverityOverrides = {
          -- IMPORTS Y VARIABLES
          reportMissingImports = "none",
          reportMissingModuleSource = "none",
          reportUndefinedVariable = "error", -- SOLO ESTE como error
          reportUnusedImport = "none",
          reportUnusedVariable = "none",

          -- DJANGO Y TIPOS
          reportArgumentType = "none",
          reportIncompatibleVariableOverride = "none",
          reportReturnType = "none",
          reportGeneralTypeIssues = "none",
          reportOptionalMemberAccess = "none",
          reportUnknownMemberType = "none",
          reportUnknownArgumentType = "none",
          reportUntypedFunctionDecorator = "none",
          reportUntypedBaseClass = "none",
          reportMissingParameterType = "none",
          reportUnknownParameterType = "none",
          reportUnknownVariableType = "none",
          reportMissingTypeStubs = "none",
          reportCallIssue = "none",
          reportAssignmentType = "none",
          reportAttributeAccessIssue = "none",
          reportIncompatibleMethodOverride = "none",
          reportInvalidTypeArguments = "none",
          reportInvalidTypeVarUse = "none",
          reportPossiblyUnboundVariable = "none",
          reportOperatorIssue = "none",

          -- TODO LO DEMÁS
          reportUnusedFunction = "none",
          reportPrivateUsage = "none",
          reportConstantRedefinition = "none",
          reportDuplicateImport = "none",
          reportSelfClsParameterName = "none",
          reportUninitializedInstanceVariable = "none",
          reportUnnecessaryCast = "none",
          reportUnnecessaryComparison = "none",
          reportUnnecessaryContains = "none",
          reportUnnecessaryIsInstance = "none",
          reportUnreachableCode = "none",
          reportUnusedExpression = "none",
          reportWildcardImportFromLibrary = "none",
          reportOptionalCall = "none",
          reportOptionalContextManager = "none",
          reportOptionalIterable = "none",
          reportOptionalOperand = "none",
          reportOptionalSubscript = "none",
          reportOverlappingOverload = "none",
          reportUnusedClass = "none",
          reportUnusedCoroutine = "none",
          reportInvalidStringEscapeSequence = "none",
          reportInvalidTypeAnnotation = "none",

          -- SOLO SINTAXIS CRÍTICA
          reportSyntaxError = "error",
          reportIndentationError = "error",
        },
      },
    },
  },
})

-- TypeScript como estaba
lspconfig.vtsls.setup({
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "none",
      },
    },
  },
})

-- ===== CONFIGURACIÓN DE DIAGNÓSTICOS ULTRA MINIMALISTA =====
vim.diagnostic.config({
  virtual_text = {
    -- SOLO ERRORES CRÍTICOS
    severity = { min = vim.diagnostic.severity.ERROR },
    source = "never", -- No mostrar fuente
    format = function(diagnostic)
      return string.format("%s", diagnostic.message)
    end,
    prefix = "🚨", -- Solo para errores críticos
    spacing = 1,
  },
  signs = {
    -- SOLO ERRORES CRÍTICOS
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  underline = {
    -- SOLO ERRORES CRÍTICOS
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  float = {
    -- Para cuando abras el float manualmente
    source = "if_many",
    border = "rounded",
    header = "",
    prefix = "",
    severity_sort = true,
  },
  severity_sort = true,
  update_in_insert = false,
})

-- ===== ICONOS SOLO PARA ERRORES =====
local signs = {
  { name = "DiagnosticSignError", text = "🚨", hl = "DiagnosticSignError" },
  { name = "DiagnosticSignWarn", text = "", hl = "DiagnosticSignWarn" }, -- Vacío
  { name = "DiagnosticSignHint", text = "", hl = "DiagnosticSignHint" }, -- Vacío
  { name = "DiagnosticSignInfo", text = "", hl = "DiagnosticSignInfo" }, -- Vacío
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, {
    texthl = sign.hl,
    text = sign.text,
    numhl = "",
  })
end

-- ===== COLORES PARA ERRORES CRÍTICOS =====
-- Solo errores en rojo brillante
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
  fg = "#ff3333", -- Rojo brillante para errores críticos
  bold = true,
})

vim.api.nvim_set_hl(0, "DiagnosticSignError", {
  fg = "#ff3333",
  bold = true,
})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
  undercurl = true,
  sp = "#ff3333",
})

-- Hacer invisibles los otros niveles
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "NONE" })

-- ===== FUNCIÓN PARA CONTROL TOTAL =====
_G.toggle_all_diagnostics = function()
  local current_config = vim.diagnostic.config()
  if current_config.virtual_text == false then
    -- Reactivar solo errores críticos
    vim.diagnostic.config({
      virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR },
        format = function(diagnostic)
          return string.format("🚨 %s", diagnostic.message)
        end,
      },
      signs = { severity = { min = vim.diagnostic.severity.ERROR } },
      underline = { severity = { min = vim.diagnostic.severity.ERROR } },
    })
    vim.notify("Diagnósticos CRÍTICOS activados", vim.log.levels.INFO)
  else
    -- Desactivar todo completamente
    vim.diagnostic.config({
      virtual_text = false,
      signs = false,
      underline = false,
      float = false,
    })
    vim.notify("TODOS los diagnósticos desactivados", vim.log.levels.INFO)
  end
end

-- ===== FUNCIÓN PARA MOSTRAR TEMPORALMENTE TODO =====
_G.show_all_diagnostics_temp = function()
  vim.diagnostic.config({
    virtual_text = {
      severity = { min = vim.diagnostic.severity.HINT },
      format = function(diagnostic)
        local level = ""
        if diagnostic.severity == vim.diagnostic.severity.ERROR then
          level = "🚨"
        elseif diagnostic.severity == vim.diagnostic.severity.WARN then
          level = "⚠️"
        elseif diagnostic.severity == vim.diagnostic.severity.INFO then
          level = "ℹ️"
        else
          level = "💡"
        end
        return string.format("%s %s", level, diagnostic.message)
      end,
    },
    signs = { severity = { min = vim.diagnostic.severity.HINT } },
    underline = { severity = { min = vim.diagnostic.severity.HINT } },
  })
  vim.notify("Mostrando TODOS los diagnósticos temporalmente", vim.log.levels.WARN)

  -- Volver a solo errores después de 10 segundos
  vim.defer_fn(function()
    vim.diagnostic.config({
      virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
      signs = { severity = { min = vim.diagnostic.severity.ERROR } },
      underline = { severity = { min = vim.diagnostic.severity.ERROR } },
    })
    vim.notify("Volviendo a mostrar solo errores críticos", vim.log.levels.INFO)
  end, 10000) -- 10 segundos
end

print("🔥 LSP configurado ULTRA MINIMALISTA - Solo errores críticos")

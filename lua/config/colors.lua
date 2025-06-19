-- colors.lua: Personalización de colores

-- Cambiar el color de los tipos de datos (tipados) con subrayado
vim.cmd([[highlight Type  gui=underline]])

-- Cambiar el color de los comentarios
vim.cmd([[highlight Comment guifg=#6272a4]])

-- -- Cambiar el color de las funciones en negrita
-- vim.cmd([[highlight Function guifg=#8be9fd gui=bold]])
--
-- -- Cambiar el color del fondo en los números de línea
-- vim.cmd([[highlight LineNr guifg=#5eacd3 guibg=NONE]])
--
-- -- Cambiar el color de los números de línea actuales
-- vim.cmd([[highlight CursorLineNr guifg=#ffb86c guibg=NONE gui=bold]])
--
-- -- Cambiar el color de las cadenas de texto (strings)
-- vim.cmd([[highlight String guifg=#f1fa8c]])
--
-- -- Cambiar el color de las constantes (por ejemplo, números)
-- vim.cmd([[highlight Constant guifg=#bd93f9]])
--
-- -- Cambiar el color de las variables globales
-- vim.cmd([[highlight Identifier guifg=#50fa7b]])

-- Puedes agregar más personalizaciones según tus preferencias...
--
--
--
-- Fondo claro para el área de código (Normal)
-- vim.cmd([[highlight Normal guibg=#a8dadc]]) -- Un azul claro, puedes ajustar el color si lo prefieres
--
-- -- Fondo oscuro para las ventanas emergentes (menús, buscadores, etc.)
-- vim.cmd([[highlight Pmenu guibg=#1d3557]]) -- Fondo del menú (Pmenu)
-- vim.cmd([[highlight PmenuSel guibg=#457b9d]]) -- Fondo cuando seleccionas un elemento en el menú
-- vim.cmd([[highlight TelescopeNormal guibg=#1d3557]]) -- Fondo del buscador (Telescope)
-- vim.cmd([[highlight TelescopeBorder guifg=#1d3557 guibg=#1d3557]]) -- Borde del buscador (Telescope)
--
-- -- Fondo oscuro para NvimTree (igual que Telescope)
-- vim.cmd([[highlight NvimTreeNormal guibg=#1d3557]])
-- vim.cmd([[highlight NvimTreeNormalNC guibg=#1d3557]])
--
--
--
--
--
-- -- -- Cambiar el color de los tipos de datos (por ejemplo, int, float, etc.) con subrayado
-- vim.cmd([[highlight Type gui=underline]])
--
-- -- Cambiar el color de los comentarios
-- vim.cmd([[highlight Comment guifg=#6272a4]])
--
-- -- Cambiar el color de las funciones en negrita
-- vim.cmd([[highlight Function guifg=#8be9fd gui=bold]])
--
-- -- Cambiar el color del fondo en los números de línea
-- vim.cmd([[highlight LineNr guifg=#5eacd3 guibg=NONE]])
--
-- -- Cambiar el color de los números de línea actuales
-- vim.cmd([[highlight CursorLineNr guifg=#ffb86c guibg=NONE gui=bold]])
--
-- -- Cambiar el color de las cadenas de texto (strings)
-- vim.cmd([[highlight String guifg=#f1fa8c]])
--
-- -- Cambiar el color de las constantes (por ejemplo, números)
-- vim.cmd([[highlight Constant guifg=#bd93f9]])
--
-- -- Cambiar el color de las variables globales
-- vim.cmd([[highlight Identifier guifg=#50fa7b]])
--
-- -- Cambiar el color de las palabras clave (keywords, como "if", "else", "return")
-- vim.cmd([[highlight Keyword guifg=#ff79c6 gui=bold]])
--
-- -- Cambiar el color de las declaraciones (por ejemplo, funciones, variables)
-- vim.cmd([[highlight Statement guifg=#ff79c6]])
--
-- -- Cambiar el color de los delimitadores (paréntesis, llaves, corchetes)
-- vim.cmd([[highlight Delimiter guifg=#ffb86c]])
--
-- -- Cambiar el color de los operadores (por ejemplo, "+", "=", "&&")
-- vim.cmd([[highlight Operator guifg=#ff79c6]])
--
-- -- Cambiar el color de los bloques condicionales (if, else, while)
-- vim.cmd([[highlight Conditional guifg=#ff79c6]])
--
-- -- Cambiar el color de los bloques repetitivos (for, while)
-- vim.cmd([[highlight Repeat guifg=#bd93f9]])
--
-- -- Cambiar el color de los identificadores de preprocesador (por ejemplo, #define)
-- vim.cmd([[highlight PreProc guifg=#ff79c6]])
--
-- -- Cambiar el color de las excepciones (try, catch, throw)
-- vim.cmd([[highlight Exception guifg=#ff5555]])
--
-- -- Cambiar el color de las etiquetas y directivas (goto, labels)
-- vim.cmd([[highlight Label guifg=#bd93f9]])
--
-- -- Cambiar el color de las macros (por ejemplo, #define en C)
-- vim.cmd([[highlight Macro guifg=#ff79c6]])
--
-- -- Cambiar el color de las constantes booleanas (true, false)
-- vim.cmd([[highlight Boolean guifg=#ffb86c gui=bold]])
--
-- -- Cambiar el color de las constantes numéricas (números)
-- vim.cmd([[highlight Number guifg=#bd93f9]])
--
-- -- Cambiar el color de las constantes flotantes (por ejemplo, 3.14)
-- vim.cmd([[highlight Float guifg=#bd93f9]])
--
-- -- Cambiar el color de los strings en comillas simples o dobles
-- vim.cmd([[highlight String guifg=#f1fa8c]])
--
-- -- Cambiar el color de los comentarios TODO
-- vim.cmd([[highlight Todo guifg=#ffb86c gui=bold]])
--
-- -- Cambiar el color del fondo cuando la línea actual está resaltada
-- vim.cmd([[highlight CursorLine guibg=#2d2a2e]])
--
-- -- Cambiar el color de las líneas coincidentes en la búsqueda
-- vim.cmd([[highlight Search guibg=#ffb86c guifg=#282a36]])
--
-- -- Cambiar el color del fondo en las ventanas emergentes (por ejemplo, autocompletar)
-- vim.cmd([[highlight Pmenu guibg=#1d3557 guifg=#ffffff]])
--
-- -- Cambiar el color de los elementos seleccionados en el menú emergente
-- vim.cmd([[highlight PmenuSel guibg=#457b9d guifg=#ffffff]])
--
-- -- Cambiar el color de los bordes de las ventanas emergentes (Telescope, menús)
-- vim.cmd([[highlight PmenuBorder guifg=#1d3557]])
--
-- -- Cambiar el color de las coincidencias de búsqueda (highlight search)
-- vim.cmd([[highlight IncSearch guibg=#ff79c6 guifg=#ffffff]])
--
-- -- Cambiar el color del texto seleccionado visualmente
-- vim.cmd([[highlight Visual guibg=#44475a]])
--
-- -- Cambiar el color de las líneas resaltadas en errores (LSP)
-- vim.cmd([[highlight LspDiagnosticsDefaultError guifg=#ff5555]])
--
-- -- Cambiar el color de las advertencias del LSP
-- vim.cmd([[highlight LspDiagnosticsDefaultWarning guifg=#f1fa8c]])
--
-- -- Cambiar el color de la información (Info) del LSP
-- vim.cmd([[highlight LspDiagnosticsDefaultInformation guifg=#8be9fd]])
--
-- -- Cambiar el color de las sugerencias del LSP
-- vim.cmd([[highlight LspDiagnosticsDefaultHint guifg=#50fa7b]])
--
-- -- Cambiar el color de los errores sintácticos (underline)
-- vim.cmd([[highlight DiagnosticUnderlineError guifg=NONE gui=underline]])
--
-- -- Cambiar el color de las advertencias sintácticas (underline)
-- vim.cmd([[highlight DiagnosticUnderlineWarn guifg=NONE gui=underline]])
--
-- -- Cambiar el color del número de líneas de relleno (después del final del archivo)
-- vim.cmd([[highlight EndOfBuffer guifg=#44475a]])
--
-- -- Cambiar el color de los títulos de los plugins (como Telescope)
-- vim.cmd([[highlight Title guifg=#50fa7b gui=bold]])
--
-- -- Cambiar el color del texto que indica progreso (porcentaje de archivo, línea actual)
-- vim.cmd([[highlight StatusLine guifg=#ffffff guibg=#282a36]])
--
-- -- Cambiar el color de los bordes de los paneles (split borders)
-- vim.cmd([[highlight VertSplit guifg=#6272a4]])
--
-- -- Cambiar el color del espacio vacío al final de las líneas
-- vim.cmd([[highlight Whitespace guifg=#6272a4]])
--

-- Función para aplicar personalizaciones de colores
local function apply_custom_colors()
  -- Esperar un poco para asegurar que el tema se ha cargado completamente
  vim.defer_fn(function()
    -- Cambiar el color de los tipos de datos (tipados) con subrayado
    vim.cmd([[highlight Type gui=underline]])

    -- Cambiar el color de los comentarios
    vim.cmd([[highlight Comment guifg=#6272a4]])

    -- Configuraciones específicas para NeoTree (refuerzo de las configuraciones del tema)
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#111111" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#111111" })
    vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "#111111" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#111111", bg = "#111111" })
    vim.api.nvim_set_hl(0, "NeoTreeBorder", { fg = "#111111", bg = "#111111" })

    -- Asegurar que el fondo del área de código sea consistente (solo si no hay transparencia)
    local transparent_status = false
    local ok, transparent_module = pcall(require, "config.transparent")
    if ok then
      transparent_status = transparent_module.get_status()
    end

    if not transparent_status then
      -- Solo aplicar fondos si no hay transparencia activa
      vim.cmd([[highlight Normal guibg=#191919]])
      vim.cmd([[highlight NormalNC guibg=#191919]])
    end

    -- Otras personalizaciones que puedas necesitar...
    -- vim.cmd([[highlight Function guifg=#8be9fd gui=bold]])
    -- vim.cmd([[highlight String guifg=#f1fa8c]])
    -- etc...
  end, 100)
end

-- Aplicar colores inmediatamente
apply_custom_colors()

-- Autocomando para aplicar colores personalizados cuando se abre NeoTree
vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#111111" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#111111" })
    vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "#111111" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#111111", bg = "#111111" })
    vim.api.nvim_set_hl(0, "NeoTreeBorder", { fg = "#111111", bg = "#111111" })
  end,
})

-- También aplicar cuando se cambie el colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_custom_colors,
})

-- Aplicar cuando se carga el buffer (para mantener consistencia)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    -- Solo re-aplicar si no hay transparencia
    local transparent_status = false
    local ok, transparent_module = pcall(require, "config.transparent")
    if ok then
      transparent_status = transparent_module.get_status()
    end

    if not transparent_status then
      vim.defer_fn(function()
        vim.cmd([[highlight Normal guibg=#191919]])
        vim.cmd([[highlight NormalNC guibg=#191919]])
      end, 10)
    end
  end,
})

-- Autocomando adicional para cuando se abren/cierran ventanas de NeoTree
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    local filetype = vim.bo.filetype
    if filetype == "neo-tree" then
      vim.defer_fn(function()
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#111111" })
        vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#111111" })
        vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "#111111" })
      end, 10)
    end
  end,
})

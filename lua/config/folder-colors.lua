-- lua/config/folder-colors.lua
local M = {}

-- Define diferentes esquemas de colores para carpetas
M.color_schemes = {
  {
    name = "Amarillo Brillante",
    folder_icon = "#ffcc02",
    folder_name = "#ffffff",
    folder_open_icon = "#ffcc02",
  },
  {
    name = "Azul Cyan",
    folder_icon = "#8be9fd",
    folder_name = "#ffffff",
    folder_open_icon = "#8be9fd",
  },
  {
    name = "Verde Neón",
    folder_icon = "#50fa7b",
    folder_name = "#ffffff",
    folder_open_icon = "#50fa7b",
  },
  {
    name = "Rosa Magenta",
    folder_icon = "#ff79c6",
    folder_name = "#ffffff",
    folder_open_icon = "#ff79c6",
  },
  {
    name = "Naranja",
    folder_icon = "#ffb86c",
    folder_name = "#ffffff",
    folder_open_icon = "#ffb86c",
  },
  {
    name = "Púrpura",
    folder_icon = "#bd93f9",
    folder_name = "#ffffff",
    folder_open_icon = "#bd93f9",
  },
  {
    name = "Rojo",
    folder_icon = "#ff5555",
    folder_name = "#ffffff",
    folder_open_icon = "#ff5555",
  },
  {
    name = "Gris Claro",
    folder_icon = "#a8a8a8",
    folder_name = "#ffffff",
    folder_open_icon = "#a8a8a8",
  },
}

-- Índice del esquema actual
M.current_scheme_index = 1

-- Función para aplicar un esquema de colores
function M.apply_color_scheme(scheme)
  -- Configurar colores específicos para iconos de carpetas en NeoTree
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = scheme.folder_icon })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = scheme.folder_name })
  vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#8be9fd" }) -- Mantener archivos en azul
  vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#f8f8f2" }) -- Mantener archivos en blanco

  -- También configurar los colores en nvim-web-devicons
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    -- Actualizar configuración para carpetas
    devicons.set_icon({
      folder = {
        icon = "",
        color = scheme.folder_icon,
        name = "Folder",
      },
      folder_open = {
        icon = "",
        color = scheme.folder_open_icon,
        name = "FolderOpen",
      },
    })
  end

  -- Simple redraw para actualizar la pantalla
  vim.schedule(function()
    vim.cmd("redraw!")
  end)
end

-- Función para cambiar al siguiente esquema de colores
function M.cycle_folder_colors()
  local current_scheme = M.color_schemes[M.current_scheme_index]

  -- Aplicar el esquema actual
  M.apply_color_scheme(current_scheme)

  -- Mostrar notificación con el nombre del esquema
  vim.notify(string.format("Carpetas: %s", current_scheme.name), vim.log.levels.INFO, { title = "Colores de Carpetas" })

  -- Avanzar al siguiente esquema para la próxima vez
  M.current_scheme_index = M.current_scheme_index + 1
  if M.current_scheme_index > #M.color_schemes then
    M.current_scheme_index = 1
  end
end

-- Función para establecer un esquema específico por índice
function M.set_color_scheme(index)
  if index >= 1 and index <= #M.color_schemes then
    -- CORREGIDO: Actualizar el índice actual antes de aplicar
    M.current_scheme_index = index
    local scheme = M.color_schemes[index]
    M.apply_color_scheme(scheme)
    vim.notify(string.format("Carpetas: %s", scheme.name), vim.log.levels.INFO, { title = "Colores de Carpetas" })
  end
end

-- Función para mostrar menú de selección (CORREGIDA)
function M.show_color_menu()
  local options = {}
  for i, scheme in ipairs(M.color_schemes) do
    table.insert(options, scheme.name) -- Solo el nombre, sin número
  end

  vim.ui.select(options, {
    prompt = "Selecciona un color para las carpetas:",
    format_item = function(item)
      return item
    end,
  }, function(choice, idx)
    if choice and idx then
      -- CORREGIDO: Usar directamente el índice que nos da vim.ui.select
      M.set_color_scheme(idx)
    end
  end)
end

-- Función de inicialización
function M.init()
  -- Aplicar el primer esquema al inicio
  local initial_scheme = M.color_schemes[M.current_scheme_index]
  M.apply_color_scheme(initial_scheme)

  -- Crear autocomandos para mantener los colores
  local augroup = vim.api.nvim_create_augroup("FolderColors", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "neo-tree",
    callback = function()
      vim.defer_fn(function()
        -- CORREGIDO: Usar directamente el índice actual
        local current_scheme = M.color_schemes[M.current_scheme_index]
        M.apply_color_scheme(current_scheme)
      end, 100)
    end,
    group = augroup,
  })

  -- Mantener colores cuando se abre/entra a ventanas
  vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    pattern = "*",
    callback = function()
      local filetype = vim.bo.filetype
      if filetype == "neo-tree" then
        vim.defer_fn(function()
          -- CORREGIDO: Usar directamente el índice actual
          local current_scheme = M.color_schemes[M.current_scheme_index]
          M.apply_color_scheme(current_scheme)
        end, 50)
      end
    end,
    group = augroup,
  })
end

-- Función para obtener el esquema actual (CORREGIDA)
function M.get_current_scheme()
  return M.color_schemes[M.current_scheme_index]
end

return M

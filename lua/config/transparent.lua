-- lua/config/transparent.lua
local M = {}
local is_transparent = false -- Inicia sin transparencia

-- Función para guardar los colores originales del tema
local function save_original_colors()
  M.original_colors = {
    Normal = vim.api.nvim_get_hl(0, { name = "Normal" }),
    NormalNC = vim.api.nvim_get_hl(0, { name = "NormalNC" }),
    EndOfBuffer = vim.api.nvim_get_hl(0, { name = "EndOfBuffer" }),
    VertSplit = vim.api.nvim_get_hl(0, { name = "VertSplit" }),
    SignColumn = vim.api.nvim_get_hl(0, { name = "SignColumn" }),
    LineNr = vim.api.nvim_get_hl(0, { name = "LineNr" }),
    CursorLineNr = vim.api.nvim_get_hl(0, { name = "CursorLineNr" }),
    StatusLine = vim.api.nvim_get_hl(0, { name = "StatusLine" }),
    StatusLineNC = vim.api.nvim_get_hl(0, { name = "StatusLineNC" }),
    NeoTreeNormal = vim.api.nvim_get_hl(0, { name = "NeoTreeNormal" }),
    NeoTreeNormalNC = vim.api.nvim_get_hl(0, { name = "NeoTreeNormalNC" }),
  }
end

-- Función para preservar colores de carpetas
local function preserve_folder_colors()
  local ok, folder_colors = pcall(require, "config.folder-colors")
  if ok then
    local current_scheme = folder_colors.get_current_scheme()
    if current_scheme then
      folder_colors.apply_color_scheme(current_scheme)
    end
  end
end

function M.toggle_transparency()
  if is_transparent then
    -- QUITAR transparencia (restaurar fondo)
    -- Primero recarga el tema completo
    vim.cmd("colorscheme tokyonight")

    -- Luego restaura las personalizaciones de colores
    vim.schedule(function()
      -- Recargar las personalizaciones de colores
      require("config.colors")

      -- Restaurar configuraciones específicas de tu tema personalizado
      vim.cmd([[highlight Normal guibg=#191919]])
      vim.cmd([[highlight NormalNC guibg=#191919]])

      -- Restaurar colores de NeoTree
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#111111" })
      vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#111111" })
      vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "#111111" })

      -- PRESERVAR colores de carpetas
      preserve_folder_colors()
    end)

    vim.notify("Transparencia desactivada", vim.log.levels.INFO)
  else
    -- Guardar colores originales antes de aplicar transparencia
    save_original_colors()

    -- ACTIVAR transparencia
    vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
    vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
    vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")
    vim.cmd("highlight VertSplit guibg=NONE ctermbg=NONE")
    vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")
    vim.cmd("highlight LineNr guibg=NONE ctermbg=NONE")
    vim.cmd("highlight CursorLineNr guibg=NONE ctermbg=NONE")
    vim.cmd("highlight StatusLine guibg=NONE ctermbg=NONE")
    vim.cmd("highlight StatusLineNC guibg=NONE ctermbg=NONE")

    -- También hacer NeoTree transparente
    vim.cmd("highlight NeoTreeNormal guibg=NONE ctermbg=NONE")
    vim.cmd("highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE")
    vim.cmd("highlight NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE")
    vim.cmd("highlight NeoTreeVertSplit guibg=NONE ctermbg=NONE")

    -- PRESERVAR colores de carpetas después de aplicar transparencia
    vim.schedule(function()
      preserve_folder_colors()
    end)

    vim.notify("Transparencia activada", vim.log.levels.INFO)
  end
  is_transparent = not is_transparent
end

-- Función para inicializar transparencia si se desea al inicio
function M.init_transparency()
  if is_transparent then
    M.toggle_transparency()
  end
end

function M.get_status()
  return is_transparent
end

return M

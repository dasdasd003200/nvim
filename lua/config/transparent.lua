-- config/transparent.lua
local M = {}
local is_transparent = false -- Inicia sin transparencia

function M.toggle_transparency()
  if is_transparent then
    -- QUITAR transparencia (restaurar fondo)
    -- Necesitas restaurar los colores del tema
    vim.cmd("colorscheme tokyonight") -- Recarga el tema completo
  else
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
  end
  is_transparent = not is_transparent
end

-- No necesitas init_transparency si quieres empezar sin transparencia
function M.get_status()
  return is_transparent
end

return M

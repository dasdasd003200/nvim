local M = {}

local is_transparent = true

function M.toggle_transparency()
  if is_transparent then
    vim.cmd("highlight clear Normal")
    vim.cmd("highlight clear NormalNC")
    vim.cmd("highlight clear EndOfBuffer")
    vim.cmd("highlight clear VertSplit")
    vim.cmd("highlight clear SignColumn")
  else
    vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
    vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
    vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")
    vim.cmd("highlight VertSplit guibg=NONE")
    vim.cmd("highlight SignColumn guibg=NONE")
  end
  is_transparent = not is_transparent
end

-- Inicializa transparente al cargar
function M.init_transparency()
  if is_transparent then
    M.toggle_transparency() -- lo activa
    is_transparent = false -- invertido porque toggle lo cambia
  end
end

return M

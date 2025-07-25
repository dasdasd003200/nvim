local map = vim.keymap.set
-- En modo visual, cuando presionas `p`, reemplaza sin copiar al registro
map("v", "p", '"_dP', { noremap = true, silent = true })
-- map("n", "p", '"_dP', { noremap = true, silent = true })
-- En modo visual, cuando presionas `x`, elimina sin copiar al registro
map("v", "x", '"_x', { noremap = true, silent = true })
map("n", "x", '"_x', { noremap = true, silent = true })

-- En modo normal, cuando presionas `ss`, elimina la línea sin copiarla
map("n", "ss", '"_dd', { noremap = true, silent = true })

-- En modo visual, cuando presionas `ss`, elimina la selección sin copiarla
map("v", "ss", '"_d', { noremap = true, silent = true })

-- Mapeo para buscar dentro del buffer actual con Telescope current_buffer_fuzzy_find
map("n", "<leader>fa", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true })

-- Buscar palabra en todo el documento
map("n", "<leader>fw", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- Elimina el buffer actual usando Ctrl+w
map("n", "<C-w>", ":bd<CR>", { noremap = true, silent = true })

-- Cambiar al siguiente buffer con Ctrl + a
vim.api.nvim_set_keymap("n", "<C-f>", ":bnext<CR>", { noremap = true, silent = true })

-- Cambiar al buffer anterior con Ctrl + s
vim.api.nvim_set_keymap("n", "<C-a>", ":bprev<CR>", { noremap = true, silent = true })

-- Mover línea hacia abajo con atrl+upo down
map("n", "<A-Up>", ":m-2<CR>", { noremap = true, silent = true, desc = "Move line up" })
map("n", "<A-Down>", ":m+<CR>", { noremap = true, silent = true, desc = "Move line down" })

-- Mover líneas hacia arriba en modo visual con Alt + Up
map("x", "<A-Up>", ":move '<-2<CR>gv-gv", { noremap = true, silent = true, desc = "Move lines up" })
-- Mover líneas hacia abajo en modo visual con Alt + Down
map("x", "<A-Down>", ":move '>+1<CR>gv-gv", { noremap = true, silent = true, desc = "Move lines down" })

-- Función para generar un console.log con la palabra bajo el cursor
local function insert_console_log()
  local word = vim.fn.expand("<cword>")
  local log_entry = string.format('console.log("%s====>", %s)', word, word)
  vim.api.nvim_put({ log_entry }, "l", true, true) -- Inserta el texto en la línea actual
end
-- Mapea Ctrl + l para insertar un console.log con la palabra bajo el cursor
map("n", "<C-A-l>", insert_console_log, { noremap = true, silent = true })

-- Función para generar un console.log con JSON.stringify
local function insert_console_logJson()
  local word = vim.fn.expand("<cword>")
  local log_entry = string.format("console.log('%s=====>', JSON.stringify(%s, null, 2))", word, word)
  vim.api.nvim_put({ log_entry }, "l", true, true) -- Inserta el texto en la línea actual
end

-- Mapea Ctrl + Shift  para insertar un console.log con JSON.stringify
map("n", "<C-A-k>", insert_console_logJson, { noremap = true, silent = true })

--Mapea para abrir el trouble de errores
map("n", "<Leader>t", function()
  vim.cmd("Trouble diagnostics")
  vim.defer_fn(function()
    vim.cmd("wincmd j")
  end, 100) -- Delay of 50 milliseconds
end, { noremap = true, silent = true, desc = "Show Trouble diagnostics and move to the window" })

-- Mapeo para seleccionar la palabra bajo el cursor y entrar en modo visual
map("n", "<leader>d", "viw", { noremap = true, silent = true, desc = "Select current word" })

-- Añadir mapeo para búsqueda y reemplazo sensible a mayúsculas/minúsculas
map("n", "<leader>sx", function()
  vim.ui.input({ prompt = "Copiar copiar: " }, function(old)
    if old then
      vim.ui.input({ prompt = "Pegar pegar: " }, function(new)
        if new then
          old = old:gsub("%%", "\\%%"):gsub("%^", "\\^")
          new = new:gsub("%%", "\\%%")
          vim.cmd(string.format("%%s/\\C%s/%s/g", old, new))
          vim.cmd('echom "Copiar copiar completado"')
          vim.cmd("nohlsearch")
        end
      end)
    end
  end)
end, { desc = "Copiar copiar y Pegar pegar", noremap = true, silent = true })

-- Para el modo normal, desmapear Ctrl + flecha arriba y abajo
map("n", "<C-Up>", "<NOP>", { noremap = true, silent = true })
map("n", "<C-Down>", "<NOP>", { noremap = true, silent = true })

-- Si también quieres desactivarlo en otros modos como el modo visual
map("v", "<C-Up>", "<NOP>", { noremap = true, silent = true })
map("v", "<C-Down>", "<NOP>", { noremap = true, silent = true })

-- Función para abrir terminal en la ubicación del archivo actual
local function open_terminal_in_file_dir()
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    vim.notify("No hay archivo abierto, usando directorio actual", vim.log.levels.WARN)
    return
  end
  local file_dir = vim.fn.fnamemodify(file_path, ":h")
  vim.cmd("tabnew")
  vim.cmd("lcd " .. vim.fn.fnameescape(file_dir))
  vim.cmd("terminal")
  vim.notify("Terminal abierta en: " .. file_dir, vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>bu", open_terminal_in_file_dir, {
  noremap = true,
  silent = true,
  desc = "Open terminal in current file's directory",
})

map("n", "<leader>rp", require("config.transparent").toggle_transparency, {
  desc = "transparent",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>ri", _G.gather_file_contents_smart, {
  noremap = true,
  silent = true,
  desc = "Smart file content gatherer (Node.js/Python)",
})

-- NUEVOS MAPEOS PARA COLORES DE CARPETAS
vim.keymap.set("n", "<leader>rl", function()
  require("config.folder-colors").cycle_folder_colors()
end, {
  noremap = true,
  silent = true,
  desc = "Cambiar colores de carpetas",
})

-- Mapeo alternativo para mostrar menú de selección de colores
vim.keymap.set("n", "<leader>rm", function()
  require("config.folder-colors").show_color_menu()
end, {
  noremap = true,
  silent = true,
  desc = "Menú de colores de carpetas",
})

-- Mostrar el pajarito con <leader>ry
map("n", "<leader>ry", _G.show_little_bird, {
  noremap = true,
  silent = true,
  desc = "Show little bird animation",
})

-- Comment Remover - Eliminar todos los comentarios con <leader>rc
map("n", "<leader>rc", function()
  local ok, comment_remover = pcall(require, "config.comment-remover")
  if not ok then
    vim.notify("❌ Error: No se pudo cargar comment-remover", vim.log.levels.ERROR)
    return
  end
  comment_remover.remove_comments_with_confirmation()
end, {
  noremap = true,
  silent = true,
  desc = "Elimrnar todos los comentarios del archivo",
})

-- Mapeo principal para abrir/cerrar terminal
map("n", "<leader>rt", function()
  require("config.terminal").toggle_terminal()
end, { noremap = true, silent = true, desc = "Toggle Terminal" })

-- Atajo rápido alternativo
map("n", "<F11>", function()
  require("config.terminal").toggle_terminal()
end, { noremap = true, silent = true, desc = "Toggle Terminal" })

-- Función helper mejorada para revelar archivo actual en Neo-tree
local function smart_neotree_toggle(source)
  local current_file = vim.fn.expand("%:p")
  local manager = require("neo-tree.sources.manager")
  local state = manager.get_state(source)
  if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
    vim.cmd("Neotree close")
  else
    if current_file == "" then
      vim.cmd("Neotree show " .. source)
    else
      vim.cmd("Neotree show " .. source .. " reveal")
    end

    vim.defer_fn(function()
      vim.cmd("Neotree focus " .. source)
    end, 200)
  end
end

-- <leader>1: Abrir/cerrar Neo-tree en Files (con cursor automático)
map("n", "<leader>1", function()
  smart_neotree_toggle("filesystem")
end, { desc = "Toggle Neo-tree Files (auto focus)" })

-- <leader>2: Abrir/cerrar Neo-tree en Buffers (con cursor automático)
map("n", "<leader>2", function()
  smart_neotree_toggle("buffers")
end, { desc = "Toggle Neo-tree Buffers (auto focus)" })

-- <leader>3: Abrir/cerrar Neo-tree en Git (con cursor automático)
map("n", "<leader>3", function()
  smart_neotree_toggle("git_status")
end, { desc = "Toggle Neo-tree Git (auto focus)" })

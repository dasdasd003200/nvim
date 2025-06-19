-- lua/config/terminal.lua
local M = {}

-- Variable para trackear la ventana del terminal
local terminal_win = nil
local terminal_buf = nil

function M.toggle_terminal()
  -- Si la ventana existe y está abierta, cerrarla
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    vim.api.nvim_win_close(terminal_win, false)
    terminal_win = nil
    return
  end

  -- Calcular dimensiones (80% ancho, 70% alto)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.7)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Crear buffer si no existe o si fue eliminado
  if not terminal_buf or not vim.api.nvim_buf_is_valid(terminal_buf) then
    terminal_buf = vim.api.nvim_create_buf(false, true)

    -- Configurar el buffer del terminal
    vim.api.nvim_buf_set_option(terminal_buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(terminal_buf, "buflisted", false)
  end

  -- Crear ventana flotante bonita
  terminal_win = vim.api.nvim_open_win(terminal_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Terminal ",
    title_pos = "center",
  })

  -- Configurar highlights para que se vea bonito
  vim.api.nvim_win_set_option(terminal_win, "winhl", "Normal:Normal,FloatBorder:FloatBorder")

  -- Si es un buffer nuevo o vacío, iniciar terminal
  if
    vim.api.nvim_buf_line_count(terminal_buf) <= 1
    and vim.api.nvim_buf_get_lines(terminal_buf, 0, -1, false)[1] == ""
  then
    vim.fn.termopen(vim.o.shell, {
      on_exit = function()
        -- Cuando el terminal se cierra, limpiar variables
        if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
          vim.api.nvim_win_close(terminal_win, false)
        end
        terminal_win = nil
        terminal_buf = nil
      end,
    })
  end

  -- Configurar mapeos específicos para este terminal
  M.setup_terminal_keymaps()

  -- Entrar en modo terminal automáticamente
  vim.cmd("startinsert")
end

function M.setup_terminal_keymaps()
  if not terminal_buf then
    return
  end

  -- Mapeos para cuando estás en modo terminal (escribiendo)
  vim.keymap.set("t", "<Esc><Esc>", function()
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
      vim.api.nvim_win_close(terminal_win, false)
      terminal_win = nil
    end
  end, { buffer = terminal_buf, desc = "Close terminal" })

  -- Solo salir del modo terminal con Esc (para navegar)
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = terminal_buf, desc = "Exit terminal mode" })

  -- F12 también cierra
  vim.keymap.set({ "t", "n" }, "<F12>", function()
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
      vim.api.nvim_win_close(terminal_win, false)
      terminal_win = nil
    end
  end, { buffer = terminal_buf, desc = "Close terminal" })

  -- Mapeos para cuando estás en modo normal (navegando)
  vim.keymap.set("n", "q", function()
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
      vim.api.nvim_win_close(terminal_win, false)
      terminal_win = nil
    end
  end, { buffer = terminal_buf, desc = "Close terminal" })

  -- Volver al modo terminal
  vim.keymap.set("n", "i", "i", { buffer = terminal_buf, desc = "Enter terminal mode" })
  vim.keymap.set("n", "a", "a", { buffer = terminal_buf, desc = "Enter terminal mode" })

  -- MODO VISUAL para seleccionar y copiar texto
  -- Entrar en modo visual con v
  vim.keymap.set("n", "v", "v", { buffer = terminal_buf, desc = "Enter visual mode" })
  vim.keymap.set("n", "V", "V", { buffer = terminal_buf, desc = "Enter visual line mode" })

  -- Selección rápida con Shift + flechas
  vim.keymap.set("n", "<S-Up>", "V<Up>", { buffer = terminal_buf, desc = "Select line up" })
  vim.keymap.set("n", "<S-Down>", "V<Down>", { buffer = terminal_buf, desc = "Select line down" })
  vim.keymap.set("n", "<S-Left>", "v<Left>", { buffer = terminal_buf, desc = "Select char left" })
  vim.keymap.set("n", "<S-Right>", "v<Right>", { buffer = terminal_buf, desc = "Select char right" })

  -- En modo visual, expandir selección con Shift + flechas
  vim.keymap.set("v", "<S-Up>", "<Up>", { buffer = terminal_buf, desc = "Extend selection up" })
  vim.keymap.set("v", "<S-Down>", "<Down>", { buffer = terminal_buf, desc = "Extend selection down" })
  vim.keymap.set("v", "<S-Left>", "<Left>", { buffer = terminal_buf, desc = "Extend selection left" })
  vim.keymap.set("v", "<S-Right>", "<Right>", { buffer = terminal_buf, desc = "Extend selection right" })

  -- Copiar con 'y' en modo visual
  vim.keymap.set("v", "y", '"+y<Esc>', { buffer = terminal_buf, desc = "Copy selection to clipboard" })

  -- Copiar línea completa con 'yy' en modo normal
  vim.keymap.set("n", "yy", '"+yy', { buffer = terminal_buf, desc = "Copy line to clipboard" })

  -- Seleccionar todo con Ctrl+a
  vim.keymap.set("n", "<C-a>", "ggVG", { buffer = terminal_buf, desc = "Select all" })

  -- Salir del modo visual con Esc
  vim.keymap.set("v", "<Esc>", "<Esc>", { buffer = terminal_buf, desc = "Exit visual mode" })

  -- Configurar opciones del buffer
  vim.schedule(function()
    if vim.api.nvim_buf_is_valid(terminal_buf) then
      vim.api.nvim_buf_set_option(terminal_buf, "number", false)
      vim.api.nvim_buf_set_option(terminal_buf, "relativenumber", false)
      vim.api.nvim_buf_set_option(terminal_buf, "signcolumn", "no")
    end
  end)
end

-- Función para verificar si el terminal está abierto
function M.is_open()
  return terminal_win and vim.api.nvim_win_is_valid(terminal_win)
end

return M

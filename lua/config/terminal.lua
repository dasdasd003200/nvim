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

  -- Calcular dimensiones (85% ancho, 75% alto para más espacio)
  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.75)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Crear buffer si no existe o si fue eliminado
  if not terminal_buf or not vim.api.nvim_buf_is_valid(terminal_buf) then
    terminal_buf = vim.api.nvim_create_buf(false, true)

    -- Configurar el buffer del terminal
    vim.api.nvim_buf_set_option(terminal_buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(terminal_buf, "buflisted", false)
  end

  -- Obtener información del sistema para el header
  local username = vim.fn.expand("$USER") or "user"
  local hostname = vim.fn.hostname() or "localhost"
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local time = os.date("%H:%M")
  local date = os.date("%d/%m/%Y")

  -- Crear título dinámico súper estilizado
  local title = string.format(" 🚀 %s@%s | %s | %s ", username, hostname, cwd, time)

  -- Crear ventana flotante súper bonita
  terminal_win = vim.api.nvim_open_win(terminal_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Bordes súper bonitos
    title = title,
    title_pos = "center",
    footer = string.format(" 💻 Terminal | ESC: Navigate | ESC ESC: Close | %s ", date),
    footer_pos = "center",
  })

  -- Aplicar highlights súper estilizados
  M.setup_terminal_highlights()

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

  -- Mostrar mensaje de bienvenida estilizado
  if vim.api.nvim_buf_line_count(terminal_buf) <= 1 then
    vim.schedule(function()
      -- Mensaje de bienvenida bonito
      local welcome_cmd = string.format(
        'echo "\\n🎨 Welcome to the Stylized Terminal! 🎨\\n📁 Current directory: %s\\n⚡ Ready for action!\\n"',
        vim.fn.getcwd()
      )
      vim.fn.chansend(vim.bo[terminal_buf].channel, welcome_cmd .. "\n")
    end)
  end
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

  -- Configurar opciones del buffer con estilo
  vim.schedule(function()
    if vim.api.nvim_buf_is_valid(terminal_buf) then
      vim.api.nvim_buf_set_option(terminal_buf, "number", false)
      vim.api.nvim_buf_set_option(terminal_buf, "relativenumber", false)
      vim.api.nvim_buf_set_option(terminal_buf, "signcolumn", "no")

      -- Aplicar highlights después de configurar el buffer
      M.setup_terminal_highlights()
    end
  end)
end

-- Función para verificar si el terminal está abierto
function M.is_open()
  return terminal_win and vim.api.nvim_win_is_valid(terminal_win)
end

-- Configurar highlights súper estilizados
function M.setup_terminal_highlights()
  -- Crear highlights personalizados para la terminal
  vim.api.nvim_set_hl(0, "TerminalBorder", {
    fg = "#8be9fd", -- Cyan brillante para el borde
    bg = "NONE",
    bold = true,
  })

  vim.api.nvim_set_hl(0, "TerminalTitle", {
    fg = "#50fa7b", -- Verde neón para el título
    bg = "#282a36", -- Fondo oscuro
    bold = true,
    italic = true,
  })

  vim.api.nvim_set_hl(0, "TerminalFooter", {
    fg = "#ff79c6", -- Rosa magenta para el footer
    bg = "#282a36", -- Fondo oscuro
    bold = true,
  })

  vim.api.nvim_set_hl(0, "TerminalBackground", {
    fg = "#f8f8f2", -- Texto claro
    bg = "#1e1e2e", -- Fondo ligeramente diferente para destacar
  })

  -- Aplicar los highlights a la ventana
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    vim.api.nvim_win_set_option(
      terminal_win,
      "winhl",
      "Normal:TerminalBackground,FloatBorder:TerminalBorder,FloatTitle:TerminalTitle,FloatFooter:TerminalFooter"
    )

    -- Configurar el cursor para que sea más visible
    vim.api.nvim_win_set_option(terminal_win, "cursorline", false) -- Sin línea de cursor que pueda molestar
  end
end

return M

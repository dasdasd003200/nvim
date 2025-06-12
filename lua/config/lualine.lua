require("lualine").setup({
  options = {
    theme = "auto", -- Usar el tema actual
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch", -- Muestra la rama de git
      "diff", -- Muestra los cambios (git diff)
      "diagnostics", -- Muestra los diagnósticos (LSP)
    },
    lualine_c = { "filename" },
    lualine_x = {
      "encoding", -- Muestra la codificación del archivo (por ejemplo, UTF-8)
      "fileformat", -- Muestra el formato del archivo (por ejemplo, Unix)
      "filetype", -- Muestra el tipo de archivo (con ícono)
      {
        -- Mostrar el porcentaje de progreso en el archivo
        function()
          local current_line = vim.fn.line(".")
          local total_lines = vim.fn.line("$")
          local percent = math.floor((current_line / total_lines) * 100)
          return string.format("%3d", percent) .. "%%" -- Asegurar un ancho fijo para el porcentaje
        end,
        color = { fg = "#ffffff", gui = "bold" }, -- Personaliza el color del porcentaje
        padding = { left = 2, right = 2 }, -- Espacio antes y después del porcentaje
      },
      {
        -- Mostrar el nombre de la última carpeta con lógica condicional y fondo personalizado
        function()
          local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          if cwd == "zEMVThreeServiceContextV4" then
            return "Back"
          elseif cwd == "zEMVThreeClientStandaloneV6" then
            return "Front"
          else
            return cwd
          end
        end,
        color = function()
          local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          if cwd == "zEMVThreeServiceContextV4" then
            return { fg = "#33c3ff", bg = "#3f3f3f", gui = "bold" } -- Color para "Front" con fondo gris oscuro
          elseif cwd == "zEMVThreeClientStandaloneV6" then
            return { fg = "#ff5733", bg = "#3f3f3f", gui = "bold" } -- Color para "Back" con fondo gris oscuro
          else
            return { fg = "#ffffff", bg = "#3f3f3f", gui = "bold" } -- Color por defecto con fondo gris medio
          end
        end,
        padding = { left = 2, right = 2 }, -- Espacio antes del nombre de la carpeta
      },
    },
    lualine_y = {},
    lualine_z = {
      {
        -- Mostrar la hora actual en la esquina derecha
        'os.date("%H:%M")',
        color = { fg = "#ffffff", bg = "#000000" }, -- Fondo negro para la hora
        icon = "🕒",
        padding = { left = 2, right = 2 }, -- Espacio alrededor de la hora
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})

-- lua/plugins/nvim-notify.lua
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require("notify")

    notify.setup({
      -- ESTILOS DE PRESENTACIÓN (descomenta solo uno)
      -- render = "minimal", -- Muy discreto, solo texto
      -- render = "simple", -- Minimalista básico
      -- render = "compact", -- Compacto con icono
      render = "wrapped-compact", -- Compacto con texto ajustado
      -- render = "default", -- Completo con todos los elementos

      -- ANIMACIONES (descomenta solo una)
      stages = "slide", -- Deslizamiento suave
      -- stages = "fade",         -- Desvanecimiento
      -- stages = "fade_in_slide_out", -- Aparece desvaneciéndose, sale deslizándose
      -- stages = "static",       -- Sin animación

      -- TRANSPARENCIA (descomenta solo una)
      -- background_colour = "Normal", -- Transparente (usa fondo del editor)
      background_colour = "#1e1e2e", -- Fondo oscuro sólido
      -- background_colour = "#000000", -- Fondo negro sólido
      -- background_colour = "NONE", -- SÚPER TRANSPARENTE (completamente invisible)

      -- POSICIÓN (descomenta solo una)
      top_down = true, -- Notificaciones de arriba hacia abajo
      -- top_down = false,        -- Notificaciones de abajo hacia arriba

      -- CONFIGURACIÓN BÁSICA
      timeout = 3000, -- Duración: 3 segundos
      minimum_width = 50, -- Ancho mínimo
      level = 2, -- Mostrar desde INFO hacia arriba (oculta DEBUG)

      -- Hacer ventana no enfocable
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { focusable = false })
      end,
    })

    -- Usar notify como manejador por defecto
    vim.notify = notify

    -- PERSONALIZACIÓN DE COLORES (descomenta para activar)
    vim.schedule(function()
      -- PERSONALIZACIÓN TOTAL (descomenta para usar colores personalizados)
      -- vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#ff79c6" }) -- Rosa magenta para títulos de info
      -- vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = "#bd93f9" }) -- Púrpura para texto de info
      -- vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = "#ff79c6" }) -- Rosa magenta para íconos de info
      -- vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#ff79c6" }) -- Rosa magenta para bordes de info
      -- vim.api.nvim_set_hl(0, "NotifyINFOBackground", { bg = "#ff79c6" }) -- Fondo ROSA MAGENTA para todas
    end)
  end,
}

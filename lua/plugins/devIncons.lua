-- lua/plugins/devicons.lua
return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      -- Habilitar colores por defecto
      color_icons = true,
      -- Usar colores por defecto
      default = true,
      -- Configuración estricta para asegurar colores
      strict = true,
      -- Configuraciones específicas para carpetas
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore",
        },
      },
      -- Configuraciones por extensión
      override_by_extension = {
        ["log"] = {
          icon = "",
          color = "#81e043",
          name = "Log",
        },
      },
      -- Configuraciones específicas para tipos de archivo
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh",
        },
        -- Configuración inicial para carpetas (será sobrescrita por folder-colors)
        folder = {
          icon = "",
          color = "#ffcc02", -- Color inicial amarillo
          name = "Folder",
        },
        -- Carpeta abierta
        folder_open = {
          icon = "",
          color = "#ffcc02", -- Color inicial amarillo
          name = "FolderOpen",
        },
      },
    })

    -- Inicializar el sistema de colores de carpetas después de configurar devicons
    vim.schedule(function()
      local ok, folder_colors = pcall(require, "config.folder-colors")
      if ok then
        folder_colors.init()
      end
    end)
  end,
}

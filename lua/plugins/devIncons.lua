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
        -- Configuración específica para carpetas
        folder = {
          icon = "",
          color = "#ffcc02", -- Color amarillo para carpetas
          name = "Folder",
        },
        -- Carpeta abierta
        folder_open = {
          icon = "",
          color = "#ffcc02", -- Color amarillo para carpetas abiertas
          name = "FolderOpen",
        },
      },
    })

    -- Forzar actualización de colores para NeoTree
    vim.schedule(function()
      -- Configurar colores específicos para iconos de carpetas en NeoTree
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#ffcc02" })
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#8be9fd" })
      vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#f8f8f2" })
    end)
  end,
}

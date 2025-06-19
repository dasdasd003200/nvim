-- lua/plugins/transparent.lua
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      -- style = "night", -- "storm", "moon", "day", "night"
      transparent = false, -- Mantén false para control manual
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "neo-tree" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,

      --- Personalizar colores base
      on_colors = function(colors)
        -- Aplicar tus colores personalizados
        colors.bg = "#191919" -- Cambia el color de fondo a #191919
        colors.bg_dark = "#191919" -- Cambia el color de fondo oscuro a #191919
        colors.bg_sidebar = "#111111" -- Fondo para sidebars como NeoTree

        -- Colores personalizados para NeoTree
        colors.neotree = {
          normal = "#111111",
          end_of_buffer = "#111111",
          vert_split = "#111111",
        }
      end,

      --- Personalizar highlights específicos
      on_highlights = function(highlights, colors)
        -- Fondos principales
        highlights.Normal = { fg = colors.fg, bg = colors.bg }
        highlights.NormalNC = { fg = colors.fg, bg = colors.bg }

        -- Configuración específica para NeoTree
        highlights.NeoTreeNormal = { fg = colors.fg_sidebar, bg = colors.neotree.normal }
        highlights.NeoTreeNormalNC = { fg = colors.fg_sidebar, bg = colors.neotree.normal }
        highlights.NeoTreeEndOfBuffer = { fg = colors.bg, bg = colors.neotree.end_of_buffer }
        highlights.NeoTreeVertSplit = { fg = colors.neotree.vert_split, bg = colors.neotree.vert_split }

        -- Otros elementos de NeoTree
        highlights.NeoTreeWinSeparator = { fg = colors.neotree.vert_split, bg = colors.neotree.vert_split }
        highlights.NeoTreeBorder = { fg = colors.neotree.normal, bg = colors.neotree.normal }

        -- Asegurar consistencia en la línea de estado
        highlights.StatusLine = { fg = colors.fg, bg = colors.bg_statusline or colors.bg_dark }
        highlights.StatusLineNC = { fg = colors.fg_gutter, bg = colors.bg_statusline or colors.bg_dark }
      end,
    })

    -- Aplicar el colorscheme
    vim.cmd([[colorscheme tokyonight]])

    -- Aplicar configuraciones adicionales después de cargar el tema
    vim.schedule(function()
      -- Aplica los colores personalizados para NeoTree (refuerzo)
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#111111" })
      vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#111111" })
      vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "#111111" })
      vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#111111", bg = "#111111" })
      vim.api.nvim_set_hl(0, "NeoTreeBorder", { fg = "#111111", bg = "#111111" })

      -- Cargar personalizaciones adicionales de colores
      require("config.colors")
    end)
  end,
}

-- plugins/tokyonight.lua
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      -- style = "night", -- o "storm", "moon", "day"
      transparent = false, -- Mantén false para poder controlar manualmente
      styles = {
        sidebars = "normal", -- Cambia a "normal" para mejor control
        floats = "normal", -- Cambia a "normal" para mejor control
      },
      on_highlights = function(hl, c)
        -- Puedes personalizar colores aquí si es necesario
      end,
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}

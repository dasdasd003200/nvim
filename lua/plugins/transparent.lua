return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    })

    vim.cmd([[colorscheme tokyonight]])
    require("config.transparent").init_transparency()
  end,
}

-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {
--     style = "storm", -- Puedes usar: "storm", "moon", "night", "day"
--     transparent = true, -- ¡esto activa el fondo transparente!
--     styles = {
--       sidebars = "transparent",
--       floats = "transparent",
--     },
--   },
-- }
--
-- -- return {
-- --   "navarasu/onedark.nvim",
-- --   opts = {
-- --     style = "darker",
-- --     transparent = true,
-- --   },
-- -- }

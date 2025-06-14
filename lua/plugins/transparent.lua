return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      -- style = "storm",
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    })

    vim.cmd([[colorscheme tokyonight]])
    -- require("config.transparent").init_transparency()
  end,
}

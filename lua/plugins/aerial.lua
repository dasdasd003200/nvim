return {
  {
    "stevearc/aerial.nvim",
    opts = {
      open_automatic = false,
    },
    -- optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}

-- return {
--   {
--     "stevearc/aerial.nvim",
--     opts = {
--       open_automatic = false,
--       backends = {
--         ["_"] = { "treesitter", "lsp" },
--         html = { "treesitter" },
--         typescript = { "treesitter" },
--       },
--       filter_kind = {
--         -- Para HTML/Angular
--         "Component",
--         "Tag",
--         "Template",
--         "Section",
--         -- Para TypeScript
--         "Class",
--         "Function",
--         "Method",
--         "Interface",
--         "Enum",
--       },
--       -- Colapsar contenido interno
--       collapse_level = 0,
--       show_guides = false,
--     },
--     dependencies = {
--       "nvim-treesitter/nvim-treesitter",
--       "nvim-web-devicons",
--     },
--   },
-- }


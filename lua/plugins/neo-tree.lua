--
-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   opts = {
--     filesystem = {
--       filtered_items = {
--         visible = true,
--         show_hidden_count = true,
--         hide_dotfiles = false,
--         hide_gitignored = true,
--         hide_by_name = {
--           -- '.git',
--           -- '.DS_Store',
--           -- 'thumbs.db',
--         },
--         never_show = {},
--       },
--     },
--   },
-- }
--

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          -- '.git',
          -- '.DS_Store',
          -- 'thumbs.db',
        },
        never_show = {},
      },
    },
    -- Configuración de íconos de git
    default_component_configs = {
      git_status = {
        symbols = {
          -- Símbolos simples sin caracteres especiales
          added = "+",
          modified = "●", -- Solo el punto
          deleted = "-",
          renamed = "R",
          untracked = "?",
          ignored = "",
          unstaged = "●",
          staged = "S",
          conflict = "!",
        },
      },
    },
    -- Alternativamente, si quieres deshabilitar completamente los íconos de git:
    -- window = {
    --   mappings = {
    --     ["<space>"] = "none",
    --   },
    -- },
    -- source_selector = {
    --   winbar = false,
    --   statusline = false,
    -- },
  },
}

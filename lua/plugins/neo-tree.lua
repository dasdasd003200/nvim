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
    -- Configuración de íconos de git (deshabilitados)
    default_component_configs = {
      git_status = {
        symbols = {
          added = "",
          modified = "",
          deleted = "",
          renamed = "",
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
    },
    -- Alternativamente, si quieres deshabilitar completamente los íconos de git:
    window = {
      mappings = {
        ["<space>"] = "none",
      },
    },
    source_selector = {
      winbar = false,
      statusline = false,
    },
  },
}

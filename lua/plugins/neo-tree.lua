return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    default_source = "filesystem",

    source_selector = {
      winbar = true, -- Mostrar pestañas en la parte superior
      statusline = false, -- No mostrar en statusline
      content_layout = "center", -- Centrar el contenido
      sources = {
        { source = "filesystem" },
        { source = "buffers" },
        { source = "git_status" },
      },
      tabs = {
        { source = "filesystem", display_name = "  Files" },
        { source = "buffers", display_name = "  Buffers" },
        { source = "git_status", display_name = "  Git" },
      },
    },

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

    -- Configuración para la pestaña de buffers
    buffers = {
      follow_current_file = {
        enabled = true, -- Seguir el archivo actual
      },
      group_empty_dirs = true, -- Agrupar directorios vacíos
      show_unloaded = true, -- Mostrar buffers no cargados
    },

    -- Configuración para la pestaña de git
    git_status = {
      window = {
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        },
      },
    },

    -- Configuración de íconos de git (sin modificar)
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

    window = {
      width = 50, -- 🔧 CAMBIA ESTE NÚMERO: 30=estrecho, 45=medio, 60=ancho, 80=muy ancho
      mappings = {
        ["1"] = function()
          vim.cmd("Neotree focus filesystem")
        end,
        ["2"] = function()
          vim.cmd("Neotree focus buffers")
        end,
        ["3"] = function()
          vim.cmd("Neotree focus git_status")
        end,
      },
    },
  },
}

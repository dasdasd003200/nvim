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

        -- 🔥 NUEVA FUNCIÓN: Abrir todos los archivos de una carpeta
        ["O"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            local function open_all_files_in_dir(dir_path)
              local files_opened = 0
              local handle = vim.loop.fs_scandir(dir_path)

              if handle then
                while true do
                  local name, type = vim.loop.fs_scandir_next(handle)
                  if not name then
                    break
                  end

                  local full_path = dir_path .. "/" .. name

                  -- Si es un archivo, abrirlo
                  if type == "file" then
                    -- Filtrar archivos que no queremos abrir
                    local ignored_extensions = { ".pyc", ".pyo", ".class", ".o", ".so", ".dll" }
                    local ignored_files = { ".DS_Store", "Thumbs.db", ".gitignore" }

                    local should_ignore = false

                    -- Verificar extensiones ignoradas
                    for _, ext in ipairs(ignored_extensions) do
                      if name:match(ext .. "$") then
                        should_ignore = true
                        break
                      end
                    end

                    -- Verificar archivos específicos ignorados
                    for _, ignored in ipairs(ignored_files) do
                      if name == ignored then
                        should_ignore = true
                        break
                      end
                    end

                    if not should_ignore then
                      vim.cmd("edit " .. vim.fn.fnameescape(full_path))
                      files_opened = files_opened + 1
                    end

                  -- Si es un directorio, recursión
                  elseif type == "directory" and name ~= "." and name ~= ".." then
                    -- Evitar directorios que suelen tener muchos archivos innecesarios
                    local ignored_dirs = {
                      "node_modules",
                      ".git",
                      "__pycache__",
                      ".pytest_cache",
                      "dist",
                      "build",
                      ".venv",
                      "venv",
                      ".env",
                    }

                    local should_ignore_dir = false
                    for _, ignored in ipairs(ignored_dirs) do
                      if name == ignored then
                        should_ignore_dir = true
                        break
                      end
                    end

                    if not should_ignore_dir then
                      files_opened = files_opened + open_all_files_in_dir(full_path)
                    end
                  end
                end
              end

              return files_opened
            end

            local total_files = open_all_files_in_dir(node.path)
            vim.notify(string.format("📂 Abriendo %d archivos de: %s", total_files, node.name), vim.log.levels.INFO)
          else
            vim.notify("⚠️  Selecciona una carpeta para usar esta función", vim.log.levels.WARN)
          end
        end,
      },
    },
  },
}

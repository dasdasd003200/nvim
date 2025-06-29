return {
  -- File content gatherer plugin configuration for Node.js and Python projects
  {
    "nvim-lua/plenary.nvim", -- Dependency for executing the script
    lazy = false,
    config = function()
      -- Function to detect project type
      local function detect_project_type(directory)
        local Path = require("plenary.path")

        -- Check for Node.js indicators
        local package_json = Path:new(directory, "package.json")
        local node_modules = Path:new(directory, "node_modules")
        local yarn_lock = Path:new(directory, "yarn.lock")
        local package_lock = Path:new(directory, "package-lock.json")

        if package_json:exists() or node_modules:exists() or yarn_lock:exists() or package_lock:exists() then
          return "node"
        end

        -- Check for Python indicators
        local requirements_txt = Path:new(directory, "requirements.txt")
        local setup_py = Path:new(directory, "setup.py")
        local pyproject_toml = Path:new(directory, "pyproject.toml")
        local venv = Path:new(directory, "venv")
        local pipfile = Path:new(directory, "Pipfile")

        if
          requirements_txt:exists()
          or setup_py:exists()
          or pyproject_toml:exists()
          or venv:exists()
          or pipfile:exists()
        then
          return "python"
        end

        -- Default to mixed if can't determine
        return "mixed"
      end

      -- Generate script content based on project type
      local function generate_script_content(project_type)
        local base_script = "#!/usr/bin/env bash\n"
          .. 'echo "Gathering '
          .. project_type
          .. ' project files..."\n'
          .. "# Output file\n"
          .. 'output_file="file_contents_output.txt"\n'
          .. "# Ensure the output file is empty at the start\n"
          .. 'echo "" > "$output_file"\n'

        local ignore_list = ""
        local extensions = ""
        local find_logic = ""

        if project_type == "node" then
          ignore_list = "ignore_list=(\n"
            .. '    "node_modules"\n'
            .. '    "dist"\n'
            .. '    "build"\n'
            .. '    ".git"\n'
            .. '    "coverage"\n'
            .. '    "logs"\n'
            .. '    ".next"\n'
            .. '    ".nuxt"\n'
            .. '    "tree1.sh"\n'
            .. '    "file_contents_output.txt"\n'
            .. '    "README.md"\n'
            .. '    ".gitignore"\n'
            .. '    ".angular"\n'
            .. '    "package-lock.json"\n' -- AGREGADO: Omitir package-lock
            .. '    "yarn.lock"\n' -- AGREGADO: Omitir yarn.lock
            .. '    "pnpm-lock.yaml"\n' -- AGREGADO: Omitir pnpm-lock
            .. '    ".vscode"\n' -- AGREGADO: Omitir configuración VS Code
            .. '    ".idea"\n' -- AGREGADO: Omitir configuración IntelliJ
            .. ")\n"

          extensions = "process_extensions=(\n"
            .. '    "ts" "tsx" "js" "jsx" "json"\n'
            .. '    "html" "css" "scss" "less" "sass"\n'
            .. '    "md" "txt" "yaml" "yml"\n'
            .. '    "vue" "svelte" "astro"\n'
            .. ")\n"

          find_logic = "find . -type f | sort | while read -r file; do\n"
            .. "    # Skip if in ignored directories\n"
            .. '    if [[ "$file" == *"/node_modules/"* || \n'
            .. '          "$file" == *"/.git/"* || \n'
            .. '          "$file" == *"/dist/"* || \n'
            .. '          "$file" == *"/build/"* || \n'
            .. '          "$file" == *"/coverage/"* || \n'
            .. '          "$file" == *"/.next/"* || \n'
            .. '          "$file" == *"/.vscode/"* || \n'
            .. '          "$file" == *"/.idea/"* ]]; then\n'
            .. "        continue\n"
            .. "    fi\n"
        elseif project_type == "python" then
          ignore_list = "ignore_list=(\n"
            .. '    "__pycache__"\n'
            .. '    "_pycache_"\n'
            .. '    "venv"\n'
            .. '    ".venv"\n'
            .. '    "env"\n'
            .. '    ".git"\n'
            .. '    "tree1.sh"\n'
            .. '    "file_contents_output.txt"\n'
            .. '    "README.md"\n'
            .. '    "infoGoogleLogin.md"\n'
            .. '    "uploads"\n'
            .. '    "Keys"\n'
            .. '    ".gitignore"\n'
            .. '    "Jenkinsfile"\n'
            .. '    "Dockerfile"\n'
            .. '    "commit_history.md"\n'
            .. '    ".vscode"\n' -- AGREGADO: Omitir configuración VS Code
            .. '    ".idea"\n' -- AGREGADO: Omitir configuración IntelliJ
            .. '    "migrations"\n' -- AGREGADO: Omitir migraciones de Django
            .. '    "staticfiles"\n' -- AGREGADO: Omitir archivos estáticos recolectados
            .. '    "media"\n' -- AGREGADO: Omitir archivos de media
            .. ")\n"

          extensions = "process_extensions=(\n"
            .. '    "py" "pyx" "pyi"\n'
            .. '    "txt" "md" "json" "yaml" "yml"\n'
            .. '    "sh" "sql" "html" "css" "js"\n'
            .. '    "toml" "cfg" "ini" "env"\n'
            .. '    "graphql" "lock"\n'
            .. ")\n"

          find_logic = "# Enable globbing options for Python\n"
            .. "shopt -s dotglob nullglob globstar\n"
            .. "for file in **; do\n"
            .. "    # Skip if matches pycache pattern or migrations\n"
            .. '    if [[ "$file" == *"__pycache__"* || "$file" == *"_pycache_"* || \n'
            .. '          "$file" == *"/migrations/"* || "$file" == *"/staticfiles/"* || \n'
            .. '          "$file" == *"/media/"* ]]; then\n'
            .. "        continue\n"
            .. "    fi\n"
        else -- mixed project
          ignore_list = "ignore_list=(\n"
            .. '    "node_modules"\n'
            .. '    "dist"\n'
            .. '    "build"\n'
            .. '    "__pycache__"\n'
            .. '    "_pycache_"\n'
            .. '    "venv"\n'
            .. '    ".venv"\n'
            .. '    ".git"\n'
            .. '    "coverage"\n'
            .. '    "tree1.sh"\n'
            .. '    "file_contents_output.txt"\n'
            .. '    "README.md"\n'
            .. '    ".gitignore"\n'
            .. '    "package-lock.json"\n' -- AGREGADO: Omitir package-lock
            .. '    "yarn.lock"\n' -- AGREGADO: Omitir yarn.lock
            .. '    "pnpm-lock.yaml"\n' -- AGREGADO: Omitir pnpm-lock
            .. '    ".vscode"\n' -- AGREGADO: Omitir configuración VS Code
            .. '    ".idea"\n' -- AGREGADO: Omitir configuración IntelliJ
            .. '    "migrations"\n' -- AGREGADO: Omitir migraciones
            .. ")\n"

          extensions = "process_extensions=(\n"
            .. '    "ts" "tsx" "js" "jsx" "json"\n'
            .. '    "py" "pyx" "pyi"\n'
            .. '    "html" "css" "scss" "less"\n'
            .. '    "md" "txt" "yaml" "yml"\n'
            .. '    "sh" "sql" "toml" "cfg"\n'
            .. ")\n"

          find_logic = "find . -type f | sort | while read -r file; do\n"
            .. "    # Skip if in ignored directories\n"
            .. '    if [[ "$file" == *"/node_modules/"* || \n'
            .. '          "$file" == *"/.git/"* || \n'
            .. '          "$file" == *"/__pycache__/"* || \n'
            .. '          "$file" == *"/_pycache_/"* || \n'
            .. '          "$file" == *"/venv/"* || \n'
            .. '          "$file" == *"/dist/"* || \n'
            .. '          "$file" == *"/migrations/"* ]]; then\n'
            .. "        continue\n"
            .. "    fi\n"
        end

        -- Common functions
        local common_functions = "# Función para verificar si una ruta debe ser ignorada\n"
          .. "should_ignore() {\n"
          .. '    local path="$1"\n'
          .. '    for ignore in "${ignore_list[@]}"; do\n'
          .. '        if [[ "$path" == "$ignore" || "$path" == *"/$ignore"* || "$path" == *"$ignore/"* ]]; then\n'
          .. "            return 0\n"
          .. "        fi\n"
          .. "    done\n"
          .. "    return 1\n"
          .. "}\n"
          .. "# Función para verificar si una extensión está en la lista de procesables\n"
          .. "is_processable_extension() {\n"
          .. '    local file="$1"\n'
          .. '    for ext in "${process_extensions[@]}"; do\n'
          .. '        if [[ "$file" == *."$ext" ]]; then\n'
          .. "            return 0\n"
          .. "        fi\n"
          .. "    done\n"
          .. "    return 1\n"
          .. "}\n"

        -- Processing logic
        local processing_logic = ""
        if project_type == "python" then
          processing_logic = "    # Solo procesa archivos, no directorios\n"
            .. '    if [[ -f "$file" ]]; then\n'
            .. "        # Convierte la ruta del archivo a relativa\n"
            .. '        relative_path="${file#./}"\n'
            .. '        if [[ "$relative_path" == "$file" ]]; then\n'
            .. '            relative_path="$file"\n'
            .. "        fi\n"
            .. "        # Verifica si el archivo debe ser ignorado\n"
            .. '        if should_ignore "$relative_path"; then\n'
            .. "            continue\n"
            .. "        fi\n"
            .. "        # Verifica si es un archivo procesable y no es .pyc\n"
            .. '        if is_processable_extension "$file" && [[ "$file" != *.pyc ]]; then\n'
            .. "            # Añade el nombre del archivo\n"
            .. '            printf "==> %s <==\\n" "$relative_path" >> "$output_file"\n'
            .. "            # Muestra el contenido del archivo\n"
            .. '            cat --show-nonprinting -- "$file" >> "$output_file" 2>/dev/null || cat "$file" >> "$output_file"\n'
            .. "            # Añade separador\n"
            .. '            echo >> "$output_file"\n'
            .. "            file_count=$((file_count+1))\n"
            .. "        fi\n"
            .. "    fi\n"
        else
          processing_logic = "    # Convierte la ruta del archivo a relativa\n"
            .. '    relative_path="${file#./}"\n'
            .. "    # Verifica si el archivo debe ser ignorado\n"
            .. '    if should_ignore "$relative_path"; then\n'
            .. "        continue\n"
            .. "    fi\n"
            .. "    # Verifica si es un archivo procesable\n"
            .. '    if [[ -f "$file" ]] && is_processable_extension "$file"; then\n'
            .. "        # Añade el nombre del archivo\n"
            .. '        echo "==> $relative_path <==" >> "$output_file"\n'
            .. "        # Muestra el contenido del archivo\n"
            .. '        cat "$file" >> "$output_file"\n'
            .. "        # Añade separador\n"
            .. '        echo -e "\\n---\\n" >> "$output_file"\n'
            .. "        file_count=$((file_count+1))\n"
            .. "    fi\n"
        end

        -- Complete script
        return base_script
          .. ignore_list
          .. extensions
          .. common_functions
          .. "file_count=0\n"
          .. find_logic
          .. processing_logic
          .. "done\n"
          .. 'echo "✅ Processed $file_count files. Output saved to $output_file"\n'
      end

      -- Main function to gather file contents
      _G.gather_file_contents_smart = function()
        local Job = require("plenary.job")
        local Path = require("plenary.path")
        local current_file = vim.fn.expand("%:p")
        local current_dir = vim.fn.fnamemodify(current_file, ":h")

        -- Detect project type
        local project_type = detect_project_type(current_dir)

        -- Store the original working directory before changing it
        local original_dir = vim.fn.getcwd()

        -- Notify user about project type and script start (UN SOLO MENSAJE)
        vim.notify(string.format("🚀 Gathering %s project files...", project_type:upper()), vim.log.levels.INFO)

        -- Change to the current file's directory
        vim.fn.chdir(current_dir)

        -- Generate script content based on project type
        local script_content = generate_script_content(project_type)

        -- Create a temporary script file
        local script_path = Path:new(vim.fn.tempname() .. ".sh")
        script_path:write(script_content, "w")
        vim.fn.system("chmod +x " .. script_path.filename)

        -- Run the script and capture stdout
        Job:new({
          command = script_path.filename,
          cwd = current_dir,
          on_stdout = function(_, data)
            -- Solo mostrar el mensaje final, no todos los "Processing:"
            if string.match(data, "✅ Processed") then
              print(data)
            end
          end,
          on_exit = function(j, return_val)
            -- Return to the original directory no matter what
            vim.schedule(function()
              vim.cmd("cd " .. vim.fn.fnameescape(original_dir))
            end)

            if return_val == 0 then
              -- Check if the output file exists and is not empty
              local output_file = current_dir .. "/file_contents_output.txt"
              local f = io.open(output_file, "r")
              if f then
                local content = f:read("*all")
                f:close()
                if content and #content > 0 then
                  vim.notify(
                    string.format("✅ Files gathered successfully (%s project)", project_type:upper()),
                    vim.log.levels.INFO
                  )
                else
                  vim.notify("⚠️  No files found matching criteria", vim.log.levels.WARN)
                end
              else
                vim.notify("❌ Could not create output file", vim.log.levels.ERROR)
              end
              -- Clean up temporary script
              script_path:rm()
            else
              vim.notify("❌ Error gathering files", vim.log.levels.ERROR)
            end
          end,
        }):start()
      end

      -- Legacy function for backward compatibility
      _G.gather_file_contents_for_node = _G.gather_file_contents_smart
    end,
  },
}

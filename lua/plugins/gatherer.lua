return {
  -- File content gatherer plugin - Universal version based on working code
  {
    "nvim-lua/plenary.nvim", -- Dependency for executing the script
    lazy = false,
    config = function()
      -- Generate universal script content (basado en el código que funcionaba)
      local function generate_universal_script()
        local base_script = "#!/usr/bin/env bash\n"
          .. 'echo "Gathering UNIVERSAL project files..."\n'
          .. "# Output file\n"
          .. 'output_file="file_contents_output.txt"\n'
          .. "# Ensure the output file is empty at the start\n"
          .. 'echo "" > "$output_file"\n'

        -- CONFIGURACIÓN UNIVERSAL - Modifica aquí lo que quieras
        local ignore_list = "ignore_list=(\n"
          .. '    "node_modules"\n'
          .. '    "dist"\n'
          .. '    "build"\n'
          .. '    ".git"\n'
          .. '    "coverage"\n'
          .. '    "logs"\n'
          .. '    ".next"\n'
          .. '    ".nuxt"\n'
          .. '    ".angular"\n'
          .. '    "__pycache__"\n'
          .. '    "_pycache_"\n'
          .. '    "venv"\n'
          .. '    ".venv"\n'
          .. '    "env"\n'
          .. '    ".env"\n'
          .. '    "vendor"\n'
          .. '    "target"\n'
          .. '    "bin"\n'
          .. '    "obj"\n'
          .. '    "migrations"\n'
          .. '    "staticfiles"\n'
          .. '    "media"\n'
          .. '    ".vscode"\n'
          .. '    ".idea"\n'
          .. '    ".gradle"\n'
          .. '    "packages"\n'
          .. '    "bootstrap"\n'
          .. '    "storage"\n'
          .. '    "tmp"\n'
          .. '    "uploads"\n'
          .. '    "Keys"\n'
          .. '    "tree1.sh"\n'
          .. '    "file_contents_output.txt"\n'
          .. '    "README.md"\n'
          .. '    ".gitignore"\n'
          .. '    "package-lock.json"\n'
          .. '    "yarn.lock"\n'
          .. '    "pnpm-lock.yaml"\n'
          .. '    "go.sum"\n'
          .. '    "Cargo.lock"\n'
          .. '    "composer.lock"\n'
          .. '    "infoGoogleLogin.md"\n'
          .. '    "Jenkinsfile"\n'
          .. '    "Dockerfile"\n'
          .. '    "commit_history.md"\n'
          .. ")\n"

        local extensions = "process_extensions=(\n"
          .. '    "go" "mod" "sum"\n'
          .. '    "py" "pyx" "pyi"\n'
          .. '    "ts" "tsx" "js" "jsx" "json"\n'
          .. '    "java" "c" "cpp" "cs" "php" "rb" "rs" "kt"\n'
          .. '    "html" "css" "scss" "less" "sass"\n'
          .. '    "vue" "svelte" "astro"\n'
          .. '    "md" "txt" "yaml" "yml" "toml" "cfg" "ini" "env"\n'
          .. '    "sh" "bash" "zsh" "fish" "ps1" "bat" "sql"\n'
          .. '    "graphql" "lock"\n'
          .. ")\n"

        local find_logic = "find . -type f | sort | while read -r file; do\n"
          .. "    # Skip if in ignored directories\n"
          .. '    if [[ "$file" == *"/node_modules/"* || \n'
          .. '          "$file" == *"/.git/"* || \n'
          .. '          "$file" == *"/dist/"* || \n'
          .. '          "$file" == *"/build/"* || \n'
          .. '          "$file" == *"/coverage/"* || \n'
          .. '          "$file" == *"/.next/"* || \n'
          .. '          "$file" == *"/.vscode/"* || \n'
          .. '          "$file" == *"/.idea/"* || \n'
          .. '          "$file" == *"/__pycache__/"* || \n'
          .. '          "$file" == *"/_pycache_/"* || \n'
          .. '          "$file" == *"/venv/"* || \n'
          .. '          "$file" == *"/.venv/"* || \n'
          .. '          "$file" == *"/vendor/"* || \n'
          .. '          "$file" == *"/target/"* || \n'
          .. '          "$file" == *"/migrations/"* ]]; then\n'
          .. "        continue\n"
          .. "    fi\n"

        local common_functions = "# Funcion para verificar si una ruta debe ser ignorada\n"
          .. "should_ignore() {\n"
          .. '    local path="$1"\n'
          .. '    for ignore in "${ignore_list[@]}"; do\n'
          .. '        if [[ "$path" == "$ignore" || "$path" == *"/$ignore"* || "$path" == *"$ignore/"* ]]; then\n'
          .. "            return 0\n"
          .. "        fi\n"
          .. "    done\n"
          .. "    return 1\n"
          .. "}\n"
          .. "# Funcion para verificar si una extension esta en la lista de procesables\n"
          .. "is_processable_extension() {\n"
          .. '    local file="$1"\n'
          .. '    for ext in "${process_extensions[@]}"; do\n'
          .. '        if [[ "$file" == *."$ext" ]]; then\n'
          .. "            return 0\n"
          .. "        fi\n"
          .. "    done\n"
          .. "    return 1\n"
          .. "}\n"

        local processing_logic = "    # Convierte la ruta del archivo a relativa\n"
          .. '    relative_path="${file#./}"\n'
          .. "    # Verifica si el archivo debe ser ignorado\n"
          .. '    if should_ignore "$relative_path"; then\n'
          .. "        continue\n"
          .. "    fi\n"
          .. "    # Verifica si es un archivo procesable\n"
          .. '    if [[ -f "$file" ]] && is_processable_extension "$file"; then\n'
          .. "        # Anade el nombre del archivo\n"
          .. '        echo "==> $relative_path <==" >> "$output_file"\n'
          .. "        # Muestra el contenido del archivo\n"
          .. '        cat "$file" >> "$output_file" 2>/dev/null\n'
          .. "        # Anade separador\n"
          .. '        echo -e "\\n---\\n" >> "$output_file"\n'
          .. "        file_count=$((file_count+1))\n"
          .. "    fi\n"

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

      -- Main function to gather file contents - MANTIENE EL MISMO NOMBRE
      _G.gather_file_contents_smart = function()
        local Job = require("plenary.job")
        local Path = require("plenary.path")
        local current_file = vim.fn.expand("%:p")
        local current_dir = vim.fn.fnamemodify(current_file, ":h")

        -- Store the original working directory before changing it
        local original_dir = vim.fn.getcwd()

        -- Notify user (UN SOLO MENSAJE)
        vim.notify("🚀 Gathering UNIVERSAL project files...", vim.log.levels.INFO)

        -- Change to the current file's directory
        vim.fn.chdir(current_dir)

        -- Generate universal script content
        local script_content = generate_universal_script()

        -- Create a temporary script file
        local script_path = Path:new(vim.fn.tempname() .. ".sh")
        script_path:write(script_content, "w")
        vim.fn.system("chmod +x " .. script_path.filename)

        -- Run the script and capture stdout
        Job:new({
          command = script_path.filename,
          cwd = current_dir,
          on_stdout = function(_, data)
            -- Solo mostrar el mensaje final
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
                  vim.notify("✅ Files gathered successfully (UNIVERSAL)", vim.log.levels.INFO)
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

      -- Legacy functions for backward compatibility
      _G.gather_file_contents_for_node = _G.gather_file_contents_smart
      _G.gather_file_contents_universal = _G.gather_file_contents_smart
    end,
  },
}

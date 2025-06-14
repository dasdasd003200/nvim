-- gatherer.lua
-- This file can be placed in ~/.config/nvim/lua/plugins/ for AstroNvim

return {
  -- File content gatherer plugin configuration
  {
    "nvim-lua/plenary.nvim", -- Dependency for executing the script
    lazy = false,
    config = function()
      -- Store script as a string with explicit newlines and proper escaping
      local script_content = "#!/usr/bin/env bash\n"
        .. 'echo "Starting file content gathering..."\n'
        .. "# Output file\n"
        .. 'output_file="file_contents_output.txt"\n'
        .. "# Ensure the output file is empty at the start\n"
        .. 'echo "" > "$output_file"\n'
        .. 'echo "Created empty output file: $output_file"\n'
        .. "ignore_list=(\n"
        .. '    "node_modules"\n'
        .. '    "dist"\n'
        .. '    ".git"\n'
        .. '    "pycache"\n'
        .. '    "_pycache_"\n'
        .. '    "tree1.sh"\n'
        .. '    "venv"\n'
        .. '    "file_contents_output.txt"\n'
        .. '    "README.md"\n'
        .. '    ".gitignore"\n'
        .. '    ".angular"\n'
        .. '    "coverage"\n'
        .. '    "build"\n'
        .. '    "logs"\n'
        .. ")\n"
        .. "# Función para verificar si una ruta debe ser ignorada\n"
        .. "should_ignore() {\n"
        .. '    local path="$1"\n'
        .. '    for ignore in "${ignore_list[@]}"; do\n'
        .. '        if [[ "$path" == "$ignore" || "$path" == *"/$ignore"* || "$path" == *"$ignore/"* ]]; then\n'
        .. "            return 0\n"
        .. "        fi\n"
        .. "    done\n"
        .. "    return 1\n"
        .. "}\n"
        .. "# Extensiones de archivos a procesar\n"
        .. "process_extensions=(\n"
        .. '    "ts" "tsx" "js" "jsx" "json"\n'
        .. '    "html" "css" "scss" "less"\n'
        .. '    "md" "txt" "yaml" "yml"\n'
        .. '    "py" "sh" "env" ".env"\n'
        .. ")\n"
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
        .. 'echo "Scanning for files..."\n'
        .. "file_count=0\n"
        .. "find . -type f | sort | while read -r file; do\n"
        .. "    # Skip if in ignored directories\n"
        .. '    if [[ "$file" == *"/node_modules/"* || \n'
        .. '          "$file" == *"/.git/"* || \n'
        .. '          "$file" == *"/pycache/"* || \n'
        .. '          "$file" == *"/_pycache_/"* || \n'
        .. '          "$file" == *"/dist/"* || \n'
        .. '          "$file" == *"/venv/"* ]]; then\n'
        .. "        continue\n"
        .. "    fi\n"
        .. "    # Convierte la ruta del archivo a relativa\n"
        .. '    relative_path="${file#./}"\n'
        .. "    # Verifica si el archivo debe ser ignorado\n"
        .. '    if should_ignore "$relative_path"; then\n'
        .. "        continue\n"
        .. "    fi\n"
        .. "    # Verifica si es un archivo procesable\n"
        .. '    if [[ -f "$file" ]] && is_processable_extension "$file"; then\n'
        .. '        echo "Processing: $relative_path"\n'
        .. "        # Añade el nombre del archivo\n"
        .. '        echo "==> $relative_path <==" >> "$output_file"\n'
        .. "        \n"
        .. "        # Muestra el contenido del archivo\n"
        .. '        cat "$file" >> "$output_file"\n'
        .. "        \n"
        .. "        # Añade separador\n"
        .. '        echo -e "\n---\n" >> "$output_file"\n'
        .. "        \n"
        .. "        file_count=$((file_count+1))\n"
        .. "    fi\n"
        .. "done\n"
        .. 'echo "Script execution complete. Processed $file_count files. Output has been written to $output_file"\n'

      -- Function to get the current file's directory and execute the script
      _G.gather_file_contents_for_node = function()
        local Job = require("plenary.job")
        local Path = require("plenary.path")
        local current_file = vim.fn.expand("%:p")
        local current_dir = vim.fn.fnamemodify(current_file, ":h")

        -- Store the original working directory before changing it
        local original_dir = vim.fn.getcwd()

        -- Notify user that script is starting
        vim.notify("Starting file content gathering in: " .. current_dir, vim.log.levels.INFO)

        -- Change to the current file's directory
        vim.fn.chdir(current_dir)

        -- Create a temporary script file
        local script_path = Path:new(vim.fn.tempname() .. ".sh")
        script_path:write(script_content, "w")
        vim.fn.system("chmod +x " .. script_path.filename)

        -- Run the script and capture stdout
        Job:new({
          command = script_path.filename,
          cwd = current_dir,
          on_stdout = function(_, data)
            -- Print script output to help with debugging
            print(data)
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
                    "File contents gathered successfully to file_contents_output.txt in " .. current_dir,
                    vim.log.levels.INFO
                  )
                else
                  vim.notify(
                    "Warning: Output file is empty. No files may have matched your criteria.",
                    vim.log.levels.WARN
                  )
                end
              else
                vim.notify("Error: Could not open output file to verify contents.", vim.log.levels.ERROR)
              end
              -- Clean up temporary script
              script_path:rm()
            else
              vim.notify("Error running file contents gatherer script. Exit code: " .. return_val, vim.log.levels.ERROR)
            end
          end,
        }):start()
      end

      -- Create the function mapping directly
      -- vim.api.nvim_set_keymap(
      --   "n",
      --   "<leader>r",
      --   "<cmd>lua _G.gather_file_contents()<CR>",
      --   { noremap = true, silent = true, desc = "Gather file contents" }
      -- )
    end,
  },
}

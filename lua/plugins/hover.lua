-- lua/plugins/hover.lua
return {
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup({
        init = function()
          -- Solo lo básico que necesitamos
          require("hover.providers.lsp")
        end,
        preview_opts = {
          border = "rounded",
        },
        preview_window = false,
        title = true,
        mouse_providers = {
          "LSP",
        },
        mouse_delay = 1000,
      })

      -- Solo 2 keymaps:

      -- 1. Para ver la DEFINICIÓN REAL del tipo en ventana: <leader>rk
      vim.keymap.set("n", "<leader>rk", function()
        -- Obtener la posición actual
        local params = vim.lsp.util.make_position_params()

        -- Buscar la definición del tipo
        vim.lsp.buf_request(0, "textDocument/typeDefinition", params, function(err, result, ctx, config)
          if err or not result or #result == 0 then
            -- Si no hay typeDefinition, intentar con definition
            vim.lsp.buf_request(0, "textDocument/definition", params, function(err2, result2, ctx2, config2)
              if err2 or not result2 or #result2 == 0 then
                vim.notify("No se encontró definición del tipo", vim.log.levels.WARN)
                return
              end
              result = result2
            end)
          end

          if not result or #result == 0 then
            return
          end

          -- Obtener la ubicación de la definición
          local location = result[1]
          if not location.uri then
            vim.notify("No se pudo obtener la ubicación", vim.log.levels.WARN)
            return
          end

          -- Leer el archivo donde está la definición
          local file_path = vim.uri_to_fname(location.uri)
          local file_lines = {}

          -- Leer el archivo
          local file = io.open(file_path, "r")
          if not file then
            vim.notify("No se pudo abrir el archivo", vim.log.levels.ERROR)
            return
          end

          for line in file:lines() do
            table.insert(file_lines, line)
          end
          file:close()

          -- Obtener la línea donde empieza la definición
          local start_line = location.range.start.line + 1

          -- Buscar la definición completa (desde export type hasta la llave que cierra)
          local definition_lines = {}
          local brace_count = 0
          local in_definition = false

          for i = start_line, #file_lines do
            local line = file_lines[i]
            table.insert(definition_lines, line)

            -- Contar llaves para saber dónde termina la definición
            if line:match("export type") or line:match("interface") then
              in_definition = true
            end

            if in_definition then
              -- Contar llaves abiertas y cerradas
              local open_braces = select(2, line:gsub("{", ""))
              local close_braces = select(2, line:gsub("}", ""))
              brace_count = brace_count + open_braces - close_braces

              -- Si las llaves están balanceadas, terminamos
              if brace_count == 0 and line:match("}") then
                break
              end
            end

            -- Límite de seguridad
            if #definition_lines > 50 then
              break
            end
          end

          -- Crear buffer temporal
          local buf = vim.api.nvim_create_buf(false, true)

          -- Agregar título
          local title_lines = { "================================   ", "" }
          for _, line in ipairs(title_lines) do
            table.insert(definition_lines, 1, line)
          end

          vim.api.nvim_buf_set_lines(buf, 0, -1, false, definition_lines)
          vim.api.nvim_buf_set_option(buf, "filetype", "typescript")

          -- Crear ventana flotante
          local width = math.min(100, vim.o.columns - 10)
          local height = math.min(#definition_lines + 2, vim.o.lines - 10)
          local row = math.floor((vim.o.lines - height) / 2)
          local col = math.floor((vim.o.columns - width) / 2)

          local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,
            style = "minimal",
            border = "rounded",
            title = " Type Definition ",
            title_pos = "center",
          })

          -- Cerrar con q o Esc
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf })
          vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf })
        end)
      end, { desc = "Show type definition in popup" })

      -- 2. Para git blame: <leader>rg
      vim.keymap.set("n", "<leader>rg", function()
        local line = vim.fn.line(".")
        local file = vim.fn.expand("%:p")

        if file == "" then
          vim.notify("No hay archivo abierto", vim.log.levels.WARN)
          return
        end

        -- Git blame simple
        local cmd = string.format('git blame -L %d,%d "%s"', line, line, file)
        local result = vim.fn.system(cmd)

        if vim.v.shell_error ~= 0 then
          vim.notify("No es un repo git o error", vim.log.levels.ERROR)
          return
        end

        -- Parsear resultado simple
        local parts = {}
        for part in result:gmatch("%S+") do
          table.insert(parts, part)
        end

        local commit = parts[1] and parts[1]:sub(1, 8) or "Unknown"
        local author = "Unknown"
        local date = "Unknown"

        -- Buscar autor y fecha en el resultado
        if result:find("%(") then
          author = result:match("%(([^%d]+)") or "Unknown"
          author = author:gsub("%s+$", "") -- quitar espacios
          date = result:match("(%d%d%d%d%-%d%d%-%d%d)") or "Unknown"
        end

        -- Mostrar info simple
        local info = {
          "🔍 Git Blame - Línea " .. line,
          "",
          "👤 " .. author,
          "📅 " .. date,
          "🔗 " .. commit,
        }

        vim.notify(table.concat(info, "\n"), vim.log.levels.INFO, { title = "Git Blame" })
      end, { desc = "Git blame línea actual" })

      -- Mouse hover automático
      vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
      vim.o.mousemoveevent = true
    end,
  },
}

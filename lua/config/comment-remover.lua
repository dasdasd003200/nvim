local M = {}

M.comment_patterns = {

  javascript = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  typescript = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  javascriptreact = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  typescriptreact = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  java = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  c = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  cpp = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  csharp = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  php = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  rust = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  go = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },

  css = {
    block_start = "/%*",
    block_end = "%*/",
  },
  scss = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
  less = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },

  html = {
    block_start = "<!%-%-",
    block_end = "%-%->",
  },
  xml = {
    block_start = "<!%-%-",
    block_end = "%-%->",
  },
  vue = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
    html_block_start = "<!%-%-",
    html_block_end = "%-%->",
  },

  python = {
    line = "#",
  },

  bash = {
    line = "#",
  },
  sh = {
    line = "#",
  },
  zsh = {
    line = "#",
  },

  lua = {
    line = "%-%-",
  },

  sql = {
    line = "%-%-",
    block_start = "/%*",
    block_end = "%*/",
  },

  ruby = {
    line = "#",
  },

  yaml = {
    line = "#",
  },
  yml = {
    line = "#",
  },

  toml = {
    line = "#",
  },

  vim = {
    line = '"',
  },

  markdown = {
    block_start = "<!%-%-",
    block_end = "%-%->",
  },

  default = {
    line = "//",
    block_start = "/%*",
    block_end = "%*/",
  },
}

function M.get_comment_pattern(filetype)
  return M.comment_patterns[filetype] or M.comment_patterns.default
end

function M.remove_line_comments(line, comment_char)
  if not comment_char then
    return line
  end

  local comment_pos = line:find(comment_char, 1, true)

  if comment_pos then
    local before_comment = line:sub(1, comment_pos - 1)
    local in_single_quote = false
    local in_double_quote = false

    for i = 1, #before_comment do
      local char = before_comment:sub(i, i)
      if char == "'" and not in_double_quote then
        in_single_quote = not in_single_quote
      elseif char == '"' and not in_single_quote then
        in_double_quote = not in_double_quote
      end
    end

    if not in_single_quote and not in_double_quote then
      local before = line:sub(1, comment_pos - 1):gsub("%s+$", "")
      return before
    end
  end

  return line
end

function M.remove_simple_block_comments(line, start_pattern, end_pattern)
  if not start_pattern or not end_pattern then
    return line
  end

  local result = line
  local modified = true

  while modified do
    modified = false
    local start_pos = result:find(start_pattern, 1, true)
    if start_pos then
      local end_pos = result:find(end_pattern, start_pos + #start_pattern, true)
      if end_pos then
        local before = result:sub(1, start_pos - 1)
        local after = result:sub(end_pos + #end_pattern)
        result = before .. after
        modified = true
      else
        break
      end
    end
  end

  return result
end

function M.remove_all_comments()
  local filetype = vim.bo.filetype
  local pattern = M.get_comment_pattern(filetype)

  -- print("Filetype detectado:", filetype)
  -- print("Patrón de comentario de línea:", pattern.line or "ninguno")

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local modified_lines = {}
  local comments_removed = 0

  for i, line in ipairs(lines) do
    local original_line = line
    local modified_line = line

    if pattern.line then
      local comment_char = pattern.line
      if filetype == "lua" then
        comment_char = "--" -- Usar el string literal en lugar del pattern
      elseif filetype == "python" or filetype == "bash" or filetype == "sh" then
        comment_char = "#"
      elseif pattern.line == "//" then
        comment_char = "//"
      end

      modified_line = M.remove_line_comments(modified_line, comment_char)
    end

    if pattern.block_start and pattern.block_end then
      local start_char = pattern.block_start:gsub("%%", ""):gsub("/", "")
      local end_char = pattern.block_end:gsub("%%", ""):gsub("/", "")

      if filetype == "html" or filetype == "xml" then
        start_char = "<!--"
        end_char = "-->"
      elseif pattern.block_start == "/%*" then
        start_char = "/*"
        end_char = "*/"
      end

      modified_line = M.remove_simple_block_comments(modified_line, start_char, end_char)
    end

    table.insert(modified_lines, modified_line)

    if original_line ~= modified_line then
      comments_removed = comments_removed + 1
      print("Línea", i, ":", original_line, "->", modified_line)
    end
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, modified_lines)

  vim.notify(string.format("Delete comments ", comments_removed, filetype), vim.log.levels.INFO, { title = "Remover" })
end

function M.remove_comments_with_confirmation()
  local filetype = vim.bo.filetype
  local pattern = M.get_comment_pattern(filetype)

  if not pattern.line and not pattern.block_start then
    vim.notify("❌ Tipo de archivo no soportado: " .. filetype, vim.log.levels.WARN)
    return
  end

  vim.ui.select({ "Delete comments ", "Cancel" }, {
    prompt = "¿Do you want to delete comments : " .. filetype .. "?",
  }, function(choice, idx)
    if idx == 1 then
      M.remove_all_comments()
    elseif idx == 2 then
      local supported = {}
      for ft, _ in pairs(M.comment_patterns) do
        table.insert(supported, ft)
      end
      table.sort(supported)
      vim.notify("Tipos soportados:\n" .. table.concat(supported, ", "), vim.log.levels.INFO)
    end
  end)
end

function M.test_remove()
  M.remove_all_comments()
end

return M

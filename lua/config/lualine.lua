require("lualine").setup({
  options = {
    theme = "auto", -- Usar el tema actual
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      "diff",
      "diagnostics",
    },
    lualine_c = { "filename" },
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
      {
        function()
          local current_line = vim.fn.line(".")
          local total_lines = vim.fn.line("$")
          local percent = math.floor((current_line / total_lines) * 100)
          return string.format("%3d", percent) .. "%%"
        end,
        color = { fg = "#ffffff", gui = "bold" },
        padding = { left = 2, right = 2 },
      },
      {
        function()
          local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          if cwd == "zEMVThreeServiceContextV4" then
            return "Back"
          elseif cwd == "zEMVThreeClientStandaloneV6" then
            return "Front"
          else
            return cwd
          end
        end,
        color = function()
          local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          if cwd == "zEMVThreeServiceContextV4" then
            return { fg = "#33c3ff", bg = "#3f3f3f", gui = "bold" }
          elseif cwd == "zEMVThreeClientStandaloneV6" then
            return { fg = "#ff5733", bg = "#3f3f3f", gui = "bold" }
          else
            return { fg = "#ffffff", bg = "#3f3f3f", gui = "bold" }
          end
        end,
        padding = { left = 2, right = 2 },
      },
    },
    lualine_y = {},
    lualine_z = {
      {
        'os.date("%H:%M")',
        color = { fg = "#ffffff", bg = "#000000" },
        icon = "🕒",
        padding = { left = 2, right = 2 },
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})

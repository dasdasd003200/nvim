-- ~/.config/nvim/lua/plugins/dashboard-owl.lua
return {
  -- Desactivar mini.starter de LazyVim
  {
    "echasnovski/mini.starter",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Solo el dashboard
      bigfile = { enabled = false },
      quickfile = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          -- { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },

          { section = "startup" },
        },
        preset = {
          header = [[
 | |             | |             | |  ⠀⠀⠀⠀⣀⡀
   __| | __ _ ___  __| | __ _ ___  __| |  ⢠⣤⡀⣾⣿⣿⠀⣤⣤⡄
  / _` |/ _` / __|/ _` |/ _` / __|/ _` |  ⢿⣿⡇⠘⠛⠁⢸⣿⣿⠃
  | (_| | (_| \__ \ (_| | (_| \__ \ (_| |  ⠈⣉⣤⣾⣿⣿⡆⠉⣴⣶⣶
   \__,_|\__,_|___/\__,_|\__,_|___/\__,_|  ⣾⣿⣿⣿⣿⣿⣿⡀⠻⠟⠃
                                         ⠙⠛⠻⢿⣿⣿⣿⡇
                    ⠀⠀⠀ ⠈⣿⣿⣦                 ⠙⠋
                      ⠀⠀⠀⣀⡘⣿⣿⣷⡰⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⠟⠁
                   ⠀⠀⢻⣿⣿⣌⢿⣿⣷⣭⣤⣤⣤⣤⣄⣀⠀⠀⠀⣠⣶⣿⣿⡿⠃
                 ⠀⠀⢸⣿⣿⣿⢎⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣿⣿⣿⠟⠉
              ⠀⠀⣸⠛⠉⢀⣿⣿⠋⣭⢿⣿⣿⣿⡿⠻⣿⣿⡿⠋
             ⢰⣿⣿⣶⡆⠻⠿⣿⣦⣤⣾⡿⣿⣧⠛⢀⣿⣿⡇
                 ⠀⠻⣿⣿⣿⠀⢀⣿⣿⣿⠟⠛⢿⣿⣿⣿⣿⣿⡇⣠⣤⣤⣤
                 ⠀⠀⠈⠻⣿⣦⡻⣿⣿⣿⡇⠀⣰⣿⣿⣿⡏⠀⢀⣿⣿⣿⠟
                ⠀⠀⠀⠀⣿⣿⣿⣮⣛⠿⠷⣾⣿⣿⡿⠿⣣⣴⡿⠟⠋⠀
            ⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣿⣿⡟
           ⠀⠀⠀⢼⡿⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠏
           ⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠛⠛⠋⠉⠺⠷
          ]],
          keys = {
            { icon = "📁", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            -- { icon = "📄", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = "🔍", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "📝", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "💾", key = "s", desc = "Restore Session", section = "session" },
            -- { icon = "⚙️", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "❌", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}

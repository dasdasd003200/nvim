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
            { icon = "💾", key = "s", desc = "Restore Session", section = "session" },
          },
        },
      },
    },
  },
}

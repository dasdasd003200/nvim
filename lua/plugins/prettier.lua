-- -- lua/plugins/prettier.lua
-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         -- Configurar prettier como servidor LSP
--         prettierd = {},
--       },
--     },
--   },
--   {
--     "jose-elias-alvarez/null-ls.nvim",
--     opts = function()
--       return {
--         sources = {
--           require("null-ls").builtins.formatting.prettier,
--         },
--       }
--     end,
--   },
-- }


-- lua/plugins/prettier.lua
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },
}

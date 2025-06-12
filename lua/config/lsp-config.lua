local lspconfig = require("lspconfig")

lspconfig.vtsls.setup({
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "none",
      },
    },
  },
})

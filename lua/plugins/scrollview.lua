return {
  {
    "dstein64/nvim-scrollview",
    excluded_filetypes = { "nerdtree" },
    current_only = true,
    base = "buffer",
    column = 80,
    signs_on_startup = { "all" },
    diagnostics_severities = { vim.diagnostic.severity.ERROR },
  },
}

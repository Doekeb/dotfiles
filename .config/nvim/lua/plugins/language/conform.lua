return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = { lua = { "stylua" }, python = { "isort", "black" } },
    format_on_save = { lsp_fallback = true, timeout_ms = 500 },
  },
}
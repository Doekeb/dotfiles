return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "biome" },
      javascriptreact = { "biome" },
      json = { "biome" },
      lua = { "stylua" },
      python = { "isort", "black" },
      sql = { "sql_formatter" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
    },
    format_on_save = { lsp_fallback = true },
  },
}

return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    -- conform.formatters.sqlfluff = { args = { "fix", "-" }, exit_codes = { 0, 1 } }
    conform.formatters.sqlfluff = { args = { "format", "-" }, exit_codes = { 0, 1 } }
    conform.setup({
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        javascript = { "biome" },
        javascriptreact = { "biome" },
        json = { "biome" },
        lua = { "stylua" },
        sql = { "sqlfluff" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        ["*"] = { "injected" },
      },
      format_on_save = { lsp_format = "first", timeout_ms = 2000 },
    })
  end,
}

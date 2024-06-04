return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.formatters.sql_formatter = {
      prepend_args = {
        "-c",
        '{"language": "postgresql", "dialect": "postgresql", "tabWidth": 2, "useTabs": false, "keywordCase": "lower", "dataTypeCase": "lower", "functionCase": "lower", "logicalOperatorNewline": "before", "linesBetweenQueries": 1, "denseOperators": false, "newlineBeforeSemicolon": false}',
      },
    }
    conform.setup({
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
    })
  end,
}

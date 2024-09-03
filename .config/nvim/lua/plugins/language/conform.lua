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
        python = { "isort", "black" },
        sql = { "sqlfluff" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
      },
      format_on_save = { lsp_fallback = true, timeout_ms = 2000 },
    })
    local map = require("utils").set_global_keymap
    map("n", "<leader>gf", function()
      conform.format({ lsp_fallback = true })
    end, "[g]o [f]ormat")
  end,
}

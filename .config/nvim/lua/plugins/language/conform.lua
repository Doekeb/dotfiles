return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.setup({
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
      format_on_save = { lsp_fallback = true },
    })
    local map = require("utils").set_global_keymap
    map("n", "<leader>gf", function()
      conform.format({ lsp_fallback = true })
    end, "[g]o [f]ormat")
  end,
}

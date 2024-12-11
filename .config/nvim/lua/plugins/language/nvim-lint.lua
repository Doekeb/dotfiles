return {
  "mfussenegger/nvim-lint",
  dependencies = { "linux-cultist/venv-selector.nvim" },
  config = function()
    local lint = require("lint")

    lint.linters.mypy.args = vim.tbl_filter(function(x)
      return x ~= "--hide-error-codes"
    end, lint.linters.mypy.args)

    lint.linters.sqlfluff.args = {
      "lint",
      "--format=json",
      -- note: users will have to replace the --dialect argument accordingly
      -- "--dialect=postgres",
    }
    lint.python_linters = {}

    lint.linters_by_ft = {
      python = lint.python_linters,
      sql = { "sqlfluff" },
    }
    vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        lint.try_lint()

        -- You can call `try_lint` with a linter name or a list of names to always
        -- run specific linters, independent of the `linters_by_ft` configuration
        -- require("lint").try_lint("cspell")
      end,
    })
  end,
}

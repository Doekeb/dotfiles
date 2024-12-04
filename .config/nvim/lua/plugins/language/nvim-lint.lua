---@param venv_path string
---@param cmd string
---@return string | nil
local venv_tool_path = function(venv_path, cmd)
  local venv_cmd = venv_path .. "/bin/" .. cmd
  if os.rename(venv_cmd, venv_cmd) then
    return venv_cmd
  end
end

return {
  "mfussenegger/nvim-lint",
  dependencies = { "linux-cultist/venv-selector.nvim" },
  config = function()
    local lint = require("lint")

    ---@param linter lint.Linter | fun():lint.Linter
    ---@return fun():lint.Linter
    local venv_linter = function(linter)
      return function()
        local linter_config = vim.deepcopy(type(linter) == "table" and linter or linter())
        local active_venv = require("venv-selector").venv()
        local cmd = active_venv and venv_tool_path(active_venv, linter.cmd) or nil

        if cmd then
          linter_config.cmd = cmd
          linter_config.parser = function(...)
            local ds = linter.parser(...)
            for _, d in pairs(ds) do
              d.source = d.source .. " (venv)"
            end
            return ds
          end
        end
        return linter_config
      end
    end

    lint.linters.mypy.args = vim.tbl_filter(function(x)
      return x ~= "--hide-error-codes"
    end, lint.linters.mypy.args)

    lint.linters.venv_pylint = venv_linter(lint.linters.pylint)
    lint.linters.venv_mypy = venv_linter(lint.linters.mypy)
    lint.linters.venv_flake8 = venv_linter(lint.linters.flake8)
    lint.linters.sqlfluff.args = {
      "lint",
      "--format=json",
      -- note: users will have to replace the --dialect argument accordingly
      -- "--dialect=postgres",
    }

    lint.linters_by_ft = {
      python = { "venv_pylint", "venv_mypy", "venv_flake8" },
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

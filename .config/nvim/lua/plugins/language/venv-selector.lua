---@param venv_path string
---@param cmd string
---@return string | nil
local venv_tool_path = function(venv_path, cmd)
  local venv_cmd = venv_path .. "/bin/" .. cmd
  if os.rename(venv_cmd, venv_cmd) then
    return venv_cmd
  end
end

---@param linter lint.Linter | fun():lint.Linter
---@param active_venv string
---@return lint.Linter
local venv_linter = function(linter, active_venv)
  local linter_config = vim.deepcopy(type(linter) == "table" and linter or linter())
  local cmd = venv_tool_path(active_venv, linter.cmd)

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

return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-lint",
    "stevearc/conform.nvim",
    "folke/snacks.nvim",
  },
  lazy = false,
  config = function()
    local lint = require("lint")
    local conform = require("conform")
    local venv_selector = require("venv-selector")
    venv_selector.venv_tool_path = venv_tool_path

    local on_venv_activate = function()
      local active_venv = venv_selector.venv()

      lint.linters.venv_pylint = venv_linter(lint.linters.pylint, active_venv)
      lint.linters.venv_mypy = venv_linter(lint.linters.mypy, active_venv)
      lint.linters.venv_flake8 = venv_linter(lint.linters.flake8, active_venv)

      local python_linters = {}
      for base_name, base_linter in pairs({
        pylint = lint.linters.pylint,
        mypy = lint.linters.mypy,
        flake8 = lint.linters.flake8,
      }) do
        local cmd = venv_tool_path(active_venv, base_linter.cmd)
        if cmd then
          vim.list_extend(python_linters, { "venv_" .. base_name })
        elseif vim.list_contains(lint.python_linters, base_name) then
          vim.list_extend(python_linters, { base_name })
        end
      end

      lint.linters_by_ft.python = python_linters
      lint.try_lint()

      local python_formatters = {}
      for _, base_name in ipairs({ "isort", "black" }) do
        local venv_formatter = venv_tool_path(active_venv, base_name)
        if venv_formatter then
          conform.formatters[base_name] = { command = venv_formatter }
          vim.list_extend(python_formatters, { base_name })
        end
      end
      if #python_formatters > 0 then
        conform.formatters_by_ft.python = python_formatters
      end
    end

    venv_selector.setup({
      settings = {
        options = {
          on_venv_activate_callback = on_venv_activate,
          picker_options = { snacks = { layout = { preset = "select_r" } } },
          picker = "snacks",
        },
      },
    })
  end,
  keys = { { "<leader>fv", "<cmd>VenvSelect<cr>" } },
}

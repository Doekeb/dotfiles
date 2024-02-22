local null_ls_python_virtualenv_tool_config = function(tool_name)
  local virtual_env = os.getenv("VIRTUAL_ENV")
  return {
    command = virtual_env and virtual_env .. "/bin/" .. tool_name,
    cwd = function()
      vim.fn.getcwd()
    end,
  }
end

return {
  {
    "jay-babu/mason-null-ls.nvim",
    --    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "stylua",
        "mypy",
        "black",
        "isort",
        "flake8",
        "pylint",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = true,
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.mypy.with(null_ls_python_virtualenv_tool_config("mypy")),
          null_ls.builtins.formatting.black.with(null_ls_python_virtualenv_tool_config("black")),
          null_ls.builtins.formatting.isort.with(null_ls_python_virtualenv_tool_config("isort")),
          null_ls.builtins.diagnostics.flake8.with(null_ls_python_virtualenv_tool_config("flake8")),
          null_ls.builtins.diagnostics.pylint.with(null_ls_python_virtualenv_tool_config("pylint")),
          -- null_ls.builtins.diagnostics.mypy,
          -- null_ls.builtins.formatting.black,
          -- null_ls.builtins.formatting.isort,
          -- null_ls.builtins.diagnostics.flake8,
          -- null_ls.builtins.diagnostics.pylint,
        },
      })
    end,
  },
}

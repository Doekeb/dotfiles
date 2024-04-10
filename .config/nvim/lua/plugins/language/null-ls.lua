-- return {}
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
  config = function()
    local null_ls = require("null-ls")
    --- This is so we can tweak how these tools run with virtual environments
    local flake8 = require("none-ls.diagnostics.flake8")
    null_ls.python_sources = {
      -- null_ls.builtins.diagnostics.flake8, -- (Deprecated: https://github.com/nvimtools/none-ls.nvim/discussions/81)
      flake8.with({ extra_args = { "--max-line-length", "88" } }),
      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.diagnostics.pylint,
    }
    null_ls.setup({
      -- debug = true,
    })
    null_ls.register(null_ls.python_sources)

    vim.api.nvim_create_user_command("NullLsStop", function(input)
      null_ls.disable(input.args)
    end, { desc = "disable null-ls source", nargs = "?" })

    vim.api.nvim_create_user_command("NullLsStart", function(input)
      null_ls.enable(input.args)
    end, { desc = "disable null-ls source", nargs = "?" })
  end,
}

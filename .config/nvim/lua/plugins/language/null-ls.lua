return {
  -- {
  -- 	"jay-babu/mason-null-ls.nvim",
  -- 	event = { "BufReadPre", "BufNewFile" },
  -- 	dependencies = { "williamboman/mason.nvim" },
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"stylua",
  -- 			"mypy",
  -- 			"black",
  -- 			"isort",
  -- 			"flake8",
  -- 			"pylint",
  -- 		},
  -- 	},
  -- },

  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
  config = function()
    local null_ls = require("null-ls")
    --- This is so we can tweak how these tools run with virtual environments
    local flake8 = require("none-ls.diagnostics.flake8")
    null_ls.python_sources = {
      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      -- null_ls.builtins.diagnostics.flake8, -- (Deprecated: https://github.com/nvimtools/none-ls.nvim/discussions/81)
      flake8,
      null_ls.builtins.diagnostics.pylint,
    }
    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })
    null_ls.register({ sources = null_ls.python_sources })
  end,
}

return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
	config = function()
		local null_ls = require("null-ls")
		--- This is so we can tweak how these tools run with virtual environments
		local flake8 = require("none-ls.diagnostics.flake8")
		null_ls.python_sources = {
			-- null_ls.builtins.diagnostics.flake8, -- (Deprecated: https://github.com/nvimtools/none-ls.nvim/discussions/81)
			flake8,
			null_ls.builtins.diagnostics.mypy,
			null_ls.builtins.diagnostics.pylint,
		}
		null_ls.setup({
			-- debug = true,
		})
		null_ls.register(null_ls.python_sources)
	end,
}

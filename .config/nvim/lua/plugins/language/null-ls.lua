return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim" },
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
				},
			})
			null_ls.register({
				name = "python_tools",
				sources = {
					null_ls.builtins.diagnostics.mypy,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.diagnostics.flake8,
					null_ls.builtins.diagnostics.pylint,
				},
			})
		end,
	},
}

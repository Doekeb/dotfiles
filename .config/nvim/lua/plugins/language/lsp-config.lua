return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				-- "ruff_lsp",
				"pylsp",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "folke/neodev.nvim" },
		config = function()
			require("neodev").setup({})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			-- lspconfig.ruff_lsp.setup({})
      -- This is so we can use it in virtual environment setup
			lspconfig.pylsp_config = { capabilities = capabilities }
			lspconfig.pylsp.setup(lspconfig.pylsp_config)

			-- Make all floating windows have borders
			local _open_floating_preview = vim.lsp.util.open_floating_preview
			vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or "rounded"
				return _open_floating_preview(contents, syntax, opts, ...)
			end
			vim.keymap.set("n", "K", vim.lsp.buf.hover)
			vim.diagnostic.config({ float = { source = true } })
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		end,
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = { "folke/neodev.nvim" },
	config = function()
		require("neodev").setup({})
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")
		local on_attach = function(client, bufnr)
			local map = function(mode, lhs, rhs, desc)
				local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
				vim.keymap.set(mode, lhs, rhs, opts)
			end
			map("n", "K", vim.lsp.buf.hover, "show hover help")
			map("n", "<leader>e", vim.diagnostic.open_float, "show [e]rrors")
			map("n", "gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
			map("n", "gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
			map("n", "gr", require("telescope.builtin").lsp_references, "[g]o to [r]eferences")
			map("n", "<leader>gf", require("conform").format, "[g]o [f]ormat")
		end

		-- Monkeypatch to make all floating windows have borders
		local _open_floating_preview = vim.lsp.util.open_floating_preview
		vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			return _open_floating_preview(contents, syntax, opts, ...)
		end

		-- Show diagnostic source
		vim.diagnostic.config({ float = { source = true } })

		lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })
		lspconfig.biome.setup({ capabilities = capabilities, on_attach = on_attach, single_file_support = true })

		-- This is so we can use it in virtual environment setup
		lspconfig.pylsp_config = {
			capabilities = capabilities,
			-- cmd = {
			-- 	"/home/doeke/Projects/python-lsp-server/.venv/bin/pylsp",
			-- 	"-vv",
			-- 	"--log-file",
			-- 	"/home/doeke/my_pylsp_log.txt",
			-- },
			settings = {
				pylsp = {
					plugins = {
						autopep8 = { enabled = false },
						flake8 = { enabled = false },
						mccabe = { enabled = false },
						preload = { enabled = false },
						pycodestyle = { enabled = false },
						pydocstyle = { enabled = false },
						pyflakes = { enabled = false },
						pylint = { enabled = false },
						rope_autoimport = {
							enabled = false,
							completions = { enabled = false },
							code_actions = { enabled = false },
						},
						rope_completion = { enabled = false },
						yapf = { enabled = false },
					},
				},
			},
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				local colorcolumn = "89"
				for i = 90, 1000 do
					colorcolumn = colorcolumn .. "," .. i
				end
				vim.opt_local.colorcolumn = colorcolumn
			end,
		}
		lspconfig.pylsp.setup(lspconfig.pylsp_config)
	end,
}

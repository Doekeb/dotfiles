local null_ls_python_venv_tool_config = function(venv_path, tool_name)
	local config = {}
	local command = venv_path .. "/bin/" .. tool_name
	if os.rename(command, command) then
		config.command = command
	end
	return config
end

return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "nvimtools/none-ls.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local null_ls_hook = function(venv_path, _)
			null_ls.disable("python_tools")
			null_ls.register({
				name = "python_venv_tools",
				cwd = function()
					vim.fn.getcwd()
				end,
				sources = {
					null_ls.builtins.diagnostics.mypy.with(null_ls_python_venv_tool_config(venv_path, "mypy")),
					null_ls.builtins.formatting.black.with(null_ls_python_venv_tool_config(venv_path, "black")),
					null_ls.builtins.formatting.isort.with(null_ls_python_venv_tool_config(venv_path, "isort")),
					null_ls.builtins.diagnostics.flake8.with(null_ls_python_venv_tool_config(venv_path, "flake8")),
					null_ls.builtins.diagnostics.pylint.with(null_ls_python_venv_tool_config(venv_path, "pylint")),
				},
			})
		end
		require("venv-selector").setup({ name = { "venv", ".venv" }, changed_venv_hooks = { null_ls_hook } })
	end,
	event = "VeryLazy",
	keys = {
		{ "<leader>vs", "<cmd>VenvSelect<cr>" },
		{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
	},
}

local null_ls_python_venv_tool_config = function(venv_path, tool_name)
	local config = {}
	local command = venv_path .. "/bin/" .. tool_name
	if os.rename(command, command) then
		config.command = command
		config.name = tool_name .. " (venv)"
	end
	return config
end

return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "nvimtools/none-ls.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local null_ls_hook = function(venv_path, _)
			-- Disable python tools so we can re-register them from correct working directory and executable
			local python_venv_sources = {}
			for k, source in ipairs(null_ls.python_sources) do
				null_ls.disable(source.name)
				python_venv_sources[k] = source.with(null_ls_python_venv_tool_config(venv_path, source.name))
			end
			null_ls.register({
				cwd = function()
					vim.fn.getcwd()
				end,
				sources = python_venv_sources,
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

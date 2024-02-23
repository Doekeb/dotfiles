return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "linux-cultist/venv-selector.nvim" },
	opts = {
		options = { theme = "auto" },
		sections = {
			lualine_y = {
				function()
					return require("venv-selector").get_active_venv() or "no virtual environment"
				end,
			},
		},
	},
}

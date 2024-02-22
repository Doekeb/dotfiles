return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			pickers = { colorscheme = { enable_preview = true } },
			extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown({}) } },
		})
		telescope.load_extension("ui-select")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) -- [f]ind [f]iles
		vim.keymap.set("n", "<leader>fif", builtin.live_grep, {}) -- [f]ind [i]n [f]iles
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {}) -- [f]ind [b]uffers
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {}) -- [f]ind [h]elp
		vim.keymap.set("n", "<leader>fr", builtin.registers, {}) -- [f]ind [r]egisters
		vim.keymap.set("n", "<leader>fc", builtin.commands, {}) -- [f]ind [c]ommands
		vim.keymap.set("n", "<leader>ft", builtin.builtin, {}) -- [f]ind [t]elescope

		vim.keymap.set("n", "<leader>fgb", builtin.git_branches, {}) -- [f]ind [g]it [b]ranches
		vim.keymap.set("n", "<leader>fgc", builtin.git_commits, {}) -- [f]ind [g]it [c]ommits
		vim.keymap.set("n", "<leader>fgs", builtin.git_stash, {}) -- [f]ind [g]it [s]tash

		-- Launch telescope on startup
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if vim.fn.argv(0) == "" then
					builtin.find_files()
				end
			end,
		})
	end,
}

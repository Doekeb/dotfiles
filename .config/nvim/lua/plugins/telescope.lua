return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "aznhe21/actions-preview.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions_preview = require("actions-preview")
    local themes = require("telescope.themes")
    local diffview = require("diffview")

    local diffview_open = function(prompt_bufnr)
      local entry = require("telescope.actions.state").get_selected_entry()
      require("telescope.actions").close(prompt_bufnr)
      diffview.open({ entry.value })
    end

    telescope.setup({
      pickers = {
        colorscheme = { enable_preview = true },
        registers = { theme = "cursor" },
        commands = { theme = "ivy" },
        command_history = { theme = "ivy" },
        git_branches = { mappings = { n = { ["do"] = diffview_open } } },
        git_commits = { mappings = { n = { ["do"] = diffview_open } } },
      },
      extensions = { ["ui-select"] = { themes.get_dropdown({}) }, fzf = {} },
      defaults = {
        file_ignore_patterns = { "^docs/", "poetry.lock" },
      },
    })
    telescope.load_extension("ui-select")

    actions_preview.setup({ telescope = themes.get_ivy({}) })

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) -- [f]ind [f]iles
    vim.keymap.set("n", "<leader>fif", builtin.live_grep, {}) -- [f]ind [i]n [f]iles
    vim.keymap.set("n", "<leader>faf", function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, {}) -- [f]ind [a]ll [f]iles
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {}) -- [f]ind [b]uffers
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {}) -- [f]ind [h]elp
    vim.keymap.set("n", "<leader>fr", builtin.registers, {}) -- [f]ind [r]egisters
    vim.keymap.set("n", "<leader>fcc", builtin.commands, {}) -- [f]ind [c]ommands [c]
    vim.keymap.set("n", "<leader>fch", builtin.command_history, {}) -- [f]ind [c]ommand [h]istory
    vim.keymap.set("n", "<leader>ft", builtin.builtin, {}) -- [f]ind [t]elescope
    vim.keymap.set("n", "<leader>fe", builtin.diagnostics, {}) -- [f]ind [e]rrors
    vim.keymap.set("n", "<leader>fs", builtin.search_history, {}) -- [f]ind [s]earch history
    vim.keymap.set("n", "<leader>fj", builtin.jumplist, {}) -- [f]ind [j]umps
    vim.keymap.set("n", "<leader>fca", actions_preview.code_actions, {}) -- [f]ind [c]ode [a]ctions

    vim.keymap.set("n", "<leader>fgb", builtin.git_branches, {}) -- [f]ind [g]it [b]ranches
    vim.keymap.set("n", "<leader>fgc", builtin.git_commits, {}) -- [f]ind [g]it [c]ommits
    vim.keymap.set("n", "<leader>fgS", builtin.git_stash, {}) -- [f]ind [g]it [S]tash
    vim.keymap.set("n", "<leader>fgs", builtin.git_status, {}) -- [f]ind [g]it [s]tatus

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

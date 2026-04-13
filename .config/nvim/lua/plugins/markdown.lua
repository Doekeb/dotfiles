return {
  "MeanderingProgrammer/markdown.nvim",
  -- dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "markdown", "codecompanion" },
  config = function()
    local rm = require("render-markdown")
    rm.setup({
      file_types = { "markdown", "codecompanion" },
      headings = { "", "", "", "", "", "" },
      highlights = { heading = { backgrounds = { "DiffChange", "DiffChange", "DiffChange" } } },
    })
    vim.keymap.set("n", "<leader>tm", rm.toggle)
  end,
}

return {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local rm = require("render-markdown")
    rm.setup({
      headings = { "", "", "", "", "", "" },
      highlights = { heading = { backgrounds = { "DiffChange", "DiffChange", "DiffChange" } } },
    })
    vim.keymap.set("n", "<leader>tm", rm.toggle)
  end,
}

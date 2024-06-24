return {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local rm = require("render-markdown")
    rm.setup({})
    vim.keymap.set("n", "<leader>tm", rm.toggle)
  end,
}

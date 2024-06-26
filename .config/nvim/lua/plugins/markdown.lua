return {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local rm = require("render-markdown")
    rm.setup({
      headings = { "", "", "", "", "", "" },
      -- checkbox = {
      --   -- Character that will replace the [ ] in unchecked checkboxes
      --   unchecked = "󰄱 ",
      --   -- Character that will replace the [x] in checked checkboxes
      --   checked = "󰱒 ",
      -- },
      highlights = { heading = { backgrounds = { "DiffChange", "DiffChange", "DiffChange" } } },
    })
    vim.keymap.set("n", "<leader>tm", rm.toggle)
  end,
}

return {
  "sindrets/diffview.nvim",
  config = function()
    local diffview = require("diffview")
    diffview.setup({
      file_panel = { win_config = { position = "bottom", height = 16 } },
      view = { merge_tool = { layout = "diff4_mixed" } },
    })
    vim.keymap.set("n", "<leader>do", function()
      diffview.open({})
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>dc", function()
      diffview.close()
    end, { noremap = true, silent = true })
  end,
  opts = {
    file_panel = {
      win_config = {
        position = "bottom",
        height = 16,
      },
    },
  },
}

return {
  "echasnovski/mini.files",
  version = false,
  config = function()
    local mini_files = require("mini.files")
    mini_files.setup({ windows = { preview = true } })
    vim.keymap.set("n", "-", mini_files.open, { noremap = true })
  end,
}

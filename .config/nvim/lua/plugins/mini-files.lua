return {
  "echasnovski/mini.files",
  version = false,
  config = function()
    local mini_files = require("mini.files")
    mini_files.setup({ windows = { preview = true } })
    vim.keymap.set("n", "-", function(...)
      if not mini_files.close() then
        mini_files.open(...)
      end
    end, { noremap = true })
  end,
}

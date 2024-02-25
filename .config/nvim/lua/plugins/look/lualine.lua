return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "linux-cultist/venv-selector.nvim" },
  opts = {
    options = { theme = "auto" },
    sections = {
      lualine_c = {
        {
          "filename",
          path = 1,
          symbols = {
            modified = "[+]", -- Text to show when the file is modified.
            readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
            newfile = "[New]", -- Text to show for newly created file before first write
          },
        },
      },
      lualine_y = {
        function()
          return require("venv-selector").get_active_venv() or "no virtual environment"
        end,
      },
    },
  },
}

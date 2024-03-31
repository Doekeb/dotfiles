return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "linux-cultist/venv-selector.nvim" },
  opts = {
    options = { theme = "auto" },
    sections = {
      lualine_b = {
        function()
          return require("venv-selector").get_active_venv():gsub(vim.fn.getcwd(), "."):gsub(vim.fn.getenv("HOME"), "~")
            or "no virtual environment"
        end,
      },
      lualine_c = { "filetype" },
      lualine_x = { "diagnostics" },
      lualine_y = { "diff", "branch" },
      lualine_z = {
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
    },
  },
}

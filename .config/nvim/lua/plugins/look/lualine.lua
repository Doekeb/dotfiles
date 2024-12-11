local function regexEscape(str)
  local result = str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
  return result
end

local function replace(str, this, that)
  local t = that:gsub("%%", "%%%%") -- only % needs to be escaped for 'that'
  local result = str:gsub(regexEscape(this), t)
  return result
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "linux-cultist/venv-selector.nvim" },
  opts = {
    options = { theme = "auto" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
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
      lualine_x = {
        "diagnostics",
        function()
          return replace(replace(require("venv-selector").venv(), vim.fn.getcwd(), "."), vim.fn.getenv("HOME"), "~")
            or "no virtual environment"
        end,
      },
      lualine_c = { "filetype" },
      lualine_y = { "diff", "branch" },
      lualine_z = { "location" },
    },
  },
}

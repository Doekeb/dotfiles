local function regexEscape(str)
  local result = str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
  return result
end

local function replace(str, this, that)
  local t = that:gsub("%%", "%%%%") -- only % needs to be escaped for 'that'
  local result = str:gsub(regexEscape(this), t)
  return result
end

local filename = {
  "filename",
  path = 1,
  symbols = {
    modified = "", -- Text to show when the file is modified.
    readonly = "", -- Text to show when the file is non-modifiable or readonly.
    unnamed = "󰊠", -- Text to show for unnamed buffers.
    newfile = "", -- Text to show for newly created file before first write
  },
}
local venv = function()
  return replace(replace(require("venv-selector").venv(), vim.fn.getcwd(), "."), vim.fn.getenv("HOME"), "~")
    or "no virtual environment"
end
local diagnostics = { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } }
local diff = { "diff", symbols = { added = " ", modified = " ", removed = " " } }

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "linux-cultist/venv-selector.nvim" },
  opts = {
    options = {
      theme = require("base16-theme").lualine_theme,
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = { filename },
      lualine_c = { "filetype" },
      lualine_x = { venv },
      lualine_y = { "branch" },
      lualine_z = { "location" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { filename },
      lualine_c = { "filetype" },
      lualine_x = { venv, diagnostics },
      lualine_y = { diff, "branch" },
      lualine_z = { "location" },
    },
  },
}

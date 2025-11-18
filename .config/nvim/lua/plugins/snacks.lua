local tbl_deep_copy
tbl_deep_copy = function(t)
  if type(t) ~= "table" then
    return t
  end
  local res = {}
  for k, v in pairs(t) do
    res[k] = tbl_deep_copy(v)
  end
  return res
end

return {
  -- "folke/snacks.nvim",
  "doekeb/snacks.nvim",
  -- dir = "/home/doeke/Projects/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    local layouts = require("snacks.picker.config.layouts")

    local select_r = tbl_deep_copy(layouts.select)
    select_r["reverse"] = true
    select_r.layout[1], select_r.layout[2] = select_r.layout[2], select_r.layout[1]
    select_r.layout[2].border = "top"

    local dropdown_r = tbl_deep_copy(layouts.dropdown)
    dropdown_r["reverse"] = true
    dropdown_r.layout[2][1], dropdown_r.layout[2][2] = dropdown_r.layout[2][2], dropdown_r.layout[2][1]
    dropdown_r.layout[2][2].border = "top"

    local sidebar_r = tbl_deep_copy(layouts.sidebar)
    sidebar_r["reverse"] = true
    sidebar_r.layout[1], sidebar_r.layout[2] = sidebar_r.layout[2], sidebar_r.layout[1]

    local left_r = { preset = "sidebar_r" }
    local right_r = { preset = "sidebar_r", layout = { position = "right" } }

    require("snacks").setup({
      picker = {
        enabled = true,
        layouts = {
          select_r = select_r,
          dropdown_r = dropdown_r,
          sidebar_r = sidebar_r,
          left_r = left_r,
          right_r = right_r,
        },
        layout = function()
          return vim.o.columns >= 120 and { preset = "telescope" } or { preset = "dropdown_r" }
        end,
        win = {
          input = {
            keys = {
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<c-f>"] = { "preview_scroll_right", mode = { "i", "n" } },
              ["<c-b>"] = { "preview_scroll_left", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<c-d>"] = "preview_scroll_down",
              ["<c-u>"] = "preview_scroll_up",
              ["<c-f>"] = "preview_scroll_right",
              ["<c-b>"] = "preview_scroll_left",
            },
          },
        },
      },
    })
  end,
}

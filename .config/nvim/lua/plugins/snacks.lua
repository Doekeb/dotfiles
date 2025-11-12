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
local hack_sort = function(x, y)
  local indexes = { preview = 0, list = 1, input = 2 }
  if x.win == "input" then
    x.border = "top"
  end
  if y.win == "input" then
    y.border = "top"
  end
  return indexes[x.win] < indexes[y.win]
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
    table.sort(select_r.layout, hack_sort)
    local dropdown_r = tbl_deep_copy(layouts.dropdown)
    dropdown_r["reverse"] = true
    for _, v in ipairs(dropdown_r.layout) do
      if v.box then
        table.sort(v, hack_sort)
      end
    end
    require("snacks").setup({
      picker = {
        enabled = true,
        layouts = {
          select_r = select_r,
          dropdown_r = dropdown_r,
        },
        layout = function()
          return vim.o.columns >= 120 and { preset = "telescope" } or { preset = "dropdown_r" }
        end,
      },
    })
  end,
}
